import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sameday/api_handlers/user_signup_api.dart';
import 'package:sameday/screens/signup_screens/account_created.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../global_variables.dart';
import '../../size_config.dart';
import '../../widgets/remove_scroll_glow.dart';
import '../../widgets/sameday_appbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  /*
  * Account type 0 for none
  * 1 for personal
  * 2 for business
  * */
  int accountType = 0;
  String errorMessage = "";

  //when Api returns error that email already exists then this will become true
  bool _emailExsists = false;

  //password field is visible?
  bool _isSecure = true;

  //confirm password is visible?
  bool _isConfirmSecure = true;
  bool hasFocus = false;

  final ScrollController _listController = ScrollController();

  bool _samedayPolicy = false;

  RxBool userClickedOnSignupButton = false.obs;

  final List<Color> _passwordColors = [
    const Color(0xffEA1111),
    const Color(0xffFFAE00),
    const Color(0xff9BC158),
    const Color(0xff00B400),
  ];

  final List<String> _passwordStringStrength = [
    "Week",
    "better",
    "Best  ",
    "Strong"
  ];
  int _passwordStrength = 0;

  //fetching countries
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController otpVerify = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  RxBool _userClickedOnOtpContinue = false.obs;
  RxBool isOtpIncorrect = false.obs;

  String otp = "";
  final FocusNode _usernameFocusNode = FocusNode();
  final GlobalKey<FormState> _validatorKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _confirmPassword = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
          Scaffold(
            backgroundColor: const Color(0xffF9FBFF),
            appBar: SameDayAppBar(
              parentContext: context,
              wantOtherIcons: true,
            ),
            resizeToAvoidBottomInset: true,
            body: ScrollConfiguration(
                behavior: RemoveScrollGlow(),
                child: Form(
                  key: _validatorKey,
                  child: ListView(
                    controller: _listController,
                    children: [
                      SizedBox(
                        height: 81 * SizeConfig.heightMultiplier!,
                      ),
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 12 * SizeConfig.heightMultiplier!),
                          child: RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: "Already have an Account? ",
                              style: TextStyle(
                                  color: const Color(0xff585858),
                                  fontWeight: FontWeight.w400,
                                  fontSize: SizeConfig.textMultiplier! * 14),
                            ),
                            TextSpan(
                              text: "Signin",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: const Color(0xff0398FF),
                                  fontWeight: FontWeight.w500,
                                  fontSize: SizeConfig.textMultiplier! * 14),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pop(context);
                                },
                            ),
                          ])),
                        ),
                      ),
                      SizedBox(
                        height: 20 * SizeConfig.heightMultiplier!,
                      ),

                      AutofillGroup(
                        child: Column(
                          children: [
                            /*
                      * User mobile input field
                      * */
                            Container(
                              decoration:
                                  const BoxDecoration(color: Color(0xffFFFFFF)),
                              height: 55 * SizeConfig.heightMultiplier!,
                              margin: EdgeInsets.only(
                                  left: 30 * SizeConfig.widthMultiplier!,
                                  right: 30 * SizeConfig.widthMultiplier!),
                              child: TextFormField(
                                controller: phoneNumber,
                                cursorRadius: const Radius.circular(10.0),
                                cursorColor: greenThemeColor,
                                style: TextStyle(
                                    color: const Color(0xff585858),
                                    fontSize:
                                        SizeConfig.textMultiplier! * 15.0),
                                maxLength: 10,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(12),
                                ],
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  fillColor: const Color(0xffFFFFFF),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            const Color(0xff56646C).withOpacity(0.2),
                                        width: 1),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            SizeConfig.widthMultiplier! * 8)),
                                  ),
                                  filled: true,
                                  prefixIcon: SizedBox(
                                    width: ScreenWidth * 0.1,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        "images/mobile_icon.svg",
                                        width: SizeConfig.imageSizeMultiplier! *
                                            18,
                                      ),
                                    ),
                                  ),
                                  counterText: "",
                                  labelText: "Enter your mobile number",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            8 * SizeConfig.widthMultiplier!)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: greenThemeColor.withOpacity(0.3),
                                        width: 1.7),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            6 * SizeConfig.widthMultiplier!)),
                                  ),
                                  labelStyle:
                                      const TextStyle(color: Colors.black),
                                  prefixStyle: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)')
                                          .hasMatch(value)) {
                                    return "Enter correct phone number";
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: ScreenHeight * 0.01600,
                            ),

                            /*
                      * User Email input field
                      * */
                            Container(
                                decoration:
                                    const BoxDecoration(color: Color(0xffFFFFFF)),
                                margin: EdgeInsets.only(
                                    left: 30 * SizeConfig.widthMultiplier!,
                                    right: 30 * SizeConfig.widthMultiplier!),
                                child: TextFormField(
                                    focusNode: _usernameFocusNode,
                                    textInputAction: TextInputAction.next,
                                    autofillHints: const [
                                      AutofillHints.username
                                    ],
                                    onFieldSubmitted: (value) =>
                                        _validatorKey.currentState?.validate(),
                                    //validating User Email

                                    validator: (String? value) {
                                      if (value == null) {
                                        return "Please enter the email";
                                      } else if (RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(value)) {
                                        return null;
                                      } else {
                                        return "Please enter valid email";
                                      }
                                    },
                                    onChanged: (value) {},
                                    controller: email,
                                    keyboardType: TextInputType.emailAddress,
                                    cursorRadius: const Radius.circular(10.0),
                                    cursorColor: greenThemeColor,
                                    style: TextStyle(
                                        color: const Color(0xff585858),
                                        fontSize:
                                            SizeConfig.textMultiplier! * 15.0),
                                    decoration: InputDecoration(
                                        fillColor: const Color(0xffFFFFFF),
                                        errorStyle: TextStyle(
                                            color: Colors.redAccent
                                                .withOpacity(0.9),
                                            fontSize: 10,
                                            height: 1),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: const Color(0xff56646C)
                                                  .withOpacity(0.2),
                                              width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  SizeConfig.widthMultiplier! *
                                                      8)),
                                        ),
                                        prefixIcon: SizedBox(
                                          width: ScreenWidth * 0.1,
                                          child: Center(
                                            child: SvgPicture.asset(
                                              "images/email_icon.svg",
                                              width: SizeConfig
                                                      .imageSizeMultiplier! *
                                                  18,
                                            ),
                                          ),
                                        ),
                                        contentPadding: EdgeInsets.only(
                                            left: ScreenWidth * 0.005,
                                            top: 16 *
                                                SizeConfig.heightMultiplier!,
                                            bottom: 16 *
                                                SizeConfig.heightMultiplier!),
                                        hintText: "Enter your email",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize:
                                                SizeConfig.textMultiplier! *
                                                    14.0,
                                            color: const Color(0xff585858)),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: greenThemeColor
                                                  .withOpacity(0.3),
                                              width: 1.7),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(6 *
                                                  SizeConfig.widthMultiplier!)),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  ScreenWidth * 0.013333)),
                                        )))),

                            //if user email already exist in database
                            // (_emailExsists)
                            //     ? Container(
                            //         width: ScreenWidth,
                            //         margin: EdgeInsets.fromLTRB(
                            //             ScreenWidth * 0.08,
                            //             ScreenHeight * 0.006,
                            //             ScreenWidth * 0.09,
                            //             0.0),
                            //         child: Text(
                            //             "This user email already exists, if you forget your password then reset it, a link will send to your email.",
                            //             style: TextStyle(
                            //                 color: Colors.red,
                            //                 fontSize:
                            //                     SizeConfig.textMultiplier! *
                            //                         9.0),
                            //             textAlign: TextAlign.justify),
                            //       )
                            //     : Container(),
                            SizedBox(
                              height: ScreenHeight * 0.01600,
                            ),
                            Container(
                              decoration:
                                  const BoxDecoration(color: Color(0xffFFFFFF)),
                              margin: EdgeInsets.only(
                                  left: 30 * SizeConfig.widthMultiplier!,
                                  right: 30 * SizeConfig.widthMultiplier!),
                              child: Focus(
                                onFocusChange: (value) {
                                  if (value) {
                                    setState(() {
                                      hasFocus = true;
                                    });
                                  } else {
                                    setState(() {
                                      hasFocus = false;
                                    });
                                  }
                                },
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null) {
                                      return "Please enter the password";
                                    } else if (_passwordStrength < 3) {
                                      return "Please use a strong password";
                                    } else {
                                      return null;
                                    }
                                  },
                                  textInputAction: TextInputAction.next,
                                  autofillHints: const [AutofillHints.password],
                                  controller: password,
                                  onChanged: (value) {
                                    _passwordStrength = 0;
                                    _checkPasswordStrength(value);
                                    setState(() {});
                                  },
                                  obscureText: _isSecure,
                                  cursorRadius: const Radius.circular(10.0),
                                  cursorColor: greenThemeColor,
                                  style: TextStyle(
                                      color: const Color(0xff585858),
                                      fontSize:
                                          SizeConfig.textMultiplier! * 15.0),
                                  decoration: InputDecoration(
                                      fillColor: const Color(0xffFFFFFF),
                                      errorStyle: TextStyle(
                                          color:
                                              Colors.redAccent.withOpacity(0.9),
                                          fontSize: 10,
                                          height: 1),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: const Color(0xff56646C)
                                                .withOpacity(0.2),
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                SizeConfig.widthMultiplier! *
                                                    8)),
                                      ),
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
                                        width: ScreenWidth * 0.05,
                                        child: Center(
                                            child: SvgPicture.asset(
                                          "images/lock_icon.svg",
                                          width: ScreenWidth * 0.04,
                                        )),
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenWidth * 0.005,
                                          top:
                                              16 * SizeConfig.heightMultiplier!,
                                          bottom: 16 *
                                              SizeConfig.heightMultiplier!),
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize:
                                              SizeConfig.textMultiplier! * 14.0,
                                          color: const Color(0xff585858)),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: greenThemeColor
                                                .withOpacity(0.3),
                                            width: 1.7),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(6 *
                                                SizeConfig.widthMultiplier!)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                ScreenWidth * 0.013333)),
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //password validator

                      (_passwordStrength > 0)
                          ? Container(
                              margin: EdgeInsets.fromLTRB(ScreenWidth * 0.09,
                                  0.0, ScreenWidth * 0.09, 0.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: List.generate(
                                          4,
                                          (index) => Padding(
                                                padding: EdgeInsets.only(
                                                    right: ScreenWidth * 0.004),
                                                child: Container(
                                                  height:
                                                      ScreenHeight * 0.00615764,
                                                  width: ScreenWidth * 0.096333,
                                                  decoration: BoxDecoration(
                                                      color: index <
                                                              _passwordStrength
                                                          ? _passwordColors[
                                                              _passwordStrength -
                                                                  1]
                                                          : const Color(
                                                              0xffD9D9D9),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              ScreenWidth *
                                                                  0.26)),
                                                ),
                                              )),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SvgPicture.asset(
                                        'images/info_icon.svg',
                                        height: ScreenWidth * 0.025,
                                        width: ScreenWidth * 0.025,
                                        color: _passwordColors[
                                            _passwordStrength - 1],
                                      ),
                                      SizedBox(
                                        width: ScreenWidth * 0.01,
                                      ),
                                      Text(
                                        _passwordStringStrength[
                                            _passwordStrength - 1],
                                        style: TextStyle(
                                            color: _passwordColors[
                                                _passwordStrength - 1],
                                            fontSize:
                                                SizeConfig.textMultiplier! * 10,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          : Container(),

                      SizedBox(
                        height: 13 * SizeConfig.heightMultiplier!,
                      ),
                      /*
                    * Confirm password field
                    * */

                      Container(
                        decoration: const BoxDecoration(color: Color(0xffFFFFFF)),
                        margin: EdgeInsets.only(
                            left: 30 * SizeConfig.widthMultiplier!,
                            right: 30 * SizeConfig.widthMultiplier!),
                        child: TextFormField(
                          controller: confirmPassword,
                          validator: (validator) {
                            if (validator != password.text) {
                              return "Password not matched";
                            } else {
                              return null;
                            }
                          },
                          onFieldSubmitted: (value) {
                            _confirmPassword.currentState!.validate();
                          },
                          obscureText: _isConfirmSecure,
                          cursorRadius: const Radius.circular(10.0),
                          cursorColor: greenThemeColor,
                          style: TextStyle(
                              color: const Color(0xff585858),
                              fontSize: SizeConfig.textMultiplier! * 15.0),
                          decoration: InputDecoration(
                            fillColor: const Color(0xffFFFFFF),
                            errorStyle: TextStyle(
                                color: Colors.redAccent.withOpacity(0.9),
                                fontSize: 10,
                                height: 1),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isConfirmSecure = !_isConfirmSecure;
                                });
                              },
                              child: (_isConfirmSecure)
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: const Color(0xffBDBDBD),
                                      size: ScreenWidth * 0.05,
                                    )
                                  : Icon(Icons.visibility,
                                      color: greenThemeColor,
                                      size: ScreenWidth * 0.05),
                            ),
                            prefixIcon: SizedBox(
                              width: ScreenWidth * 0.05,
                              child: Center(
                                  child: SvgPicture.asset(
                                "images/lock_icon.svg",
                                width: ScreenWidth * 0.04,
                              )),
                            ),
                            contentPadding: EdgeInsets.only(
                                left: ScreenWidth * 0.005,
                                top: 16 * SizeConfig.heightMultiplier!,
                                bottom: 16 * SizeConfig.heightMultiplier!),
                            hintText: "Confirm Password",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: SizeConfig.textMultiplier! * 14.0,
                                color: const Color(0xff585858)),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: greenThemeColor.withOpacity(0.3),
                                  width: 1.7),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  6 * SizeConfig.widthMultiplier!)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenWidth * 0.01333)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: const Color(0xff56646C).withOpacity(0.2),
                                  width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(
                                  SizeConfig.widthMultiplier! * 8)),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 15 * SizeConfig.heightMultiplier!,
                      ),

                      /*
                    *
                    * Create Account button and conditions validation on clicking the button
                    *
                    * */

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
                                  Obx(
                                    () => Center(
                                      child: userClickedOnSignupButton.value
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
                                                  "Signup",
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
                                      child: InkWell(onTap: () async {
                                        print("test");
                                        //when user clicks on the create account button

                                        //if user has not accepted the sameday policies
                                        if (_samedayPolicy) {
                                          print("test");
                                          //if user has not filled any of the field

                                          if (_validatorKey.currentState!
                                                  .validate() &&
                                              !userClickedOnSignupButton
                                                  .value) {
                                            setState(() {
                                              userClickedOnSignupButton.value =
                                                  true;
                                            });

                                            print("test");

                                            createAccount(
                                              phoneNumber.text,
                                              email.text,
                                              password.text,
                                              confirmPassword.text,
                                            );
                                            sendOtp(phoneNumber.text);
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: const Text(
                                                "Please agree to sameday terms and conditions."),
                                            backgroundColor:
                                                Colors.black.withOpacity(0.6),
                                            elevation: 0.0,
                                          ));
                                        }
                                      }),
                                    ),
                                  )
                                ],
                              )),
                        ),
                      ),


                      ///accept terms and conditions
                      Container(
                          margin: EdgeInsets.fromLTRB(
                              ScreenWidth * 0.09,
                              17 * SizeConfig.heightMultiplier!,
                              ScreenWidth * 0.09,
                              0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: ScreenHeight * 0.04,
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                    height: 20.0,
                                    width: 20.0,
                                    child: Transform.scale(
                                      scale: 0.75,
                                      child: Checkbox(
                                          activeColor: Color(0xff0398FF),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ScreenWidth * 0.012),
                                              side: const BorderSide(
                                                  width: 1,
                                                  color: Color(0xff585858))),
                                          value: _samedayPolicy,
                                          onChanged: (value) {
                                            setState(() {
                                              _samedayPolicy = !_samedayPolicy;
                                            });
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                  left: ScreenWidth * 0.02,
                                ),
                                width: ScreenWidth * 0.75,
                                child: RichText(
                                  text: TextSpan(
                                      style: const TextStyle(height: 1.5),
                                      children: [
                                        TextSpan(
                                          text:
                                              "I here by confirm that I have read and agree to the ",
                                          style: TextStyle(
                                              color: const Color(0xff585858),
                                              fontWeight: FontWeight.w400,
                                              fontSize:
                                                  SizeConfig.textMultiplier! *
                                                      12.0),
                                        ),
                                        TextSpan(
                                            text: "Terms & Conditions",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: const Color(0xff223DC1),
                                                fontSize:
                                                    SizeConfig.textMultiplier! *
                                                        12.0,
                                                fontWeight: FontWeight.w500),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => launch(
                                                  "https://SameDay.com/term-condition")),
                                        TextSpan(
                                          text: ", and ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff585858),
                                              fontSize:
                                                  SizeConfig.textMultiplier! *
                                                      12.0),
                                        ),
                                        TextSpan(
                                            text: "Privacy Policy",
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                color: const Color(0xff223DC1),
                                                fontSize:
                                                    SizeConfig.textMultiplier! *
                                                        12.0,
                                                fontWeight: FontWeight.w500),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => launch(
                                                  "https://SameDay.com/privacy-policy")),
                                        TextSpan(
                                          text: " of SameDay.",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff585858),
                                              fontSize:
                                                  SizeConfig.textMultiplier! *
                                                      12.0),
                                        ),
                                      ]),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Future<void> createAccount(String phoneNumber, String email, String password,
      String confirmPassword) async {
    signUpAPI createNewUser = signUpAPI(
      phoneNumber: phoneNumber,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
    int? checkSuccess;

    checkSuccess = await createNewUser.accountSignUp();
    if (checkSuccess == 1) {
      //if user account is created successfully
      userClickedOnSignupButton.value = false;
      sendOtp;
      //saving username and password for future autofill
      TextInput.finishAutofillContext();
    }

    //is email already exists in
    else if (checkSuccess == 0) {
      userClickedOnSignupButton.value = false;
      setState(() {
        _emailExsists = true;
        errorMessage = "Email already Exits";
      });
    } else {
      userClickedOnSignupButton.value = false;
      setState(() {
        _emailExsists = true;
        errorMessage = "something went wrong";
      });
    }
  }

  void sendOtp(String otpPhoneNumber) async {
    final response = await http.post(
      Uri.parse("http://apis.samedaylko.com/api/MobileOtpVerification/sendOtp"),
      body: jsonEncode({
        "phoneNumber": otpPhoneNumber,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print("helloo " + response.statusCode.toString());

    if (response.statusCode == 200) {
      //if account created successfully then return 1
      //pushing to account created screen

      _showOtpPopup();
    }
  }

  void validateOtp(String otpPhoneNumber, String otp) async {
    final response = await http.post(
      Uri.parse(
          "http://apis.samedaylko.com/api/MobileOtpVerification/verifyOtp"),
      body: jsonEncode({
        "mobileNumber": otpPhoneNumber,
        "otp": otp,
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    print("helloo " + response.statusCode.toString());

    print("helloo " + response.body.toString());

    if (response.statusCode == 200) {
      //if account created successfully then return 1
      //pushing to account created screen

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AccountCreated()));
    }
    if (response.statusCode == 400) {
      //if account created successfully then return 1
      //pushing to account created screen

      // Navigator.pushReplacement(context,
      //     MaterialPageRoute(builder: (context) => const AccountCreated()));
    }

    _userClickedOnOtpContinue.value = false;
  }

  _showOtpPopup() {
    RxString otpText = ''.obs;
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        backgroundColor: Colors.black.withOpacity(0.7),
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              _otpController.clear();
              _userClickedOnOtpContinue.value = false;
              return true;
            },
            child: Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: IntrinsicHeight(
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 50 * SizeConfig.widthMultiplier!,
                        vertical: 50 * SizeConfig.heightMultiplier!),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            "OTP VERIFICATION",
                            style: TextStyle(
                                color: const Color(0xff0398FF),
                                fontSize: 18 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w500,
                                height: 1.3),
                          ),
                        ),
                        SizedBox(
                          height: 25 * SizeConfig.heightMultiplier!,
                        ),
                        RichText(
                            text: TextSpan(children: [
                          TextSpan(
                            text: "Enter code sent to your mobile number",
                            style: TextStyle(
                                color: const Color(0xff2BD67B),
                                fontSize: 14 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w400,
                                height: 1.3),
                          ),
                          WidgetSpan(
                            child: InkWell(
                              onTap: () {
                                sendOtp(phoneNumber.text);
                              },
                              child: RichText(
                                text: TextSpan(
                                  text: " resend code",
                                  style: TextStyle(
                                      fontSize:
                                          SizeConfig.textMultiplier! * 12.0,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xff0398FF)),
                                ),
                              ),
                            ),
                          ),
                        ])),
                        SizedBox(
                          height: 14 * SizeConfig.heightMultiplier!,
                        ),
                        Obx(() => (isOtpIncorrect.value)
                            ? Container(
                                margin: EdgeInsets.only(
                                    bottom: 5 * SizeConfig.heightMultiplier!),
                                child: Text("invalid Otp",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize:
                                            SizeConfig.textMultiplier! * 10,
                                        height: 1)),
                              )
                            : Container()),
                        const Spacer(),
                        SizedBox(
                          height: 20 * SizeConfig.heightMultiplier!,
                        ),
                        PinCodeTextField(
                          enableActiveFill: true,
                          textStyle: const TextStyle(color: Color(0xff56646C)),
                          animationType: AnimationType.none,
                          animationDuration: Duration.zero,
                          autoDisposeControllers: false,
                          showCursor: false,
                          keyboardType: const TextInputType.numberWithOptions(
                              signed: false, decimal: true),
                          pinTheme: PinTheme(
                              selectedColor: greenThemeColor.withOpacity(0.6),
                              selectedFillColor: Colors.white,
                              inactiveColor:
                                  const Color(0xffADADAD).withOpacity(0.4),
                              errorBorderColor: Colors.red.withOpacity(0.7),
                              shape: PinCodeFieldShape.box,
                              borderRadius:
                                  BorderRadius.circular(ScreenWidth * 0.013333),
                              fieldHeight: ScreenWidth * 0.13,
                              fieldWidth: 46 * SizeConfig.widthMultiplier!,
                              activeFillColor: Colors.white,
                              inactiveFillColor: Colors.white,
                              activeColor:
                                  const Color(0xffADADAD).withOpacity(0.4),
                              borderWidth: 1),
                          controller: _otpController,
                          obscureText: false,
                          onChanged: (String value) {
                            otpText.value = value;
                            isOtpIncorrect.value = false;
                          },
                          appContext: (context),
                          length: 4,
                        ),
                        SizedBox(
                          height: 20 * SizeConfig.heightMultiplier!,
                        ),
                        Obx(
                          () => Container(
                            width: ScreenWidth,
                            height: 45 * SizeConfig.heightMultiplier!,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(
                                    2 * SizeConfig.widthMultiplier!)),
                                color: otpText.value.length < 4
                                    ? const Color(0xff9F9F9F).withOpacity(0.1)
                                    : _userClickedOnOtpContinue.value
                                        ? greenThemeColor
                                        : const Color(0xffFF7800)),
                            child: Stack(
                              children: [
                                Center(
                                    child: _userClickedOnOtpContinue.value
                                        ? Image.asset(
                                            'images/loader_with_animation.gif',
                                            width: 80 *
                                                SizeConfig.widthMultiplier!,
                                          )
                                        : Text(
                                            "Verify",
                                            style: TextStyle(
                                                color: otpText.value.length < 4
                                                    ? const Color(0xff9F9F9F)
                                                    : const Color(0xffFFFFFF),
                                                fontWeight: FontWeight.w500,
                                                fontSize:
                                                    SizeConfig.textMultiplier! *
                                                        12.0),
                                          )),
                                Positioned.fill(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(
                                          ScreenWidth * 0.01),
                                      onTap: () {
                                        if (!_userClickedOnOtpContinue.value) {
                                          _userClickedOnOtpContinue.value =
                                              true;
                                          validateOtp(phoneNumber.text,
                                              _otpController.text);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  void _checkPasswordStrength(String value) {
    if (value.isNotEmpty) {
      ++_passwordStrength;
    }
    if (value.contains(RegExp(r'[0-9].*[0-9]'))) {
      ++_passwordStrength;
    }
    if (value.contains(RegExp(r'[A-Z]'))) {
      ++_passwordStrength;
    }
    if (value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]')) && value.length > 8) {
      ++_passwordStrength;
    }
  }
}
