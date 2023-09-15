import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shivila/view/home_view.dart';

class OTPView extends StatefulWidget {
  const OTPView({super.key});

  @override
  State<OTPView> createState() => _OTPViewState();
}

class _OTPViewState extends State<OTPView> {
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
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
                                  )),
                              Container(
                                  height: size.height * .05,
                                  width: size.width * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.7),
                                  )),
                              Container(
                                  height: size.height * .05,
                                  width: size.width * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.7),
                                  )),
                              Container(
                                  height: size.height * .05,
                                  width: size.width * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.7),
                                  )),
                              Container(
                                  height: size.height * .05,
                                  width: size.width * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.7),
                                  )),
                              Container(
                                  height: size.height * .05,
                                  width: size.width * .12,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black.withOpacity(.7),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: size.height * .02,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                            padding: const EdgeInsets.symmetric(horizontal: 25),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const HomeView()));
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
                            padding: const EdgeInsets.symmetric(horizontal: 25),
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
                  )
                ]),
          )),
    ));
  }
}
