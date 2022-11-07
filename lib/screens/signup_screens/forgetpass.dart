import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sameday/global_variables.dart';
import 'package:sameday/screens/signup_screens/forgetpasssucess.dart';
import 'package:sameday/size_config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../widgets/sameday_appbar.dart';
import '../login_screens/logintest.dart';
import 'package:get/get.dart';

class Forgotpass extends StatefulWidget {
  const Forgotpass({Key? key}) : super(key: key);

  @override
  _ForgotpassState createState() => _ForgotpassState();
}

class _ForgotpassState extends State<Forgotpass> {

  RxBool userClickedOnForgetButton = false.obs;


  // bool showProgress = false;
  bool visible = false;
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = new TextEditingController();
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

              Container(
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding:  EdgeInsets.only(left: 20 * SizeConfig.widthMultiplier!),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 33 * SizeConfig.heightMultiplier!,),

                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Color(0xff1E232C),
                            fontSize: 30 * SizeConfig.textMultiplier!,
                          ),
                        ),
                        SizedBox(height: 10 * SizeConfig.heightMultiplier!,),

                        Text(
                          "Don't worry! It occurs. Please enter the email \naddress linked with your account.",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xff8391A1),
                            fontSize: 16 * SizeConfig.textMultiplier!,
                          ),
                        ),

                        SizedBox(height: 57 * SizeConfig.heightMultiplier!,),

                        Container(
                          width: 330 * SizeConfig.widthMultiplier!,
                          height: 56 * SizeConfig.heightMultiplier!,
                          margin:  EdgeInsets.only(
                              right: 22 * SizeConfig.widthMultiplier! ),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF7F8F9),
                              hintText: 'Enter your email',
                              hintStyle: TextStyle(
                                color: Color(0xff8391A1),
                                fontSize: 15 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w500,

                              ),
                              enabled: true,
                              focusedBorder: OutlineInputBorder(
                                borderSide: new BorderSide(color: Color(0xffDADADA)),
                                borderRadius: new BorderRadius.circular(8 * SizeConfig.widthMultiplier!),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: new BorderSide(color: Color(0xffDADADA)),
                                borderRadius: new BorderRadius.circular(8 * SizeConfig.widthMultiplier!),
                              ),
                            ),
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.length == 0) {
                                return "Email cannot be empty";
                              }
                              if (!RegExp(
                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Please enter a valid email");
                              } else {
                                return null;
                              }
                            },
                            onSaved: (value) {
                              // emailController.text = value!;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(
                          height: 30 * SizeConfig.heightMultiplier!,
                        ),





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
                                    Obx(
                                          () => Center(
                                        child: userClickedOnForgetButton.value
                                            ? Image.asset(
                                          'images/loader_with_animation.gif',
                                          width: 80 *
                                              SizeConfig.widthMultiplier!,
                                        )
                                            : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: ScreenWidth * 0.05,
                                              child: Center(
                                                  child: SvgPicture.asset(


                                                    "images/lock_icon.svg",
                                                    width: ScreenWidth * 0.032,
                                                    color:
                                                    const Color(0xffFFFFFF),
                                                  )),
                                            ),
                                            SizedBox(
                                              width: ScreenWidth * 0.01,
                                            ),
                                            Text(
                                              "Send Code",
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
                                    ),
                                    Positioned.fill(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(onTap: ()  {
                                            Forgotpassss(emailController.text);

                                        }),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

   Forgotpassss(String email) async {
    if (_formkey.currentState!.validate()&&!userClickedOnForgetButton.value) {
      userClickedOnForgetButton.value = true;
      try {

        await _auth.sendPasswordResetEmail(email: email).then((uid) => {

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => ForgotPassSucess()))
        });
      }

      on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(
            content: const Text(
                "No user found for that email."),
            backgroundColor:
            Colors.redAccent.withOpacity(0.6),
            elevation: 0.0,
          )
          );
        }
      } catch (e) {
        print(e);
      }
      userClickedOnForgetButton.value = false;
    }

  }
}