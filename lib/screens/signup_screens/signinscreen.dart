import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sameday/global_variables.dart';
import 'package:sameday/screens/signup_screens/signup_screens.dart';
import 'package:sameday/widgets/blue_button.dart';
import 'package:sameday/widgets/polygon_image.dart';

import '../../size_config.dart';
import '../login_screens/loginscreen.dart';

class Signinhome extends StatefulWidget {
  const Signinhome({Key? key}) : super(key: key);

  @override
  _SigninhomeState createState() => _SigninhomeState();
}

@override
void initState() {}

class _SigninhomeState extends State<Signinhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Transform(
              transform: Matrix4.identity()..rotateZ(0 * 3.1415927 / 180),
              child: Container(
                  height: ScreenWidth * 0.378,
                  width: ScreenWidth * 0.378,
                  margin: EdgeInsets.only(
                      left: ScreenWidth * 0.28, top: ScreenHeight * 0.03),
                  child: const PolygonImage()),
            ),
            Container(
                height: ScreenWidth * 0.378,
                width: ScreenWidth * 0.378,
                margin: EdgeInsets.only(
                  top: ScreenHeight * 0.13,
                ),
                child: Transform.translate(
                    offset: Offset(-ScreenWidth * 0.07, 0),
                    child: const PolygonImage())),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 200 * SizeConfig.heightMultiplier!,
                  ),
                  Image.asset(
                    'assets/samedaylogo.png',
                    width: 350.89 * SizeConfig.widthMultiplier!,
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  BlueButton(
                    title: "Login",
                    onTap: (){
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LogInScreen()));
                    },
                  ),

                  SizedBox(
                    height: 15 * SizeConfig.heightMultiplier!,
                  ),
                  Container(
                    width: 330 * SizeConfig.widthMultiplier!,
                    height: 56 * SizeConfig.heightMultiplier!,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color(0xff3b8ec8),
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(7 * SizeConfig.widthMultiplier!)),
                        color: const Color(0xffFFFFFF)),
                    child: Stack(
                      children: [
                        Center(
                            child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Register",
                              style: TextStyle(
                                  color: const Color(0xff1E232C),
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.textMultiplier! * 14.0),
                            )
                          ],
                        )),
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius:
                                  BorderRadius.circular(7 * SizeConfig.widthMultiplier!),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
