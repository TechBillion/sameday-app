import 'dart:core';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../login.dart';
import 'package:flutter/services.dart';

import 'acoountcreated.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

final TextEditingController PhoneNumberController = TextEditingController();
final TextEditingController EmailController = TextEditingController();
final TextEditingController PasswordController = TextEditingController();
final TextEditingController ConfirmPasswordController = TextEditingController();

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>(); //key for form

  bool _isSecure = true;
  bool isSecure = true;

  bool _isLoading = false;

  Future<void> SignUp() async {
    if (PhoneNumberController.text.isNotEmpty &&
        EmailController.text.isNotEmpty &&
        PasswordController.text.isNotEmpty &&
        ConfirmPasswordController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse(
              "http://armanshaikh-001-site1.itempurl.com/api/Account/Register"),
          headers: {
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "true",
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
          },
          body: {
            'PhoneNumber': PhoneNumberController.text,
            'Email': EmailController.text,
            'Password': PasswordController.text,
            'ConfirmPassword': ConfirmPasswordController.text
          });

      if (response.statusCode == 200) {
        print(response.body);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AccountCreated()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.body)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(" Please Enter your details")));
    }
  }

  bool showPassword = false;

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/Login1.png'), fit: BoxFit.cover)),
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
                      controller: PhoneNumberController,
                      style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                      maxLength: 10,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(12),
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        prefixIcon: const Icon(Icons.phone),
                        counterText: "",
                        labelText: "Enter your mobile number",
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
                        labelStyle: const TextStyle(color: Colors.black),
                        prefixText: "+91 ",
                        prefixStyle: GoogleFonts.roboto(
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
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: EmailController,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        prefixIcon: const Icon(Icons.email_outlined),
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
                          return "Enter correct Email ";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: _isSecure,
                      controller: PasswordController,
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
                                  color: Colors.orange,
                                  size: 25,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.orange,
                                  size: 25,
                                ),
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        prefixIcon: const Icon(Icons.phone_iphone),
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      obscureText: isSecure,
                      controller: ConfirmPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSecure = !isSecure;
                            });
                          },
                          child: (isSecure)
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.orange,
                                  size: 25,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.orange,
                                  size: 25,
                                ),
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        prefixIcon: const Icon(Icons.phone_iphone),
                        hintText: 'Confirm Password',
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
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            height: 55.99,
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              shadowColor: Colors.orange[500],
                              color: Colors.orange[500],
                              elevation: 7.0,
                              child: TextButton(
                                onPressed: () {
                                    if(formKey.currentState!.validate()){
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      SignUp();
                                      Future.delayed(
                                          const Duration(seconds: 10), () {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      });
                                    }
                                      },
                                child: const Center(
                                  child: Text(
                                    'SignUp',
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
                                    builder: (context) => const MyLogin()));
                          },
                          child: Text(
                            'Already Registered ? Login',
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
    );
  }
}
