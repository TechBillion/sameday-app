import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/accordion/gf_accordion.dart';
import 'package:sameday/global_variables.dart';
import 'package:sameday/screens/login_screens/loginscreen.dart';
import 'package:sameday/user_login_handler/user_login_status.dart';
import 'package:sameday/widgets/blue_button.dart';
import 'package:sameday/widgets/sameday_appbar.dart';

import '../../size_config.dart';

class UserSettingScreen extends StatefulWidget {
  bool? wantBackButton;

  UserSettingScreen({
    Key? key,
    this.wantBackButton,
  }) : super(key: key);

  @override
  _UserSettingScreenState createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends State<UserSettingScreen> {
  final logInStatus _loginHandler = logInStatus();



  bool showEmailBorder = false;
  bool showPasswordBorder = false;

  final _oldPasswordKey = GlobalKey<FormState>();

  bool userWantToChangeEmail = false;
  final TextEditingController _newEmail = TextEditingController();
  final TextEditingController _oldPassword = TextEditingController();
  final TextEditingController _newPassword = TextEditingController();

  bool _isOldSecure = true;
  bool _isNewSecure = true;
  final _newPasswordKey = GlobalKey<FormState>();

  final _newEmailKey = GlobalKey<FormState>();

  RxBool isUserTappedOnChangeEmail = false.obs;
  RxBool isUserTappedOnChangePassword = false.obs;

  Widget closeAccordionIcon() {
    return SvgPicture.asset(
      //        <-- Image
      "images/setting_down_arrow_icon.svg",
      width: 7 * SizeConfig.widthMultiplier!,
      height: 8 * SizeConfig.heightMultiplier!,
      fit: BoxFit.contain,
    );
  }

  Widget openAccordionIcon() {
    return RotationTransition(
      turns: AlwaysStoppedAnimation(180 / 360),
      child: SvgPicture.asset(
        //        <-- Image
        "images/setting_down_arrow_icon.svg",
        width: 7 * SizeConfig.widthMultiplier!,
        height: 8 * SizeConfig.heightMultiplier!,
        fit: BoxFit.contain,
      ),
    );
  }

  Color borderColor = const Color.fromRGBO(173, 173, 173, 0.2);
  final color = const Color.fromARGB(242, 244, 248, 255);

  @override
  Widget build(BuildContext context) {
    return Stack(
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
            wantBackButton: widget.wantBackButton != null ? null : true,
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: 25 * SizeConfig.widthMultiplier!,
                      top: 40 * SizeConfig.heightMultiplier!),
                  child: Text("Settings",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff0398FF),
                          fontSize: SizeConfig.textMultiplier! * 20.0))),
              SizedBox(
                height: 15 * SizeConfig.heightMultiplier!,
              ),
              //Change Email
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 5 * SizeConfig.heightMultiplier!),
                margin: EdgeInsets.only(
                  top: 10 * SizeConfig.heightMultiplier!,
                  left: 18 * SizeConfig.widthMultiplier!,
                  right: 17 * SizeConfig.widthMultiplier!,
                ),
                decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.all(
                        Radius.circular(2 * SizeConfig.widthMultiplier!)),
                    border: showEmailBorder
                        ? Border.all(width: 1.0, color: borderColor)
                        : Border.all(color: Colors.transparent)),
                child: GFAccordion(
                  onToggleCollapsed: (value) {
                    setState(() {
                      userWantToChangeEmail = false;
                    });
                    if (value) {
                      setState(() {
                        showEmailBorder = true;
                      });
                    } else {
                      setState(() {
                        showEmailBorder = false;
                      });
                    }
                  },
                  collapsedIcon: closeAccordionIcon(),
                  expandedIcon: openAccordionIcon(),
                  collapsedTitleBackgroundColor: Colors.transparent,
                  expandedTitleBackgroundColor: Colors.transparent,
                  contentBackgroundColor: const Color(0xffFFFFFF),
                  margin: EdgeInsets.zero,
                  titleChild: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 48 * SizeConfig.heightMultiplier!,
                            width: 48 * SizeConfig.widthMultiplier!,
                            decoration:
                                const BoxDecoration(color: Color(0xffF1F9FF)),
                            child: Transform.scale(
                              scale: 0.8,
                              child: Image.asset(
                                "images/setting_email_icon.png",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14 * SizeConfig.widthMultiplier!,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Email",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff4B4B4B),
                                        fontSize:
                                            SizeConfig.textMultiplier! * 14.0,
                                        height: 1.2)),
                                SizedBox(
                                  height: ScreenHeight * 0.005,
                                ),
                                SizedBox(
                                    width: ScreenWidth * 0.57,
                                    child: FutureBuilder(
                                        // future: _userCredentials.getuserEmail(),
                                        builder: (context, snapshot) {
                                      return RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: snapshot.hasData
                                                ? snapshot.data.toString()
                                                : "Loading..",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xff4B4B4B)
                                                    .withOpacity(0.5),
                                                fontSize:
                                                    SizeConfig.textMultiplier! *
                                                        12.0)),
                                      ]));
                                    }))
                              ]),
                        ],
                      ),
                    ],
                  ),
                  contentChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (!userWantToChangeEmail)
                          ? Container(
                              margin: EdgeInsets.only(
                                  top: 10 * SizeConfig.heightMultiplier!,
                                  bottom: 10 * SizeConfig.heightMultiplier!),
                              height: 48 * SizeConfig.heightMultiplier!,
                              width: 238 * SizeConfig.widthMultiplier!,
                              child: Stack(
                                children: [
                                  BlueButton(
                                    title: "Change Email Address",
                                    onTap: () {
                                      setState(() {
                                        userWantToChangeEmail = true;
                                      });
                                    },
                                  )
                                ],
                              ),
                            )
                          : FutureBuilder(
                              // future: _userCredentials.getuserEmail(),
                              builder: (context, snapshot) {
                              return Column(
                                children: [
                                  Container(
                                    width: 238 * SizeConfig.widthMultiplier!,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            2 * SizeConfig.widthMultiplier!)),
                                    margin: EdgeInsets.fromLTRB(
                                        ScreenWidth * 0.03,
                                        0.0,
                                        ScreenWidth * 0.03,
                                        0.0),
                                    child: TextFormField(
                                        readOnly: true,
                                        textInputAction: TextInputAction.next,
                                        autofillHints: const [
                                          AutofillHints.username
                                        ],
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        cursorRadius:
                                            const Radius.circular(10.0),
                                        cursorColor: blueThemeColor,
                                        style: TextStyle(
                                          color: const Color(0xff4B4B4B),
                                          fontSize:
                                              SizeConfig.textMultiplier! * 14.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        decoration: InputDecoration(
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0x33adadad),
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(2 *
                                                      SizeConfig
                                                          .widthMultiplier!)),
                                            ),
                                            prefixIcon: SizedBox(
                                              width: ScreenWidth * 0.05,
                                              child: Center(
                                                  child: SvgPicture.asset(
                                                      "images/email_icon.svg",
                                                      width:
                                                          ScreenWidth * 0.055)),
                                            ),
                                            contentPadding: EdgeInsets.only(
                                                top: ScreenHeight * 0.01,
                                                bottom: ScreenHeight * 0.01),
                                            hintText: (snapshot.hasData)
                                                ? snapshot.data.toString()
                                                : "Loading..",
                                            hintStyle: TextStyle(
                                                color: const Color(0xff4B4B4B)
                                                    .withOpacity(0.7),
                                                fontSize:
                                                    SizeConfig.textMultiplier! *
                                                        14.0,
                                                fontWeight: FontWeight.w400,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: greenThemeColor
                                                      .withOpacity(0.2),
                                                  width: 1),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenWidth * 0.013333)),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      ScreenWidth * 0.013333)),
                                            ))),
                                  ),
                                  //user new password
                                  SizedBox(
                                    height: ScreenHeight * 0.012315,
                                  ),
                                  Container(
                                      width: 238 * SizeConfig.widthMultiplier!,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              2 * SizeConfig.widthMultiplier!)),
                                      margin: EdgeInsets.fromLTRB(
                                          ScreenWidth * 0.03,
                                          0.0,
                                          ScreenWidth * 0.03,
                                          0.0),
                                      child: Form(
                                        key: _newEmailKey,
                                        child: TextFormField(
                                            autofillHints: const [
                                              AutofillHints.username
                                            ],
                                            textInputAction:
                                                TextInputAction.next,
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            validator: (String? value) =>
                                                EmailValidator.validate(value!)
                                                    ? null
                                                    : "Please enter a valid email",
                                            controller: _newEmail,
                                            cursorRadius:
                                                const Radius.circular(10.0),
                                            cursorColor: blueThemeColor,
                                            style: TextStyle(
                                                color: const Color(0xff4B4B4B),
                                                fontWeight: FontWeight.w400,
                                                fontSize:
                                                    SizeConfig.textMultiplier! *
                                                        14.0),
                                            decoration: InputDecoration(
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0x33adadad),
                                                      width: 1),
                                                  borderRadius: BorderRadius
                                                      .all(Radius.circular(2 *
                                                          SizeConfig
                                                              .widthMultiplier!)),
                                                ),
                                                prefixIcon: SizedBox(
                                                  width: ScreenWidth * 0.09,
                                                  child: Center(
                                                      child: SvgPicture.asset(
                                                          "images/email_icon.svg",
                                                          width: ScreenWidth *
                                                              0.055)),
                                                ),
                                                contentPadding: EdgeInsets.only(
                                                    top: ScreenHeight * 0.01,
                                                    bottom:
                                                        ScreenHeight * 0.01),
                                                hintText: "New Email",
                                                hintStyle: TextStyle(
                                                    color:
                                                        const Color(0xff4B4B4B)
                                                            .withOpacity(0.7),
                                                    fontSize: SizeConfig
                                                            .textMultiplier! *
                                                        14.0,
                                                    fontWeight: FontWeight.w400,
                                                    overflow: TextOverflow.ellipsis),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: greenThemeColor
                                                          .withOpacity(0.3),
                                                      width: 1),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              ScreenWidth *
                                                                  0.013333)),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              ScreenWidth *
                                                                  0.013333)),
                                                ))),
                                      )),
                                  SizedBox(
                                    height: ScreenHeight * 0.0123,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                      bottom: ScreenHeight * 0.012,
                                    ),
                                    height: 48 * SizeConfig.heightMultiplier!,
                                    width: 238 * SizeConfig.widthMultiplier!,
                                    child: Stack(
                                      children: [
                                        BlueButton(
                                          title: "Change Email Address",
                                          isLoading: false,
                                          onTap: () {
                                            if (_newEmailKey.currentState!
                                                    .validate() &&
                                                !isUserTappedOnChangeEmail
                                                    .value) {
                                              isUserTappedOnChangeEmail.value =
                                                  false;
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            })
                    ],
                  ),
                ),
              ),
              //Change password
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 5 * SizeConfig.heightMultiplier!),
                margin: EdgeInsets.only(
                  top: 10 * SizeConfig.heightMultiplier!,
                  left: 18 * SizeConfig.widthMultiplier!,
                  right: 17 * SizeConfig.widthMultiplier!,
                ),
                decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF),
                    borderRadius: BorderRadius.all(
                        Radius.circular(2 * SizeConfig.widthMultiplier!)),
                    border: showPasswordBorder
                        ? Border.all(width: 1.0, color: borderColor)
                        : Border.all(color: Colors.transparent)),
                child: GFAccordion(
                  onToggleCollapsed: (value) {
                    if (value) {
                      setState(() {
                        showPasswordBorder = true;
                      });
                    } else {
                      setState(() {
                        showPasswordBorder = false;
                      });
                    }
                  },
                  collapsedIcon: closeAccordionIcon(),
                  expandedIcon: openAccordionIcon(),
                  collapsedTitleBackgroundColor: Colors.transparent,
                  expandedTitleBackgroundColor: Colors.transparent,
                  contentBackgroundColor: const Color(0xffFFFFFF),
                  margin: EdgeInsets.zero,
                  titleChild: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 48 * SizeConfig.heightMultiplier!,
                            width: 48 * SizeConfig.widthMultiplier!,
                            decoration:
                                const BoxDecoration(color: Color(0xffF1F9FF)),
                            child: Transform.scale(
                              scale: 0.8,
                              child: Image.asset(
                                "images/setting_lock_icon.png",
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14 * SizeConfig.widthMultiplier!,
                          ),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Change Password",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: const Color(0xff4B4B4B),
                                        fontSize:
                                            SizeConfig.textMultiplier! * 14.0,
                                        height: 1.2)),
                                SizedBox(
                                  height: ScreenHeight * 0.005,
                                ),
                                Text("******",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: const Color(0xff4B4B4B)
                                          .withOpacity(0.5),
                                      fontSize:
                                          SizeConfig.textMultiplier! * 12.0,
                                    )),
                              ]),
                        ],
                      ),
                    ],
                  ),
                  contentChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //user old password field
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(ScreenWidth * 0.013333)),
                        width: 238 * SizeConfig.widthMultiplier!,
                        child: Form(
                          key: _oldPasswordKey,
                          child: TextFormField(
                            onChanged: (value) {
                              _oldPasswordKey.currentState!.validate();
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "this field is mandatory";
                              } else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.done,
                            controller: _oldPassword,
                            obscureText: _isOldSecure,
                            cursorRadius: const Radius.circular(5.0),
                            cursorColor: blueThemeColor,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff4B4B4B),
                                fontSize: SizeConfig.textMultiplier! * 14.0),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0x33adadad), width: 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          2 * SizeConfig.widthMultiplier!)),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isOldSecure = !_isOldSecure;
                                    });
                                  },
                                  child: (_isOldSecure)
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
                                    top: ScreenHeight * 0.01,
                                    bottom: ScreenHeight * 0.01),
                                hintText: "Old Password",
                                hintStyle: TextStyle(
                                    fontSize: SizeConfig.textMultiplier! * 14.0,
                                    color: const Color(0xff4B4B4B)
                                        .withOpacity(0.7)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: greenThemeColor.withOpacity(0.3),
                                      width: 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenWidth * 0.013333)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenWidth * 0.013333)),
                                )),
                          ),
                        ),
                      ),
                      //user new password
                      SizedBox(
                        height: ScreenHeight * 0.013,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(ScreenWidth * 0.013333)),
                        width: 238 * SizeConfig.widthMultiplier!,
                        child: Form(
                          key: _newPasswordKey,
                          child: TextFormField(
                            onChanged: (value) {
                              _newPasswordKey.currentState!.validate();
                            },
                            validator: (value) {
                              String pattern =
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                              RegExp regExp = RegExp(pattern);
                              if (!regExp.hasMatch(value!)) {
                                return "1- Password should contain one lowercase.\n2- one uppercase.\n3- one special character.\n4- one number. ";
                              } else if (value.isEmpty) {
                                return "this field is mandatory".tr;
                              } else {
                                return null;
                              }
                            },
                            textInputAction: TextInputAction.done,
                            controller: _newPassword,
                            obscureText: _isNewSecure,
                            cursorRadius: const Radius.circular(5.0),
                            cursorColor: blueThemeColor,
                            style: TextStyle(
                                color: grayTextColor,
                                fontSize: SizeConfig.textMultiplier! * 11.0),
                            decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(0x33adadad), width: 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          2 * SizeConfig.widthMultiplier!)),
                                ),
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isNewSecure = !_isNewSecure;
                                    });
                                  },
                                  child: (_isNewSecure)
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
                                    top: ScreenHeight * 0.01,
                                    bottom: ScreenHeight * 0.01),
                                hintText: "New Password",
                                hintStyle: TextStyle(
                                    fontSize: SizeConfig.textMultiplier! * 14.0,
                                    color: Color(0xff4B4B4B).withOpacity(0.7)),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: greenThemeColor.withOpacity(0.3),
                                      width: 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenWidth * 0.013333)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenWidth * 0.013333)),
                                )),
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenHeight * 0.015,
                          bottom: ScreenHeight * 0.015,
                        ),
                        height: 48 * SizeConfig.heightMultiplier!,
                        width: 238 * SizeConfig.widthMultiplier!,
                        child: Stack(
                          children: [
                            BlueButton(
                              title: "Change Password",
                              onTap: () {
                                if (!isUserTappedOnChangePassword.value &&
                                    _newPasswordKey.currentState!.validate() &&
                                    _oldPasswordKey.currentState!.validate()) {
                                  isUserTappedOnChangePassword.value = true;
                                  _newPasswordKey.currentState!.validate();
                                  _oldPasswordKey.currentState!.validate();
                                  if (_newPasswordKey.currentState!
                                          .validate() &&
                                      _oldPasswordKey.currentState!
                                          .validate()) {
                                    isUserTappedOnChangePassword.value = false;
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              //Address
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => CloseAccountScreen()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 5 * SizeConfig.heightMultiplier!),
                  margin: EdgeInsets.only(
                    top: 10 * SizeConfig.heightMultiplier!,
                    left: 18 * SizeConfig.widthMultiplier!,
                    right: 17 * SizeConfig.widthMultiplier!,
                  ),
                  height: 67.98 * SizeConfig.heightMultiplier!,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10 * SizeConfig.widthMultiplier!,),
                      Container(
                        margin: EdgeInsets.only(top: 5 * SizeConfig.heightMultiplier!),
                        height: 48 * SizeConfig.heightMultiplier!,
                        width: 48 * SizeConfig.widthMultiplier!,
                        decoration:
                            const BoxDecoration(color: Color(0xffF1F9FF)),
                        child: Transform.scale(
                          scale: 0.8,
                          child:
                              Image.asset("images/setting_location_icon.png"),
                        ),
                      ),
                      SizedBox(
                        width: 14 * SizeConfig.widthMultiplier!,
                      ),

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8 * SizeConfig.heightMultiplier!,
                            ),
                            Text("Address",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff4B4B4B),
                                    fontSize:
                                    SizeConfig.textMultiplier! * 14.0,
                                    height: 1.2)),
                            SizedBox(
                              height: ScreenHeight * 0.005,
                            ),
                            SizedBox(
                                width: ScreenWidth * 0.57,
                                child: Text(
                                  "See All Address",
                                  style: TextStyle(
                                    fontSize: 10 * SizeConfig.textMultiplier!,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff696969)

                                  ),
                                ))
                          ]),



                      
                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 25 * SizeConfig.heightMultiplier!,
                            right: 9 * SizeConfig.widthMultiplier!),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(180 / 240),
                          child: SvgPicture.asset(
                            //        <-- Image
                            "images/setting_down_arrow_icon.svg",
                            width: 7 * SizeConfig.widthMultiplier!,
                            height: 8 * SizeConfig.heightMultiplier!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),


              //Order History
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => CloseAccountScreen()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 5 * SizeConfig.heightMultiplier!),
                  margin: EdgeInsets.only(
                    top: 10 * SizeConfig.heightMultiplier!,
                    left: 18 * SizeConfig.widthMultiplier!,
                    right: 17 * SizeConfig.widthMultiplier!,
                  ),
                  height: 67.98 * SizeConfig.heightMultiplier!,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10 * SizeConfig.widthMultiplier!,),
                      Container(
                        margin: EdgeInsets.only(top: 5 * SizeConfig.heightMultiplier!),
                        height: 48 * SizeConfig.heightMultiplier!,
                        width: 48 * SizeConfig.widthMultiplier!,
                        decoration:
                        const BoxDecoration(color: Color(0xffF1F9FF)),
                        child: Transform.scale(
                          scale: 0.8,
                          child:
                          Image.asset("images/setting_order_history_icon.png"),
                        ),
                      ),
                      SizedBox(
                        width: 14 * SizeConfig.widthMultiplier!,
                      ),

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 8 * SizeConfig.heightMultiplier!,
                            ),
                            Text("Address",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff4B4B4B),
                                    fontSize:
                                    SizeConfig.textMultiplier! * 14.0,
                                    height: 1.2)),
                            SizedBox(
                              height: ScreenHeight * 0.005,
                            ),
                            SizedBox(
                                width: ScreenWidth * 0.57,
                                child: Text(
                                  "See All Address",
                                  style: TextStyle(
                                      fontSize: 10 * SizeConfig.textMultiplier!,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff696969)

                                  ),
                                ))
                          ]),




                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 25 * SizeConfig.heightMultiplier!,
                            right: 9 * SizeConfig.widthMultiplier!),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(180 / 240),
                          child: SvgPicture.asset(
                            //        <-- Image
                            "images/setting_down_arrow_icon.svg",
                            width: 7 * SizeConfig.widthMultiplier!,
                            height: 8 * SizeConfig.heightMultiplier!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              //Help Center
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => CloseAccountScreen()));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 5 * SizeConfig.heightMultiplier!),
                  margin: EdgeInsets.only(
                    top: 10 * SizeConfig.heightMultiplier!,
                    left: 18 * SizeConfig.widthMultiplier!,
                    right: 17 * SizeConfig.widthMultiplier!,
                  ),
                  height: 67.98 * SizeConfig.heightMultiplier!,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10 * SizeConfig.widthMultiplier!,),
                      Container(
                        margin: EdgeInsets.only(top: 5 * SizeConfig.heightMultiplier!),
                        height: 48 * SizeConfig.heightMultiplier!,
                        width: 48 * SizeConfig.widthMultiplier!,
                        decoration:
                        const BoxDecoration(color: Color(0xffF1F9FF)),
                        child: Transform.scale(
                          scale: 0.8,
                          child:
                          Image.asset("images/setting_helpdesk_icon.png"),
                        ),
                      ),
                      SizedBox(
                        width: 14 * SizeConfig.widthMultiplier!,
                      ),

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20 * SizeConfig.heightMultiplier!,
                            ),
                            Text("Help Center",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff4B4B4B),
                                    fontSize:
                                    SizeConfig.textMultiplier! * 14.0,
                                    height: 1.2)),

                          ]),




                      Spacer(),
                      Padding(
                        padding: EdgeInsets.only(
                            top: 25 * SizeConfig.heightMultiplier!,
                            right: 9 * SizeConfig.widthMultiplier!),
                        child: RotationTransition(
                          turns: AlwaysStoppedAnimation(180 / 240),
                          child: SvgPicture.asset(
                            //        <-- Image
                            "images/setting_down_arrow_icon.svg",
                            width: 7 * SizeConfig.widthMultiplier!,
                            height: 8 * SizeConfig.heightMultiplier!,
                            fit: BoxFit.contain,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
               //Logout
              GestureDetector(
                onTap: () {
                  _loginHandler.logOutUser();
                  Future.delayed(
                      const Duration(microseconds: 50), () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            const LogInScreen()),
                            (route) => false);
                    // Get.offAll(() => const LogInScreen());
                    selectedPageIndex.value = 0;
                    pageController!.jumpToPage(0);
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 5 * SizeConfig.heightMultiplier!),
                  margin: EdgeInsets.only(
                    top: 10 * SizeConfig.heightMultiplier!,
                    left: 18 * SizeConfig.widthMultiplier!,
                    right: 17 * SizeConfig.widthMultiplier!,
                  ),
                  height: 67.98 * SizeConfig.heightMultiplier!,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFFFFF),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width: 10 * SizeConfig.widthMultiplier!,),
                      Container(
                        margin: EdgeInsets.only(top: 5 * SizeConfig.heightMultiplier!),
                        height: 48 * SizeConfig.heightMultiplier!,
                        width: 48 * SizeConfig.widthMultiplier!,
                        decoration:
                        const BoxDecoration(color: Color(0xffF1F9FF)),
                        child: Transform.scale(
                          scale: 0.8,
                          child:
                          Image.asset("images/setting_logout_icon.png"),
                        ),
                      ),
                      SizedBox(
                        width: 14 * SizeConfig.widthMultiplier!,
                      ),

                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20 * SizeConfig.heightMultiplier!,
                            ),
                            Text("Logout",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff4B4B4B),
                                    fontSize:
                                    SizeConfig.textMultiplier! * 14.0,
                                    height: 1.2)),

                          ]),




                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
