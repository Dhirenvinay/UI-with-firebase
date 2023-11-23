import 'dart:async';

import 'package:buildandinnovationassignment/login.dart';
import 'package:buildandinnovationassignment/mainpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final int initialResendTime = 60; // Initial timer duration in seconds
  int remainingTime = 60; // Timer's remaining time
  bool isResendButtonEnabled = false; // Resend button state
  String code = "";
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    isResendButtonEnabled = false;
    remainingTime = initialResendTime;
    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        remainingTime -= 1;
        if (remainingTime == 0) {
          isResendButtonEnabled = true;
          timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    const focusedBorderColor = Color.fromRGBO(23, 171, 144, 1);
    const fillColor = Color.fromRGBO(243, 246, 249, 0);
    const borderColor = Color.fromRGBO(23, 171, 144, 0.4);

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(19),
          // border: Border.all(color: borderColor),
          ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
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
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 30, right: 15, left: 15),
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 40, bottom: 20),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 220, 217, 217),
                          width: 2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Pinput(
                          length: 6,

                          // androidSmsAutofillMethod:
                          //     AndroidSmsAutofillMethod.smsUserConsentApi,
                          // listenForMultipleSmsOnAndroid: true,
                          // onCompleted: (pin) {
                          //   debugPrint('onCompleted: $pin');
                          //   code = pin;
                          // },
                          // showCursor: true,
                          onChanged: (value) {
                            setState(() {
                              code = value;
                            });

                            print("the onchange code $code");
                          },
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          submittedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(19),
                              border: Border.all(color: focusedBorderColor),
                            ),
                          ),
                          errorPinTheme: defaultPinTheme.copyBorderWith(
                            border: Border.all(color: Colors.redAccent),
                          ),
                          // ),
                          // ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        remainingTime > 1
                            ? Text(
                                "Resend Code in $remainingTime seconds",
                                style: TextStyle(
                                  color: isResendButtonEnabled
                                      ? Colors.blue
                                      : Colors.grey,
                                ),
                              )
                            : TextButton(
                                onPressed: () {
                                  startTimer();
                                },
                                child: Text("Resend")),
                        //  ElevatedButton(
                        //     onPressed: () => startTimer(),
                        //     // : null,
                        //     child: Text("Resend"),
                        //   ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            try {
                              print(
                                  "SMS Code before: $code");
                              PhoneAuthCredential credential =
                                  PhoneAuthProvider.credential(
                                      verificationId: LoginScreen.verfy,
                                      smsCode: code);
                              print(
                                  "Verification ID: ${LoginScreen.verfy}"); // Add this for debugging
                              print(
                                  "SMS Code: $code"); // Add this for debugging

                              // Sign the user in (or link) with the credential
                              await FirebaseAuth.instance
                                  .signInWithCredential(credential);

                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => MainScreen(),
                              ));
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Error during authentication: $e")));
                              print("Error during authentication: $e");
                            }
                          },
                          child: Container(
                            height: 40,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xff183b99),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Text(
                                "Continue",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        // InkWell(
                        //   onTap: () async {
                        //     try {
                        //       PhoneAuthCredential credential =
                        //           PhoneAuthProvider.credential(
                        //               verificationId: LoginScreen.verfy,
                        //               smsCode: code);
                        //       print("the verify in otp ${LoginScreen.verfy}");

                        //       // Sign the user in (or link) with the credential
                        //       await FirebaseAuth.instance
                        //           .signInWithCredential(credential);

                        //       Navigator.of(context)
                        //           .pushReplacement(MaterialPageRoute(
                        //         builder: (context) => MainScreen(),
                        //       ));
                        //     } catch (e) {
                        //       ScaffoldMessenger.of(context).showSnackBar(
                        //           SnackBar(content: Text("the error is $e")));
                        //       print("Error during authentication: $e");
                        //     }
                        //   },
                        //   child: Container(
                        //     height: 40,
                        //     width: double.infinity,
                        //     decoration: BoxDecoration(
                        //         color: Color(0xff183b99),
                        //         borderRadius: BorderRadius.circular(10)),
                        //     child: Center(
                        //       child: Text(
                        //         "Continue",
                        //         style: TextStyle(color: Colors.white),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: 20,
                        ),
                        Text("By Continuing you are agree to our"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
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
                  ),
                  Positioned(
                    left: MediaQuery.sizeOf(context).width / 2.5,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(5, 3),
                                color: Colors.black.withOpacity(0.1))
                          ]),
                      child: Icon(
                        Icons.lock_clock_sharp,
                        size: 32,
                        color: Colors.black,
                      ),
                    ),
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
