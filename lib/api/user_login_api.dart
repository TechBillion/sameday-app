import 'dart:convert';
import 'package:http/http.dart' as http;
import 'login_handler.dart';



class logInAPI {
  Future<int> checkUserCredentials(
      {required String username, required String password}) async {
    final response = await http.post(
        Uri.parse("http://armanshaikh-001-site1.itempurl.com/token"),
        encoding: Utf8Codec(),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "true",
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
        },
        body: {
          'username': username.toString(),
          'password': password.toString(),
          'grant_type': 'password'.toString(),

        });
    if (response.statusCode == 200) {
      String data = response.body;
      var authStatus =   json.decode(response.body);

      int? checkAuthStatus = authStatus['authStatus'];
      String userName = authStatus['userName'].toString();
      String token = authStatus['access_token'].toString();
      print(token);

      if (checkAuthStatus == 1) {
        setLoginStatus(token, userName);
        return 0;
      } else if (checkAuthStatus == 6) {
        return 1;
      } else if (checkAuthStatus == 4) {
        return 2;
      }

    }
    return response.statusCode;

  }

  void setLoginStatus(String token,String userName){
    logInStatus _userHasLoggedIn = logInStatus();
    _userHasLoggedIn.userHasLoggedin(token,userName);
  }

}
