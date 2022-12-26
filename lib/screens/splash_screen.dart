import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sameday/screens/sameday_main_screen/sameday_main_screen.dart';
import 'package:sameday/screens/signup_screens/signinscreen.dart';
import 'package:sameday/user_login_handler/user_login_status.dart';

import '../global_variables.dart';
import '../main.dart';
import '../size_config.dart';
import 'session_expired_screen/noconnection.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final storage = const FlutterSecureStorage();


  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      checkLogInStatus();
    });
    getConnectivity();
    super.initState();
    getToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //putting value of user screen size in global variable for further use
    ScreenHeight = MediaQuery.of(context).size.height;
    ScreenWidth = MediaQuery.of(context).size.width;
    return ScreenUtilInit(
        designSize: const Size(375, 814),
        minTextAdapt: true,
        builder: (a, b) {
          return LayoutBuilder(builder: (context, constraints) {
            return OrientationBuilder(builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return Material(
                child: Stack(
                  children: [
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              // stops: [0.0,0.2],
                              colors: [Color(0xff7AD7F0), Color(0xffDBF3FA)],
                              tileMode: TileMode.clamp)),
                    ),
                    Column(children: [
                      Transform.scale(
                        scale: 1.2,
                        child: Container(
                            margin: EdgeInsets.only(
                                top: ScreenHeight * 0.3,
                                left: ScreenWidth * 0.0),
                            child: Image.asset(
                              "assets/samedaylogo.png",
                              width: ScreenWidth * 0.99,
                            )),
                      ),
                    ]),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset(
                          "assets/ellipse_shadow.png",
                          width: ScreenWidth * 0.76,
                          height: ScreenWidth * 0.76,
                        )),
                    Transform.translate(
                      offset: const Offset(0, -20),
                      child: Container(
                          height: ScreenWidth * 0.504,
                          width: ScreenWidth * 0.504,
                          margin: EdgeInsets.only(
                              top: 40 * SizeConfig.heightMultiplier!),
                          child: Transform.rotate(
                              angle: 1,
                              child: Image.asset(
                                "assets/polygon_.png",
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Transform.translate(
                      offset:
                          Offset(ScreenHeight * 0.06, -ScreenHeight * 0.075),
                      child: Container(
                          height: ScreenWidth * 0.504,
                          width: ScreenWidth * 0.504,
                          margin: EdgeInsets.only(
                              left: 140 * SizeConfig.widthMultiplier!,
                              top: 50 * SizeConfig.heightMultiplier!),
                          child: Transform.rotate(
                              angle: 1,
                              child: Image.asset(
                                "assets/polygon_.png",
                                fit: BoxFit.contain,
                              ))),
                    ),
                    Container(
                        height: ScreenWidth * 0.504,
                        width: ScreenWidth * 0.504,
                        margin: EdgeInsets.only(
                            top: ScreenHeight * 0.22,
                            left: 150 * SizeConfig.widthMultiplier!),
                        child: Transform.rotate(
                            angle: 1,
                            child: Image.asset(
                              "assets/polygon_.png",
                              fit: BoxFit.contain,
                            ))),
                  ],
                ),
              );
            });
          });
        });
  }

  late StreamSubscription subscription;
  InternetConnectionStatus isDeviceConnected =
      InternetConnectionStatus.disconnected;

  getConnectivity() async {
    isDeviceConnected = await InternetConnectionChecker().connectionStatus;
    if (isDeviceConnected == InternetConnectionStatus.disconnected) {
      BuildContext context = Get.context!;
      Future.delayed(const Duration(seconds: 4), () async {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoConnection()));
        Get.closeAllSnackbars();
      });
    }
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().connectionStatus;
      if (isDeviceConnected == InternetConnectionStatus.disconnected) {
        BuildContext context = Get.context!;
        // ignore: use_build_context_synchronously
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NoConnection()));
        Get.closeAllSnackbars();
      } else {
        if (navigatorKey.currentState!.canPop()) {
          Navigator.pop(Get.context!);
        }
      }
    });
  }

  Future<void> checkLogInStatus() async {
    logInStatus _check = logInStatus();
    bool isLoggedIn = await _check.checkLoginStatus();
    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const SameDayMainScreen()));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Signinhome()));
    }
  }

  void getToken() async {
    String? token = await storage.read(key: 'token');

    print("hellooooooooo $token");
  }
}
