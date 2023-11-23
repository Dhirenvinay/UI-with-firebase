import 'package:buildandinnovationassignment/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static String verfy = "";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController mobileController = TextEditingController();

  TextEditingController countryController = TextEditingController();
  var phone = "";

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
            ),
            Center(
                child: Image.asset(
              "assets/img/loginpic.png",
              height: MediaQuery.sizeOf(context).height * 0.4,
              width: MediaQuery.sizeOf(context).width / 1.2,
            )),
            SizedBox(
              child: Stack(
                children: [
                  // SizedBox(he)
                  Container(
                    // height: 200,
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 30, right: 15, left: 15),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 40, bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 220, 217, 217),
                          width: 2),
                      borderRadius: BorderRadius.circular(15),
                      // color: Colors.white,
                    ),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          // controller: mobileController,
                          onChanged: (value) {
                            phone = value;
                          },
                          keyboardType: TextInputType.phone,
                          // keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: "Enter Mobile Number",
                              suffixIcon: Icon(Icons.phone)),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        InkWell(
                          onTap: () async {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '${countryController.text + phone}',
                              verificationCompleted:
                                  (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                LoginScreen.verfy = verificationId;
                                print(
                                    "the verification id is in id $verificationId,");
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => OtpScreen()));
                                // Navigator.pushNamed(context, 'verify');
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {},
                            );
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xff183b99),
                                borderRadius: BorderRadius.circular(10)),
                            // width: 200,
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("By Continuing you are agree to our"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Term & Condition",
                              style: TextStyle(color: Colors.blue),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("and"),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Privacy Policy",
                              style: TextStyle(color: Colors.blue),
                            )
                          ],
                        ),
                      ],
                    ),

                    // color: Color(Colors.blue as int),
                    // boxShadow: [
                    //   BoxShadow(offset: Offset(10, 3), color: Colors.black12
                    //       // color: Colors.black.withOpacity(2),
                    //       )
                    // ]),
                  ),
                  Positioned(
                    left: MediaQuery.sizeOf(context).width / 2.5, //70,
                    child: Container(
                      width: 70, // Adjust the size as needed
                      height: 70, // Adjust the size as needed
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(5, 3),
                                color: Colors.black.withOpacity(0.1))
                          ]),
                      child: Icon(
                        Icons.person_2,
                        size: 32,
                        color: Colors.black,
                      ),
                    ),
                    // child: SizedBox(
                    //   width: 60,
                    //   child: ClipRRect(
                    //     borderRadius:
                    //         BorderRadius.circular(12.0),
                    //     child: Image.network(
                    //       controller.imageList[index]
                    //           ['val']!,
                    //       fit: BoxFit.cover,
                    //     ),
                    //   ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
