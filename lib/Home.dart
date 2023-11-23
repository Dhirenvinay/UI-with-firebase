import 'package:buildandinnovationassignment/brandscroll.dart';
import 'package:buildandinnovationassignment/filterbutton.dart';
import 'package:buildandinnovationassignment/gride.dart';
import 'package:buildandinnovationassignment/slider.dart';
import 'package:buildandinnovationassignment/worklist.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  // Map<String, dynamic>? profiledata;
  Future<Map<String, dynamic>>?
      profiledata; // Change the type to Future<Map<String, dynamic>>

  Future<Map<String, dynamic>> getUser() async {
    CollectionReference profileCollection =
        FirebaseFirestore.instance.collection('data');
    QuerySnapshot profileDataQuery = await profileCollection.get();
    if (profileDataQuery.docs.isNotEmpty) {
      Map<String, dynamic> profileData =
          profileDataQuery.docs.first.data() as Map<String, dynamic>;
      return profileData;
    } else {
      return {}; // Handle the case when the collection is empty
    }
  }
  // var profiledata;
  //Firestore.instance.collection("listofprods").document('ac1').snapshots();
  // final profiledata = snapshot.data!.docs;

  // Future<String?> getUser() async {
  //   // try {
  //   CollectionReference profileCollection =
  //       FirebaseFirestore.instance.collection('data');
  //   QuerySnapshot profileDataQuery = await profileCollection.get();
  //   if (profileDataQuery.docs.isNotEmpty) {
  //     List profileDataList = profileDataQuery.docs.map((document) {
  //       Map<String, dynamic> data = document.data() as Map<String, dynamic>;
  //       // profiledata = data['Profile'];
  //       print("the function userget data is ${data['Profile']['name']}");
  //       return data['Profile'];
  //     }).toList();

  //     // Process and display the data as needed
  //   } else {
  //     print("not working");
  //     // Handle the case when the collection is empty
  //   }

  //   // return Text(data);

  //   // CollectionReference users = FirebaseFirestore.instance.collection("data");
  //   // final snapshot = await users.doc().get();
  //   // print("the snapshot in getuser is $snapshot");
  //   // final data = snapshot.data() as Map<String, dynamic>;
  //   // print("the future profile ${data['Profile']}");
  //   // return data;
  //   // } catch (e) {
  //   //   return 'Error fetching user';
  //   // }
  // }
  // Future<Map<String, dynamic>> getUser() async {
  //   CollectionReference profileCollection =
  //       FirebaseFirestore.instance.collection('data');
  //   QuerySnapshot profileDataQuery = await profileCollection.get();
  //   if (profileDataQuery.docs.isNotEmpty) {
  //     Map<String, dynamic> profileData =
  //         profileDataQuery.docs.first.data() as Map<String, dynamic>;
  //     print("inside if ${profileData['Profile']['img']}");
  //     return profileData;
  //   }
  //   return;
  //   //  else {
  //   //   return null; // Handle the case when the collection is empty
  //   // }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profiledata = getUser();
    // profiledata = getUser();
    print("the init of getuser $profiledata");
//    getUser();
  }

  @override
  Widget build(BuildContext context) {
    // print("the data in home snapshot is ${snapshot[0]["Profile"]}");
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 30, right: 16, left: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              FutureBuilder<Map<String, dynamic>>(
                  future: profiledata,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      Map<String, dynamic> profileData = snapshot.data!;

                      String imageUrl = profileData['Profile']['img'];
                      String name = profileData['Profile']['name'];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [const Text("Good Morning"), Text(name)],
                          ),
                          const Spacer(),
                          const Icon(Icons.notification_add),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(Icons.badge)
                        ],
                      );
                    } else {
                      return const Text("Not Wokring");
                    }
                  }),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Enter Mobile Number",
                  suffixIcon: const Icon(Icons.phone),
                  filled: true,
                  fillColor: Colors.white70,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(
                        10), // Adjust the border radius as needed
                  ),
                ),
              ),
              ImageSlider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Featured Services",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  TextButton(onPressed: () {}, child: const Text("View All"))
                ],
              ),
              const BrandScroll(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Category ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  TextButton(onPressed: () {}, child: const Text("View All"))
                ],
              ),

              GridBuilderView(),
              const Text(
                "Most Popular Services",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              const SizedBox(
                height: 5,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterButton(
                      onTap: () {
                        // selectFilter(0);
                        setState(() {
                          selectedIndex = 0;
                        });
                      },
                      colors: selectedIndex == 0
                          ? const Color(0xff0066a5)
                          : const Color.fromARGB(255, 147, 201, 236),
                      text: 'All',
                    ),
                    FilterButton(
                      onTap: () {
                        // controller.selectFilter(1);
                        setState(() {
                          selectedIndex = 1;
                        });
                      },
                      colors: selectedIndex == 1
                          ? const Color(0xff0066a5)
                          : const Color.fromARGB(255, 147, 201, 236),
                      text: 'Haircuts',
                    ),
                    FilterButton(
                      onTap: () {
                        // controller.selectFilter(2);
                        setState(() {
                          selectedIndex = 2;
                        });
                      },
                      colors: selectedIndex == 2
                          ? const Color(0xff0066a5)
                          : const Color.fromARGB(255, 147, 201, 236),
                      text: 'Make Up',
                    ),
                    FilterButton(
                      onTap: () {
                        // controller.selectFilter(3);
                        setState(() {
                          selectedIndex = 3;
                        });
                      },
                      colors: selectedIndex == 3
                          ? const Color(0xff0066a5)
                          : const Color.fromARGB(255, 147, 201, 236),
                      text: 'Manicure',
                    ),
                    FilterButton(
                      onTap: () {
                        // controller.selectFilter(4);
                        setState(() {
                          selectedIndex = 4;
                        });
                      },
                      colors: selectedIndex == 4
                          ? const Color(0xff0066a5)
                          : const Color.fromARGB(255, 147, 201, 236),
                      text: 'Button5',
                    ),
                    FilterButton(
                      onTap: () {
                        // controller.selectFilter(5);
                        setState(() {
                          selectedIndex = 5;
                        });
                      },
                      colors: selectedIndex == 5
                          ? const Color(0xff0066a5)
                          : const Color.fromARGB(255, 147, 201, 236),
                      text: 'Button6',
                    ),
                    FilterButton(
                      onTap: () {
                        // controller.selectFilter(6);
                        setState(() {
                          selectedIndex = 6;
                        });
                      },
                      colors: selectedIndex == 6
                          ? const Color(0xff0066a5)
                          : const Color.fromARGB(255, 147, 201, 236),
                      text: 'Button6',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              WorksListBuilder(),
              //     ],
              //   ),
              // ),

              // Slider(value: value, onChanged: onChanged)
            ],
          ),
        ),
      ),
    );
  }
}
