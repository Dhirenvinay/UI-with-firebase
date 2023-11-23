import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WorksListBuilder extends StatelessWidget {
  // WorksListBuilder({super.key});
  WorksListBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('data').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final listdata = snapshot.data!.docs;
            final data = listdata[0]["all"];
            // print("before listview $data");
            return SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    // print("the lenght is ${data.length}");
                    // print("the data is ${listdata[0]["Cards"][2]["amount"]}");
                    return Container(
                      color: const Color.fromARGB(255, 245, 241, 241),
                      height: 170,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(data[index]["img"]),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(data[index]["title"]),
                                    // SizedBox(
                                    //   width: 40,
                                    // ),
                                    // Expanded(child: SizedBox()),
                                    Icon(Icons.badge),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  data[index]['location'],
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // IconButton(
                                    //     onPressed: () {},
                                    //     icon: ),
                                    Icon(Icons.location_pin),
                                    Text(data[index]['distance'])
                                  ],
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  // mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.star), //),
                                    Text("|"),
                                    Text(" ${data[index]['reviews']} Reviews"),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            );
          } else {
            return Text("Error Retriving Data");
          }
        });
  }
}
