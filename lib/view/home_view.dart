import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shivila/utils/image_list.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final List<Widget> imageSliders = sliderList
      .map((item) => Container(
            margin: const EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.asset(item, fit: BoxFit.fill, width: 1000.0),
                  ],
                )),
          ))
      .toList();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('assets/icons/drawer.png'),
                    SizedBox(
                      width: size.width * .1,
                    ),
                    Column(
                      children: [
                        Text(
                          "Home",
                          style: GoogleFonts.roboto(
                              fontSize: 16, color: Colors.white),
                        ),
                        Container(
                          height: 2,
                          width: 60,
                          color: Colors.orange,
                        )
                      ],
                    ),
                    Text(
                      "All Videos",
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w300),
                    ),
                    Text(
                      "Topics",
                      style: GoogleFonts.roboto(
                          fontSize: 16, color: Colors.white.withOpacity(.4)),
                    ),
                    SizedBox(
                      width: size.width * .15,
                    )
                  ],
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 2.5,
                    enlargeCenterPage: true,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                  ),
                  items: imageSliders,
                ),
                SizedBox(
                  height: size.height * .15,
                ),
                WatchWidget(
                  size: size,
                  height: size.height * .1,
                  width: size.width * .45,
                  sectionName: "Continue Watching",
                  sliderList: continueWatchList,
                  play: false,
                  category: false,
                  isPlaying: false,
                  progress: .5,
                ),
                SizedBox(
                  height: size.height * .025,
                ),
                WatchWidget(
                  size: size,
                  height: size.height * .1,
                  width: size.width * .30,
                  sectionName: "Top Watches",
                  sliderList: videoList,
                  play: false,
                  category: false,
                  isPlaying: false,
                  progress: .5,
                ),
                SizedBox(
                  height: size.height * .025,
                ),
                WatchWidget(
                  size: size,
                  height: size.height * .1,
                  width: size.width * .30,
                  sectionName: "Video List",
                  sliderList: videoList,
                  play: false,
                  category: false,
                  isPlaying: false,
                  progress: .5,
                ),
                SizedBox(
                  height: size.height * .025,
                ),
                WatchWidget(
                  size: size,
                  height: size.height * .08,
                  width: size.width * .30,
                  sectionName: "Watch List",
                  sliderList: watchList,
                  play: true,
                  category: false,
                  isPlaying: false,
                  progress: .5,
                ),
                SizedBox(
                  height: size.height * .025,
                ),
                WatchWidget(
                  size: size,
                  height: size.height * .08,
                  width: size.width * .30,
                  sectionName: "Play List",
                  sliderList: playList,
                  play: true,
                  category: false,
                  isPlaying: false,
                  progress: .5,
                ),
                SizedBox(
                  height: size.height * .025,
                ),
                WatchWidget(
                  size: size,
                  height: size.height * .1,
                  width: size.width * .25,
                  sectionName: "Category",
                  sliderList: categoryList,
                  play: false,
                  category: true,
                  isPlaying: false,
                  progress: .5,
                ),
                SizedBox(
                  height: size.height * .025,
                ),
                WatchWidget(
                  size: size,
                  height: size.height * .1,
                  width: size.width * .25,
                  sectionName: "Topic",
                  sliderList: topicList,
                  play: false,
                  category: true,
                  isPlaying: false,
                  progress: .5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WatchWidget extends StatelessWidget {
  const WatchWidget({
    super.key,
    required this.size,
    required this.height,
    required this.width,
    required this.sectionName,
    required this.sliderList,
    required this.progress,
    required this.isPlaying,
    required this.play,
    required this.category,
  });

  final Size size;
  final double height, width, progress;
  final String sectionName;
  final List<String> sliderList;
  final bool isPlaying, play, category;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Stack(children: [
            SizedBox(
              height: size.height * .04,
            ),
            Container(
              color: Colors.orange,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    sectionName,
                    style:
                        GoogleFonts.roboto(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                top: 20,
                child: CustomPaint(
                  size: const Size(40, 40), // Size of the canvas
                  painter: TrianglePainter(),
                )),
          ]),
          const Spacer(),
          Text(
            "See all",
            style: GoogleFonts.roboto(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
          )
        ],
      ),
      SizedBox(
        height: size.height * .12,
        child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: sliderList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Container(
                      height: height,
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: AssetImage(
                              sliderList[index],
                            ),
                            fit: BoxFit.cover),
                      ),
                      child: play
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      Container(
                                        width: 30,
                                        height: 30,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            isPlaying
                                                ? Icons.pause
                                                : Icons.play_arrow,
                                            size: 15,
                                            shadows: const <Shadow>[
                                              Shadow(
                                                color: Colors.black,
                                                blurRadius: 5.0,
                                              )
                                            ],
                                            color: Colors.orange,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          value: progress,
                                          strokeWidth: .5,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                  Color>(Colors.orange),
                                          backgroundColor:
                                              Colors.black.withOpacity(.5),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          : category
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  // crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          width: double.infinity,
                                          color: Colors.white,
                                          child: Center(
                                            child: Text(
                                              "Tamil",
                                              style: GoogleFonts.roboto(
                                                  fontSize: 12),
                                            ),
                                          ),
                                        )),
                                  ],
                                )
                              : const SizedBox()),
                  SizedBox(
                    width: size.width * .02,
                  )
                ],
              );
            }),
      )
    ]);
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    double halfWidth = size.width / 2;
    double height = size.height;
    double sideLength = sqrt(3) / 2 * height; // Length of each side
    // Calculate the rotation matrix
    const radians = 140 * pi / 180;
    final rotationMatrix = Matrix4.identity()
      ..translate(halfWidth, height / 2) // Move to the center of the triangle
      ..rotateZ(radians) // Rotate by the specified angle
      ..translate(
          -halfWidth, -height / 2); // Move back to the original position

    canvas.transform(rotationMatrix.storage);
    Path path = Path()
      ..moveTo(halfWidth, 0) // Top vertex
      ..lineTo(halfWidth - sideLength / 2, height) // Bottom-left vertex
      ..lineTo(halfWidth + sideLength / 2, height) // Bottom-right vertex
      ..close(); // Close the path to complete the triangle

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
