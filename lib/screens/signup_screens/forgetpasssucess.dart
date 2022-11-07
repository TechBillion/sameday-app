import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sameday/global_variables.dart';
import 'package:sameday/screens/login_screens/loginscreen.dart';
import 'package:sameday/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/sameday_appbar.dart';
import '../login_screens/logintest.dart';
import 'package:get/get.dart';

class ForgotPassSucess extends StatefulWidget {
  const ForgotPassSucess({Key? key}) : super(key: key);

  @override
  _ForgotPassSucessState createState() => _ForgotPassSucessState();
}

class _ForgotPassSucessState extends State<ForgotPassSucess> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9FBFF),
      resizeToAvoidBottomInset: false,
      appBar: SameDayAppBar(

        wantOtherIcons: false,
        parentContext: context,
      ),




      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 33 * SizeConfig.heightMultiplier!,),

                  Image.asset('images/sucess_icon.png',
                  height: 300 * SizeConfig.heightMultiplier!,
                    width: 300 * SizeConfig.widthMultiplier!,
                  ),
                  Text(
                    'We have send a reset password link on you email',
                    style: TextStyle(
                      color: Color(0xff8391A1),
                      fontWeight: FontWeight.w500

                    ),

                  ),
                  SizedBox(height: 33 * SizeConfig.heightMultiplier!,),

                  Container(
                    width: ScreenWidth,
                    height: ScreenHeight * 0.0678,
                    margin: EdgeInsets.only(left: 30 * SizeConfig.widthMultiplier! , right: 30 * SizeConfig.widthMultiplier! ),

                    child: ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: ScreenWidth,
                          height: 48 * SizeConfig.heightMultiplier!),
                      child: Container(
                          decoration: BoxDecoration(

                            boxShadow: [
                              BoxShadow(
                                  color: const Color(0xffFF7800).withOpacity(0.3), offset:const  Offset(0, 10), blurRadius:10 * SizeConfig.widthMultiplier!,spreadRadius: 0)
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
                                child:  Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(
                                      width: ScreenWidth * 0.01,
                                    ),
                                    Text(
                                      "Back to Login",
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

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LogInScreen(),
                                      ),
                                    );

                                  }),
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

}