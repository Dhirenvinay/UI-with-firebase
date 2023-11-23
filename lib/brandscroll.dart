import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BrandScroll extends StatelessWidget {
  const BrandScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("data").snapshots(),
        builder: (context, snapshot) {
          final listdata = snapshot.data!.docs;
          final data = listdata[0]["Cards"];
          print("before listview $data");

          if (snapshot.hasData) {
            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  print("the lenght is ${data.length}");
                  print("the data is ${listdata[0]["Cards"][2]["amount"]}");

                  return Card(
                    color: Colors.white,
                    elevation: 5.0,
                    child: GestureDetector(
                      onTap: () {
                        print("working before");

                        print("Working Tab bar");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 7.0, left: 7, bottom: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    data[index]['img'],
                                    fit: BoxFit.cover,
                                    // he
                                  ),
                                ),
                              ),
                              Text(data[index]["title"],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  )),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(data[index]["amount"],
                                    style: const TextStyle(
                                        fontSize: 9,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black)),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Text("Error Retriving Data");
          }
        });
  }
}
