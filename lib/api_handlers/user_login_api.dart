import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:sameday/user_login_handler/user_login_status.dart';

class logInAPI {
  Future<int> checkUserCredentials(
      {required String userName, required String password}) async {
    final response = await http.post(
      Uri.parse("http://apis.samedaylko.com/api/Auth/token"),
      body: jsonEncode({
        "userName": userName.toString(),
        "password": password.toString(),
      }),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    print("body${response.statusCode}");
    print("token${response.body}");

    if (response.statusCode == 201) {
      String data = response.body;
      var authStatus = jsonDecode(data);

      //getting token from response after logged in
      String token = authStatus['token'].toString();

      print("auth staus $token");

      setLoginStatus(token);

      //Checking authStatus and returning integer values

    }

    print("hiii" + response.statusCode.toString());
    return response.statusCode;
  }

  void setLoginStatus(String token) {
    logInStatus _userHasLoggedIn = logInStatus();
    _userHasLoggedIn.userHasLoggedin(token);
  }
}
