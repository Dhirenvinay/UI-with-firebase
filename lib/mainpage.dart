// import 'package:bjp_leader/controller/firebaseapi.dart';
// import 'package:bjp_leader/controller/home_page.dart';
// import 'package:bjp_leader/view/sceen/agenda.dart';
// import 'package:bjp_leader/view/sceen/connect.dart';
// import 'package:bjp_leader/view/sceen/event.dart';
// import 'package:bjp_leader/view/sceen/home.dart';
// import 'package:bjp_leader/view/sceen/profilescreen.dart';
import 'package:buildandinnovationassignment/Home.dart';
import 'package:flutter/material.dart';
// import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key, this.index}) : super(key: key);
  final int? index;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static List<Widget> listScreen = [
    HomeScreen(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
    SizedBox(),
  ];

  late int currentScreen; // Initialize currentScreen as a non-nullable int
  // FirebaseApi notification = FirebaseApi();
  // HomePageController homePageController = Get.put(HomePageController());

  @override
  void initState() {
    super.initState();
    // notification.notiPermission();
    // notification.firebaseInit(context);
    // notification.setupIneractMessage(context);
    // FirebaseApi().getDeviceToken();
    currentScreen = widget.index ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listScreen[currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            // icon: Image(image: AssetImage("assets/images/b1.png")),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.gif_box),
            //  icon: Image(image: AssetImage("assets/images/b2.png")),
            label: "Box",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),

            // icon: Icon(Icons.bl),
            //   icon: Image(image: AssetImage("assets/images/b3.png")),
            label: "Event",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            //  icon: Image(image: AssetImage("assets/images/b4.png")),
            label: "Connect",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile")
        ],
        // type: BottomNavigationBarType.fixed,
        selectedItemColor: Color.fromARGB(255, 15, 74, 223),
        unselectedItemColor: Colors.black,
        currentIndex: currentScreen,
        onTap: (index) {
          setState(() {
            currentScreen = index;
          });
        },
      ),
    );
  }
}
