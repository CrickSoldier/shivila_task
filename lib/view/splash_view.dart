import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shivila/view/login_view.dart';
// import 'package:shivila/constants/constants.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>
              const LoginView(), // Replace with your main app screen
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/background.jpg'), // Path to your image asset
                fit: BoxFit
                    .cover, // You can change this to control how the image is displayed
              ),
            ),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Container(
                    height: size.height * .3,
                    width: double.infinity,
                    color: Colors.black.withOpacity(.4),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "MEDIA",
                          style: GoogleFonts.sourceSerifPro(
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Text(
                          "CLINIQUE",
                          style: GoogleFonts.roboto(
                              fontSize: 60,
                              fontWeight: FontWeight.w300,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ])));
  }
}
