import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:samedaypro/page/dashboard.dart';
import 'package:samedaypro/screeen/singnup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:samedaypro/size_cofig.dart';

import 'api/login_handler.dart';
import 'global_variables.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool _isSecure = true;

  final storage = const FlutterSecureStorage();
  bool _isLoading = false;
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>(); //key for form

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (email.text.isNotEmpty && password.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("http://armanshaikh-001-site1.itempurl.com/token"),
          encoding: const Utf8Codec(),
          headers: {
            "Content-Type": "application/x-www-form-urlencoded",
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "true",
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
          },
          body: {
            'username': email.text,
            'password': password.text,
            'grant_type': 'password',
          });

      if (response.statusCode == 200) {
        var UserData = json.decode(response.body);
       String  token =   (UserData["access_token"]);
        String  userName =     (UserData["userName"]);
        setLoginStatus(token, userName);


        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Dashboard()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Username or Password is incorrect",
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 5),
        ));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text(" Please Enter your details")));
    }




  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Login1.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.4,
                    right: 35,
                    left: 35),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        controller: email,
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          prefixIcon: const Icon(Icons.account_circle_outlined),
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                          )),
                        ),
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(value)) {
                            return "Enter correct Email";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        obscureText: _isSecure,
                        controller: password,
                        decoration: InputDecoration(
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isSecure = !_isSecure;
                              });
                            },
                            child: (_isSecure)
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Color(0xffBDBDBD),
                                    size: 25,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.orange,
                                    size: 25,
                                  ),
                          ),
                          fillColor: Colors.grey.shade100,
                          prefixIcon: const Icon(Icons.lock_outline),
                          filled: true,
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.orange,
                          )),
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forget Password',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 15,
                                color: Colors.blue[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      _isLoading
                          ? const CircularProgressIndicator( color: Colors.orange,backgroundColor: Colors.blue,) : SizedBox(
                        height: 55.99,
                        child: Material(
                          borderRadius: BorderRadius.circular(10.0),
                          shadowColor: Colors.orange[500],
                          color: Colors.orange[500],
                          elevation: 7.0,
                          child: ElevatedButton(
                            onPressed: email.text == "" ||
                                password.text == ""
                                ? null
                                : () {
                              if(formKey.currentState!.validate()){
                                setState(() {
                                  _isLoading = true;
                                });
                                login();
                                Future.delayed(
                                    const Duration(seconds: 6), () {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                });
                              }
                            },
                            child: const Center(
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const SignUp()));
                            },
                            child: Text(
                              'New User ? Sign Up',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontSize: 15,
                                color: Colors.blue[300],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }



  void setLoginStatus(String token,String userName){
    logInStatus _userHasLoggedIn = logInStatus();
    _userHasLoggedIn.userHasLoggedin(token,userName);
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
