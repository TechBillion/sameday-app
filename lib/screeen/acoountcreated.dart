import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:samedaypro/login.dart';

import '../../global_variables.dart';

import '../widgets/polygon_image.dart';

class AccountCreated extends StatefulWidget {
  const AccountCreated({Key? key}) : super(key: key);

  @override
  _AccountCreatedState createState() => _AccountCreatedState();
}

class _AccountCreatedState extends State<AccountCreated> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          int count = 1;
          Navigator.of(context).popUntil((_) => count++ >= 2);
          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              Transform(
                transform: Matrix4.identity()..rotateZ(0 * 3.1415927 / 180),
                child: Container(

                    margin: EdgeInsets.only(
                        left: 28, top: 30),
                    child: const PolygonImage()),
              ),
              Container(
                  margin: EdgeInsets.only(
                  ),
                  child: Transform.translate(
                      offset: Offset(7, 0),
                      child: const PolygonImage())),
              Center(
                child: Container(
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/registred_image.png",

                      ),
                      Transform.translate(
                          offset: const Offset(0, 3),
                          child: const Text(
                            "Thankyou!",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize:  40,
                                color: Color(0xff040447)),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Transform.translate(
                          offset: Offset(0, 3),
                          child: Text(
                            "Registration Completed",
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                                color: const Color(0xff56646C)),
                          )),
                      SizedBox(
                        height:15,
                      ),
                      Transform.translate(
                        offset: Offset(0,3),
                        child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Click here to ",
                                  style: TextStyle(
                                      color: const Color(0xff56646C),
                                      fontWeight: FontWeight.w400,
                                      fontSize:15)),
                              TextSpan(
                                  text: "log-in",
                                  style: TextStyle(
                                    color: blueThemeColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize:  20,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const MyLogin()))),
                            ])),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
