import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shivila/view/otp_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // final allUserData = GetStorage();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 90);
  final signIn = GetStorage();
  final allUserData = GetStorage();
  bool isUserRegistered = false;

  String userNumber = '';
  String userToken = '';

  FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  var otpFieldVisibility = false;
  var otpSentWait = true;
  var resendOtpVisibility = false;
  var receivedID = '';
  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    // if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      setState(() {
        userToken = token!;
      });
      print(token);
    });
  }

  void startTimer() {
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        resendOtpVisibility = true;
        countdownTimer!.cancel();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  void validatePhoneNumber(BuildContext context) {
    if (userNumber.isEmpty || userNumber.length < 10) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Oh you missed it!',
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 28),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Please enter a valid phone number?',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 38, 11, 126),
                  // onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    } else {
      userRegistered();
    }
  }

  void verifyUserPhoneNumber() {
    auth.verifyPhoneNumber(
      phoneNumber: userNumber,
      timeout: const Duration(seconds: 90),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) => {
              // setState(() {}),
            });
      },
      verificationFailed: (FirebaseAuthException e) {
        otpSentWait = true;
        setState(() {});
        print(e.message);
        Fluttertoast.showToast(msg: 'Verification failed: ${e.message}');
      },
      codeSent: (String verificationId, int? resendToken) {
        receivedID = verificationId;
        otpFieldVisibility = true;
        otpSentWait = true;
        Fluttertoast.showToast(msg: 'Verification code sent');

        setState(() {
          startTimer();
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        //         otpSentWait = true;
        // setState(() {});
      },
    );
  }

  void resendOtp() {
    otpSentWait = false;
    setState(() {});
    verifyUserPhoneNumber();
  }

  Future<void> verifyOTPCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID,
      smsCode: otpController.text,
    );
    try {
      await auth.signInWithCredential(credential).then((value) => {
            signIn.write('isSignIn', true),
            userData(),
            if (otpSentWait && isUserRegistered)
              {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const OTPView())),
              }
            else
              {
                Fluttertoast.showToast(
                    msg:
                        'This number is not registered! Please Sign Up first!'),
              }
          });
    } on FirebaseAuthException catch (e) {
      otpSentWait = true;
      setState(() {});
      Fluttertoast.showToast(msg: 'Verification failed: ${e.message}');
    }
  }

  Future<void> userRegistered() async {
    // CollectionReference reference =
    await FirebaseFirestore.instance
        .collection('Users')
        .where('phoneNumber', isEqualTo: userNumber)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        setState(() {
          isUserRegistered = true;
        });
      } else {
        setState(() {
          isUserRegistered = false;
        });
      }
    });

    if (isUserRegistered) {
      otpSentWait = false;
      setState(() {});
      verifyUserPhoneNumber();
      // ignore: use_build_context_synchronously
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Hold On!',
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 28),
            ),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'We are checking that You are not a Robot for Security Reasons! \n \nPlease wait...',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 38, 11, 126),
                  // onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const Text("Ok"),
              ),
            ],
          );
        },
      );
    } else {
      Fluttertoast.showToast(
          msg: 'This number is NOT Registered with us! Please Sign Up first!');
    }
  }

  Future<void> userData() async {
    // CollectionReference reference =
    User userAuth = FirebaseAuth.instance.currentUser!;
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userAuth.uid)
        .update({
      "deviceToken": userToken,
    });

    await FirebaseFirestore.instance
        .collection('Users')
        .where('phoneNumber', isEqualTo: userNumber)
        .get()
        .then((value) {
      // allUserData.write("firstName", value.docs[0]['firstName']);
      // allUserData.write("lastName", value.docs[0]['lastName']);
      // allUserData.write("phoneNumber", value.docs[0]['phoneNumber']);
      // allUserData.write("uid", value.docs[0]['uid']);
    }).onError((error, stackTrace) {
      setState(() {
        isUserRegistered = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: SafeArea(
      child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/background.jpg'), // Path to your image asset
              fit: BoxFit
                  .cover, // You can change this to control how the image is displayed
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SingleChildScrollView(
              child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Container(
                      height: size.height * .16,
                      width: size.width * .6,
                      // color: Colors.black.withOpacity(.4),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black
                              .withOpacity(.1), // Set the border color
                          width: 5.0, // Set the border width
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "MEDIA",
                            style: GoogleFonts.sourceSerifPro(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                const Shadow(
                                  color: Colors.black, // Shadow color
                                  offset: Offset(2,
                                      2), // Offset of the shadow (horizontal, vertical)
                                  blurRadius: 4, // Blur radius of the shadow
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "CLINIQUE",
                            style: GoogleFonts.roboto(
                              fontSize: 25,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              shadows: [
                                const Shadow(
                                  color: Colors.black, // Shadow color
                                  offset: Offset(2,
                                      2), // Offset of the shadow (horizontal, vertical)
                                  blurRadius: 4, // Blur radius of the shadow
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // child: ,
                    ),
                    SizedBox(
                      height: size.height * .03,
                    ),
                    Text(
                      "Enjoy Over 100,000 Movies and Series Only On One Place.",
                      style: GoogleFonts.quicksand(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: size.height * .05,
                    ),
                    Container(
                      height: size.height * .4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 30),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                                text: TextSpan(
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                              children: [
                                TextSpan(
                                    text: "Sign-in",
                                    style: GoogleFonts.quicksand(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: " and Enjoy",
                                    style: GoogleFonts.quicksand(
                                      fontSize: 16,
                                    ))
                              ],
                            )),
                            Text(
                                "thousands of Movies and Series from our library.",
                                style: GoogleFonts.quicksand(
                                    fontSize: 16, color: Colors.white)),
                            SizedBox(
                              height: size.height * .05,
                            ),
                            Container(
                              height: size.height * .06,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(.7),
                              ),
                              child: TextField(
                                controller: otpController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: Colors.white.withOpacity(.6),
                                  ),
                                  hintText: 'Mobile Number',
                                  labelText: 'Mobile Number',
                                  // border: OutlineInputBorder(),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .08,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    height: 1,
                                    // width: size.width * .25,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  flex: 1,
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const OTPView()),
                                      );
                                    },
                                    child: Text('New User?',
                                        style: GoogleFonts.quicksand(
                                            fontSize: 12, color: Colors.white)),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    height: 1,
                                    // width: size.width * .25,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                            //   "MEDIA",
                            //   style: GoogleFonts.sourceSerifPro(
                            //       fontSize: 70,
                            //       fontWeight: FontWeight.bold,
                            //       color: Colors.white),
                            // ),
                            // Text(
                            //   "CLINIQUE",
                            //   style: GoogleFonts.roboto(
                            //       fontSize: 60,
                            //       fontWeight: FontWeight.w300,
                            //       color: Colors.white),
                            // ),
                          ],
                        ),
                      ),
                    )
                  ]),
            ),
          )),
    ));
  }
}
