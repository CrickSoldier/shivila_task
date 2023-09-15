import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
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

  void verifyUserPhoneNumber() {
    // userNumber = "91${phoneController.text}";
    auth.verifyPhoneNumber(
      phoneNumber: userNumber,
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
                      // height: size.height * .4,
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
                              // height: size.height * .06,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black.withOpacity(.7),
                              ),
                              child: IntlPhoneField(
                                controller: phoneController,
                                initialCountryCode: 'IN',
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: 'Mobile Number',
                                  // labelText: 'Phone',
                                  // border: OutlineInputBorder(),
                                ),
                                onChanged: (val) {
                                  userNumber = val.completeNumber;
                                },
                              ),
                            ),
                            SizedBox(
                              height: size.height * .04,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: GestureDetector(
                                onTap: () {
                                  verifyUserPhoneNumber();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => OTPView(
                                                usernumber: userNumber,
                                              )));
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
                                        "Send OTP",
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
                                  child: Text('New User?',
                                      style: GoogleFonts.quicksand(
                                          fontSize: 12, color: Colors.white)),
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
