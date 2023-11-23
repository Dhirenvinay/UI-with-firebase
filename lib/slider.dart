import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final List<String> assetImages = [
    "assets/img/slider.png",
    "assets/img/slider.png",
    "assets/img/slider.png",
  ];

  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: assetImages.length,
      viewportFraction: 1.0,
    );

    Timer.periodic(Duration(seconds: 5), (timer) {
      _pageController.animateToPage(
        _currentIndex + 1,
        duration: Duration(seconds: 1),
        curve: Curves.ease,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("data").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final datalist = snapshot.data!.docs;
            final slider = datalist[0]["slider"];
            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 200,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: PageView.builder(
                    itemCount: slider.length,
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index % slider.length as int;
                      });
                    },
                    itemBuilder: (context, index) {
                      final assetIndex = index % slider.length;
                      return Container(
                        margin: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15)),
                        child: Image.network(
                          slider[index],
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 200.0,
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 20,
                  left: MediaQuery.of(context).size.width / 2.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(assetImages.length, (index) {
                      double shapeSize = _currentIndex == index
                          ? 16.0
                          : 8.0; // Adjust the size values as needed
                      return Container(
                        width: shapeSize,
                        height: 8,
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: Container(
                          width: shapeSize,
                          decoration: BoxDecoration(
                              color: _currentIndex == index
                                  ? const Color.fromARGB(255, 17, 104, 175)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        // decoration: BoxDecoration(
                        //   shape: BoxShape.circle,
                        //   color: _currentIndex == index
                        //       ? const Color.fromARGB(255, 17, 104, 175)
                        //       : Colors.grey,
                        // ),
                      );
                    }),
                  ),
                )

                // Positioned(
                //   bottom: 20,
                //   left: MediaQuery.of(context).size.width / 2.5,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: List.generate(assetImages.length, (index) {
                //       double shapeWidth = _currentIndex == index
                //           ? 16.0
                //           : 8.0; // Adjust the width values as needed
                //       return Container(
                //         width: shapeWidth,
                //         height: 8.0,
                //         margin: EdgeInsets.symmetric(horizontal: 4.0),
                //         decoration: BoxDecoration(
                //           shape: BoxShape
                //               .circle, // Use BoxShape.rectangle for varying widths
                //           color: _currentIndex == index
                //               ? const Color.fromARGB(255, 17, 104, 175)
                //               : Colors.grey,
                //         ),
                //       );
                //     }),
                //   ),
                // )

                // Positioned(
                //   bottom: 20,
                //   left: MediaQuery.sizeOf(context).width / 2.5,
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: List.generate(assetImages.length, (index) {
                //       return Container(
                //         width: 8.0,
                //         height: 8.0,
                //         margin: EdgeInsets.symmetric(horizontal: 4.0),
                //         decoration: BoxDecoration(
                //           shape: BoxShape.rectangle,
                //           color: _currentIndex == index
                //               ? const Color.fromARGB(255, 17, 104, 175)
                //               : Colors.grey,
                //         ),
                //       );
                //     }),
                //   ),
                // ),
              ],
            );
          } else {
            return Text("no data receives");
          }
        });
  }
}
