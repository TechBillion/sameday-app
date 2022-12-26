import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sameday/global_variables.dart';
import 'package:sameday/screens/login_screens/loginscreen.dart';
import 'package:sameday/size_config.dart';

import '../../widgets/sameday_appbar.dart';
import '../sameday_main_screen/sameday_main_screen.dart';

class LoginMobilePage extends StatefulWidget {
  @override
  _LoginMobilePageState createState() => _LoginMobilePageState();
}

class _LoginMobilePageState extends State<LoginMobilePage> {
  bool _userClickedLogInButton = false;

  late String phoneNo;
  late String smssent;
  late String verificationId;

  Future<void> verifyPhone() async {
    final PhoneCodeAutoRetrievalTimeout autoRetrieve = (String verId) {
      this.verificationId = verId;
    };

    final PhoneCodeSent smsCodeSent = (String verId, forceCodeResend) {
      this.verificationId = verId;
      smsCodeDialoge(context).then((value) {
        print("Code Send");
      });
    };

    final PhoneVerificationCompleted verifiedSuccess = (AuthCredential auth) {};
    final PhoneVerificationFailed verifyFailed = (FirebaseAuthException e) {
      print('${e.message}');
    };
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phoneNo,
      timeout: const Duration(seconds: 5),
      verificationCompleted: verifiedSuccess,
      verificationFailed: verifyFailed,
      codeSent: smsCodeSent,
      codeAutoRetrievalTimeout: autoRetrieve,
    );
  }

  Future smsCodeDialoge(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Provide OTP'),
          content: TextField(
            onChanged: (value) {
              this.smssent = value;
            },
          ),
          contentPadding: EdgeInsets.all(10.0),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () async {
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null) {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SameDayMainScreen()),
                    );
                  } else {
                    Navigator.of(context).pop();
                    signIn(smssent);
                  }
                },
                child: Text(
                  'Done',
                  style: TextStyle(color: Colors.blue),
                ))
          ],
        );
      },
    );
  }

  Future<void> signIn(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((user) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LogInScreen()),
      );
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  const Color(0xff7AD7F0).withOpacity(0.1),
                  const Color(0xffDBF3FA).withOpacity(0.1)
                ])),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: SameDayAppBar(
              parentContext: context,
            ),
            body: Padding(
              padding: EdgeInsets.only(left: 20 * SizeConfig.widthMultiplier!),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 25 * SizeConfig.heightMultiplier!,
                  ),
                  Text(
                    'OTP Verification',
                    style: TextStyle(
                        color: Color(0xff1E232C),
                        fontWeight: FontWeight.w700,
                        fontSize: 30 * SizeConfig.textMultiplier!),
                  ),

                  SizedBox(
                    height: 25 * SizeConfig.heightMultiplier!,
                  ),

                  Container(
                    margin: EdgeInsets.only(
                        right: 22 * SizeConfig.widthMultiplier!),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color(0xffF7F8F9),
                        hintText: 'Enter Your Mobile No',
                        prefix: Text('+91'),
                        hintStyle: TextStyle(
                          color: Color(0xff8391A1),
                          fontSize: 15 * SizeConfig.textMultiplier!,
                          fontWeight: FontWeight.w500,
                        ),
                        contentPadding: EdgeInsets.only(
                            top: 15 * SizeConfig.heightMultiplier!,
                            bottom: 15 * SizeConfig.heightMultiplier!),
                        enabled: true,
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffDADADA)),
                          borderRadius: BorderRadius.circular(
                              8 * SizeConfig.widthMultiplier!),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0xffDADADA)),
                          borderRadius: BorderRadius.circular(
                              8 * SizeConfig.widthMultiplier!),
                        ),
                      ),
                      onChanged: (value) {
                        phoneNo = value;
                      },
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  SizedBox(
                    height: 25 * SizeConfig.heightMultiplier!,
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          right: 22 * SizeConfig.widthMultiplier!),
                      child: Container(
                        width: ScreenWidth,
                        height: ScreenHeight * 0.0678,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xffFF7800).withOpacity(0.3),
                                offset: const Offset(0, 10),
                                blurRadius: 10 * SizeConfig.widthMultiplier!,
                                spreadRadius: 0)
                          ],
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.0, 1.0],
                            colors: [
                              Color(0xffFF7800),
                              Color(0xffFFAB61),
                            ],
                          ),
                          borderRadius: BorderRadius.all(
                              Radius.circular(8 * SizeConfig.widthMultiplier!)),
                          color: _userClickedLogInButton
                              ? greenThemeColor
                              : Color(0xffFF7800),
                        ),
                        child: Stack(
                          children: [
                            Center(
                                child:
                                    // !_userClickedLogInButton
                                    //     ?
                                    _userClickedLogInButton
                                        ? Image.asset(
                                            'images/loader_with_animation.gif',
                                            width: 80 *
                                                SizeConfig.widthMultiplier!,
                                          )
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                width: ScreenWidth * 0.01,
                                              ),
                                              Text(
                                                "Verify",
                                                style: TextStyle(
                                                    color:
                                                        const Color(0xffEDFCFE),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: SizeConfig
                                                            .textMultiplier! *
                                                        14.0),
                                              )
                                            ],
                                          )),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(
                                      ScreenWidth * 0.01333),
                                  onTap: () {
                                    verifyPhone();
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),

                  //
                  // SizedBox(height: 10.0),
                  // ElevatedButton(
                  //   onPressed: verifyPhone,
                  //   child: Text('Verify', style: TextStyle(color: Colors.white),),)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
