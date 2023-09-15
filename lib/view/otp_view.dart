import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shivila/view/home_view.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key, required this.usernumber});
  final String usernumber;

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
  final TextEditingController otp1 = TextEditingController();
  final TextEditingController otp2 = TextEditingController();
  final TextEditingController otp3 = TextEditingController();
  final TextEditingController otp4 = TextEditingController();
  final TextEditingController otp5 = TextEditingController();
  final TextEditingController otp6 = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  Timer? countdownTimer;
  Duration myDuration = const Duration(seconds: 90);
  final signIn = GetStorage();
  final allUserData = GetStorage();
  bool isUserRegistered = false;

  // String userNumber = '';
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
    verifyUserPhoneNumber();
  }

  void verifyUserPhoneNumber() {
    // userNumber = "91${phoneController.text}";
    auth.verifyPhoneNumber(
      phoneNumber: widget.usernumber,
      timeout: const Duration(seconds: 90),
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then(
              (value) => print('Signup Successfully'),
            );
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
          // startTimer();
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
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

  Future<void> verifyOTPCode() async {
    String smsCode =
        otp1.text + otp2.text + otp3.text + otp4.text + otp5.text + otp6.text;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: receivedID,
      smsCode: smsCode,
    );
    try {
      await auth.signInWithCredential(credential).then((value) => {
            signIn.write('isSignIn', true),
            // userSetup(),
            if (otpSentWait)
              {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomeView()))
              }
          });
    } on FirebaseAuthException catch (e) {
      otpSentWait = true;
      setState(() {});
      Fluttertoast.showToast(msg: 'Incorrect OTP: ${e.message}');
    }
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
                      height: size.height * .04,
                    ),
                    Container(
                      // height: size.height * .4,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(.4),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Otp Verification",
                                  style: GoogleFonts.robotoMono(
                                      fontSize: 33,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )
                              ],
                            ),
                            // RichText(
                            //     text: TextSpan(
                            //   style: const TextStyle(
                            //     fontSize: 18.0,
                            //     color: Colors.white,
                            //   ),
                            //   children: [
                            //     TextSpan(
                            //         text: "Sign-in",
                            //         style: GoogleFonts.quicksand(
                            //             fontSize: 16,
                            //             fontWeight: FontWeight.bold)),
                            //     TextSpan(
                            //         text: " and Enjoy",
                            //         style: GoogleFonts.quicksand(
                            //           fontSize: 16,
                            //         ))
                            //   ],
                            // )),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                  "This Verification is essential for 2-Step Verification and making your account secure in any case of loss. ",
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.quicksand(
                                      fontSize: 14, color: Colors.white)),
                            ),
                            SizedBox(
                              height: size.height * .05,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: size.height * .05,
                                  width: size.width * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                  child: TextField(
                                    // maxLength: 1,
                                    style: const TextStyle(color: Colors.white),
                                    controller: otp1,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Container(
                                  height: size.height * .05,
                                  width: size.width * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                  child: TextField(
                                    // maxLength: 1,
                                    style: const TextStyle(color: Colors.white),

                                    controller: otp2,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Container(
                                  height: size.height * .05,
                                  width: size.width * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                  child: TextField(
                                    // maxLength: 1,
                                    style: const TextStyle(color: Colors.white),

                                    controller: otp3,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Container(
                                  height: size.height * .05,
                                  width: size.width * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                  child: TextField(
                                    // maxLength: 1,
                                    style: const TextStyle(color: Colors.white),

                                    controller: otp4,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Container(
                                  height: size.height * .05,
                                  width: size.width * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                  child: TextField(
                                    // maxLength: 1,
                                    style: const TextStyle(color: Colors.white),

                                    controller: otp5,
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                                Container(
                                  height: size.height * .05,
                                  width: size.width * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                  child: TextField(
                                    // maxLength: 1,
                                    controller: otp6,
                                    style: const TextStyle(color: Colors.white),
                                    keyboardType: TextInputType.number,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Text("Resend OTP",
                                  style: GoogleFonts.quicksand(
                                      fontSize: 14,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Text(
                                  "The OTP has been sent to your personal number ending with XXXX please Do not share it with others.",
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    color: Colors.white,
                                  )),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: GestureDetector(
                                onTap: () {
                                  verifyOTPCode();
                                  setState(() {});
                                },
                                child: Container(
                                  height: size.height * .06,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color:
                                        const Color.fromARGB(255, 212, 175, 55),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Complete",
                                        style: GoogleFonts.quicksand(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Image.asset("assets/icons/right.png")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * .02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Container(
                                height: size.height * .06,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black.withOpacity(.2),
                                ),
                                child: Center(
                                  child: Text(
                                    "Having Issue? Change Number ! ",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.quicksand(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
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
                    ),
                  ]),
            ),
          )),
    ));
  }
}
