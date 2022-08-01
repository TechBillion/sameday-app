import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:samedaypro/screeen/testhome.dart';
import '../api/login_handler.dart';
import '../loginhome.dart';
import '../page/dashboard.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => StartState();
}

class StartState extends State<SplashScreen> {
  final storage = FlutterSecureStorage();



  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1, milliseconds: 500), () {
      checkLogInStatus();
    });
    super.initState();
    getToken();
    getuserEmail();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Image.asset("assets/login.png",
              ),
          )
        ],
      ),
    );
  }

  Future<void> checkLogInStatus() async {
    logInStatus _check = logInStatus();
    bool isLoggedIn = await _check.checkLoginStatus();
    if (isLoggedIn) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => TestHome()));
    } else {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => LoginHome()));
    }
  }


  void getToken() async {
    String? token = await storage.read(key: "access_token");
    print("hello $token");
  }


  void getuserEmail() async {
    String? userName = await storage.read(key: "userName");

    print(userName);
  }
}