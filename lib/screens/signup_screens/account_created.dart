import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sameday/global_variables.dart';
import 'package:sameday/screens/login_screens/loginscreen.dart';
import 'package:sameday/size_config.dart';

import '../../widgets/sameday_appbar.dart';

class AccountCreated extends StatelessWidget {
  const AccountCreated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      appBar: SameDayAppBar(
        parentContext: context,
        wantOtherIcons: false,
        wantBackButton: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [


          SizedBox(height: 50 * SizeConfig.heightMultiplier!,),
          Center(child: Image.asset("images/account_created.png",
          width: 300 * SizeConfig.widthMultiplier!,
            height: 300 * SizeConfig.heightMultiplier!,
          )),
          SizedBox(height: 25 * SizeConfig.heightMultiplier!,),

          Text("Your Account Has been  Created \nSuccessfully",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18 * SizeConfig.textMultiplier!,
            color: Color(0xff0398FF),
            fontWeight: FontWeight.w500
          ),
          ),
          SizedBox(height: 40 * SizeConfig.heightMultiplier!,),

          Container(

            width: ScreenWidth,
            height: ScreenHeight * 0.0678,
            margin: EdgeInsets.only(
                left: 30 * SizeConfig.widthMultiplier!,
                right: 30 * SizeConfig.widthMultiplier!),
            child: ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  width: ScreenWidth,
                  height: 48 * SizeConfig.heightMultiplier!),
              child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: const Color(0xffFF7800)
                              .withOpacity(0.3),
                          offset: const Offset(0, 10),
                          blurRadius:
                          10 * SizeConfig.widthMultiplier!,
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
                    borderRadius: BorderRadius.all(Radius.circular(
                        8 * SizeConfig.widthMultiplier!)),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child:Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: ScreenWidth * 0.01,
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                  color: const Color(
                                      0xffFFFFFF),
                                  fontWeight:
                                  FontWeight.w800,
                                  fontSize: SizeConfig
                                      .textMultiplier! *
                                      16.0),
                            )
                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(onTap: ()  {

                            Navigator.pushReplacement (context,
                                MaterialPageRoute(builder: (context) => const LogInScreen()));


                            }

                          ),
                        ),
                      )
                    ],
                  )),
            ),
          ),


        ],


      )
    );
  }
}
