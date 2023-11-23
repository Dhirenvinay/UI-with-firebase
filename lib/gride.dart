import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class GridBuilderView extends StatefulWidget {
  @override
  _GridBuilderViewState createState() => _GridBuilderViewState();
}

class _GridBuilderViewState extends State<GridBuilderView> {
  // bool isExpanded = false;

  final List<Map<String, String>> items = [
    {"image": "assets/img/beared.png", "text": "Hair Cut"},
    {"image": "assets/img/beared.png", "text": "Makeup"},
    {"image": "assets/img/beared.png", "text": "Straightening"},
    {"image": "assets/img/beared.png", "text": "Man-Padi"},
    {"image": "assets/img/beared.png", "text": "Spa/Message"},
    {"image": "assets/img/beared.png", "text": "Beared Trimming"},
  ];

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    // print(width);
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: Colors.blue,
            // decoration: BoxDecoration(
            //   color: Colors.blue,
            //     // color: Color(0xffFDF1EA),
            //     borderRadius: BorderRadius.circular(12)
            //
            //     // : BorderRadius.only(
            //     //     topLeft: Radius.circular(10),
            //     //     topRight: Radius.circular(10),
            //     //   ),
            //     ),
            height: 300,
            //height: isExpanded == true ? height / 3 : height / 4,
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                // if (index == 7 && !isExpanded) {
                return GestureDetector(
                  onTap: () {
                    // setState(() {
                    //   // isExpanded = true;
                    // });
                  },
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 80,
                        width: 80,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: const Color.fromARGB(255, 221, 219, 219),
                        ),
                        child: Image.asset(
                          items[index]["image"]!,
                          fit: BoxFit.contain,

                          // height: width * 0.10,
                          // width: width * 0.10,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: Text(
                          items[index]["text"]!,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.center, // Center the text
                        ),
                      ),
                    ],
                  ),
                );
                //  else if (index >= 8 && isExpanded) {
                //   if (index == items.length - 1) {
                //     return GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           isExpanded = false;
                //         });
                //       },
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.start,
                //         children: [
                //           Container(
                //             height: width * 0.18,
                //             width: width * 0.18,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(10),
                //               color: Color(0xffFFFFFF),
                //             ),
                //             child: Padding(
                //               padding: const EdgeInsets.all(15),
                //               child: Container(
                //                 child: Image(
                //                   image: AssetImage(items[index]["image"]!),
                //                   height: 10,
                //                   width: 10,
                //                 ),
                //               ),
                //             ),
                //           ),
                //           SizedBox(
                //             height: 5,
                //           ),
                //           Expanded(
                //             child: Text(
                //               "More",
                //               style: TextStyle(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.w700,
                //               ),
                //               textAlign: TextAlign.center, // Center the text
                //             ),
                //           ),

                //           // Container(
                //           //   height: width * 0.18,
                //           //   width: width * 0.18,
                //           //   decoration: BoxDecoration(
                //           //     borderRadius: BorderRadius.circular(10),
                //           //   ),
                //           //   child: ClipRRect(
                //           //     borderRadius: BorderRadius.circular(10),
                //           //     child: Image.asset(
                //           //       items[index]["image"]!,
                //           //       height: width * 0.05,
                //           //       width: width * 0.05,
                //           //       fit: BoxFit.cover,
                //           //     ),
                //           //   ),
                //           // ),
                //           // Expanded(
                //           //   child: Text(
                //           //     "More",
                //           //     style: TextStyle(
                //           //       fontSize: 15,
                //           //       fontWeight: FontWeight.w700,
                //           //     ),
                //           //     textAlign: TextAlign.center, // Center the text
                //           //   ),
                //           // ),
                //         ],
                //       ),
                //     );
                //   } else {
                //     return GestureDetector(
                //       onTap: () {
                //         setState(() {
                //           isExpanded = false;
                //         });
                //       },
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Container(
                //             height: width * 0.18,
                //             width: width * 0.18,
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(10),
                //               color: Color(0xffFFFFFF),
                //             ),
                //             child: Image.asset(
                //               items[index]["image"]!,
                //               // height: width * 0.10,
                //               // width: width * 0.10,
                //             ),
                //           ),
                //           Expanded(
                //             child: Text(
                //               items[index]["text"]!,
                //               style: TextStyle(
                //                 fontSize: 12,
                //                 fontWeight: FontWeight.w700,
                //               ),
                //               maxLines: 2,
                //               textAlign: TextAlign.center, // Center the text
                //             ),
                //           ),
                //         ],
                //       ),
                //     );
                //   }
                // } else {
                //   return Column(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     children: [
                //       Container(
                //         height: width * 0.18,
                //         width: width * 0.18,
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           color: Color(0xffFFFFFF),
                //         ),
                //         child: Image.asset(
                //           items[index]["image"]!,
                //           // height: width * 0.10,
                //           // width: width * 0.10,
                //         ),
                //       ),
                //       Expanded(
                //         child: Text(
                //           items[index]["text"]!,
                //           style: TextStyle(
                //             fontSize: 12,
                //             fontWeight: FontWeight.w700,
                //           ),
                //           textAlign: TextAlign.center, // Center the text
                //         ),
                //       ),
                //     ],
                //   );
                // }
              },
            ),
          ),
        ],
      ),
    );
  }
}
