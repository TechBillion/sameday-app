import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:sameday/api_handlers/user_login_api.dart';
import 'package:sameday/global_variables.dart';
import 'package:sameday/widgets/polygon_image.dart';

import '../../size_config.dart';
import '../sameday_main_screen/sameday_main_screen.dart';
import '../signup_screens/forgetpass.dart';
import '../signup_screens/signup_screens.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  String errorMessage = "";
  String otp = "";
  bool rememberDevice = false;
  bool _isSecure = true;

  TextEditingController UserName = TextEditingController();
  TextEditingController Password = TextEditingController();
  GlobalKey<FormState> usernameKey = GlobalKey<FormState>();
  bool _userClickedLogInButton = false;
  final FocusNode _emailFocusNode = FocusNode();
  RxBool isOtpIncorrect = false.obs;

  bool isEmail(String input) => EmailValidator.validate(input);

  bool isPhone(String input) =>
      RegExp(r'^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$')
          .hasMatch(input);

  @override
  void dispose() {
    UserName.dispose();
    Password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF9FBFF),
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
            Column(
              children: [
                SizedBox(height: 30.44 * SizeConfig.heightMultiplier!),
                Image.asset(
                  'assets/samedaylogo.png',
                  width: 350.89 * SizeConfig.widthMultiplier!,
                ),

                Column(
                  children: [
                    //Email input field
                    Container(
                        margin: EdgeInsets.only(
                            left: 30 * SizeConfig.widthMultiplier!,
                            right: 30 * SizeConfig.widthMultiplier!),
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            if (hasFocus) {
                            } else {
                              usernameKey.currentState!.validate();
                            }
                          },
                          child: Form(
                            key: usernameKey,
                            child: Theme(
                              data: ThemeData(
                                hintColor: const Color(0x33adadad),
                              ),
                              child: TextFormField(
                                focusNode: _emailFocusNode,
                                autofillHints: const <String>[
                                  AutofillHints.username
                                ],
                                onFieldSubmitted: (value) {
                                  usernameKey.currentState?.validate();
                                },
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (!isEmail(value!) && !isPhone(value)) {
                                    return 'Please enter a valid email or phone number.';
                                  }
                                  return null;
                                },
                                controller: UserName,
                                cursorRadius: const Radius.circular(10.0),
                                cursorColor: greenThemeColor,
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: SizeConfig.textMultiplier! * 14),
                                decoration: InputDecoration(
                                  fillColor: Color(0xffFFFFFF),
                                  filled: true,
                                  errorStyle: TextStyle(
                                      color: Colors.red,
                                      fontSize:
                                          SizeConfig.textMultiplier! * 11),
                                  prefixIcon: SizedBox(
                                    width: ScreenWidth * 0.05,
                                    child: Center(
                                        child: Transform.scale(
                                      scale: 0.8,
                                      child: SvgPicture.asset(
                                        "images/user_icon.svg",
                                        width: ScreenWidth * 0.04,
                                      ),
                                    )),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 18 * SizeConfig.heightMultiplier!,
                                  ),
                                  hintText: "Enter your phone number or email",
                                  hintStyle: TextStyle(
                                      fontSize: 14 * SizeConfig.textMultiplier!,
                                      color: const Color(0xff8391A1)),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Colors.redAccent, width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenWidth * 0.0133333)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greenThemeColor.withOpacity(0.2),
                                        width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenWidth * 0.0133333)),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xffDADADA), width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            8 * SizeConfig.widthMultiplier!)),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0x33adadad), width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            ScreenWidth * 0.0133333)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )),
                    SizedBox(
                      height: ScreenHeight * 0.0160098,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: 30 * SizeConfig.widthMultiplier!,
                          right: 30 * SizeConfig.widthMultiplier!),
                      child: TextFormField(
                        autofillHints: const <String>[AutofillHints.password],
                        textInputAction: TextInputAction.done,
                        controller: Password,
                        obscureText: _isSecure,
                        cursorRadius: const Radius.circular(10.0),
                        cursorColor: greenThemeColor,
                        cursorHeight: 18 * SizeConfig.heightMultiplier!,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: SizeConfig.textMultiplier! * 14.0),
                        decoration: InputDecoration(
                          fillColor: Color(0xffFFFFFF),
                          filled: true,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSecure = !_isSecure;
                              });
                            },
                            child: (_isSecure)
                                ? Icon(
                                    Icons.visibility_off,
                                    color: const Color(0xffBDBDBD),
                                    size: ScreenWidth * 0.05,
                                  )
                                : Icon(
                                    Icons.visibility,
                                    color: greenThemeColor,
                                    size: ScreenWidth * 0.05,
                                  ),
                          ),
                          prefixIcon: SizedBox(
                            width: ScreenWidth * 0.009,
                            child: Center(
                                child: Transform.scale(
                              scale: 0.8,
                              child: SvgPicture.asset("images/lock_icon.svg",
                                  width: ScreenWidth * 0.04),
                            )),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 18 * SizeConfig.heightMultiplier!,
                          ),
                          hintText: "Password",
                          hintStyle: TextStyle(
                              fontSize: SizeConfig.textMultiplier! * 14,
                              height: 1,
                              color: const Color(0xff8391A1)),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: greenThemeColor.withOpacity(0.2),
                                width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(
                                6 * SizeConfig.widthMultiplier!)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0xffDADADA), width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(
                                8 * SizeConfig.widthMultiplier!)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x33adadad), width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                //if username and password not found in database
                (errorMessage.isNotEmpty)
                    ? Container(
                        padding: EdgeInsets.only(top: ScreenHeight * 0.006),
                        child: Text("$errorMessage",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: SizeConfig.textMultiplier! * 10)),
                      )
                    : Container(),

                //todo add forgot password feaure
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Forgotpass()));
                    },
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(ScreenWidth * 0.1,
                          ScreenHeight * 0.005, ScreenWidth * 0.1013333, 0.0),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                            color: const Color(0xff0398FF),
                            decoration: TextDecoration.underline,
                            fontSize: SizeConfig.textMultiplier! * 12.0,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenHeight * 0.038,
                ),
                //logIn button
                Container(
                    margin: EdgeInsets.only(
                        left: 30 * SizeConfig.widthMultiplier!,
                        right: 30 * SizeConfig.widthMultiplier!),
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
                                          width:
                                              80 * SizeConfig.widthMultiplier!,
                                        )
                                      : Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: ScreenWidth * 0.05,
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                "images/lock_icon.svg",
                                                width: ScreenWidth * 0.035,
                                                color: const Color(0xffEDFCFE),
                                              )),
                                            ),
                                            SizedBox(
                                              width: ScreenWidth * 0.01,
                                            ),
                                            Text(
                                              "Login",
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
                                  if (usernameKey.currentState!.validate() &&
                                      !_userClickedLogInButton) {
                                    setState(() {
                                      _userClickedLogInButton = true;
                                    });

                                    LoginClick(UserName.text, Password.text);

                                    // signInn(Username.text, Password.text);
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),

                SizedBox(
                  height: ScreenHeight * 0.02,
                ),
                // remember this Device check box
                Container(
                  margin: EdgeInsets.only(left: ScreenWidth * 0.02),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        rememberDevice = !rememberDevice;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(ScreenWidth * 0.07,
                              ScreenHeight * 0.00, 0.0, ScreenHeight * 0.005),
                          child: SizedBox(
                            height: ScreenHeight * 0.02,
                            width: ScreenWidth * 0.06,
                            child: Transform.scale(
                              scale: 0.8,
                              child: Checkbox(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenWidth * 0.015)),
                                ),
                                activeColor: Color(0xff0398FF),
                                value: rememberDevice,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberDevice = value!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Transform.translate(
                          offset: Offset(0, 0),
                          child: Text(
                            "Remember this device",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: SizeConfig.textMultiplier! * 11.0,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenHeight * 0.02,
                ),

                SizedBox(
                  height: ScreenHeight * 0.10,
                ),
                //Sign up to SameDay
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "New to SameDay? ",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: SizeConfig.textMultiplier! * 14,
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: Text("Register Now",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color(0xff0398FF),
                                fontSize: SizeConfig.textMultiplier! * 14.0,
                                fontWeight: FontWeight.w600)))
                  ],
                ),
              ],
            ),
          ],
        ));
  }

  Future<void> LoginClick(String userName, String password) async {
    //login Api object
    logInAPI checkUserCredentials = logInAPI();

    //response code from Api changed in future
    int? responseFromApi;

    //calling API and storing response
    responseFromApi = await checkUserCredentials.checkUserCredentials(
      userName: userName,
      password: password,
    );

    //if username or password is incorrect
    if (responseFromApi == 400) {
      setState(() {
        errorMessage = "password is incorrect";
        _userClickedLogInButton = false;
      });
    }
    if (responseFromApi == 404) {
      setState(() {
        errorMessage = "User Not Available";
        _userClickedLogInButton = false;
      });
    }

    //User logged in SuccessFully
    if (responseFromApi == 201) {
      setState(() {
        _userClickedLogInButton = false;
      });

      //save password for later use

      //starting home Screen
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SameDayMainScreen()));
      TextInput.finishAutofillContext();
    }
    setState(() {
      _userClickedLogInButton = false;
    });
  }
}
