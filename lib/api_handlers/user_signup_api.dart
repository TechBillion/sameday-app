
import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:sameday/global_variables.dart';

class signUpAPI {
  String phoneNumber;
  String email;
  String password;
  String confirmPassword;



  signUpAPI(
      {
        required this.phoneNumber,
        required this.email,
        required this.password,
        required this.confirmPassword,

      });

 Future<int>accountSignUp() async {
    final response = await http.post(Uri.parse("http://apis.samedaylko.com/api/Auth/register"),
        body:jsonEncode ({
          "phoneNumber":phoneNumber,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,

        }),
    headers:  {

      HttpHeaders.contentTypeHeader : 'application/json',


   },


    );







    if (response.statusCode == 200) {
      //if account created successfully then return 1
      return 1;
    } else if (response.statusCode == 400) {
      //if userAccount already exists in database return 0
      return 0;
    } else {
      //if any other error occurs return 2
      return 2;
    }
  }


}



