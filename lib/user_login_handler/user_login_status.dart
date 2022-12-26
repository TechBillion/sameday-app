import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class logInStatus {
  FlutterSecureStorage storage = const FlutterSecureStorage();

  late String accessToken;

  Future<void> userHasLoggedin(
    String token,
  ) async {
    //Storing user token to make user loggedIn for further
    accessToken = token;
    print("testing " + token);
    storage.write(key: 'token', value: token);
  }

  Future<String?> getUserToken() async {
    //return stored token
    String? token;
    await storage.read(key: 'token').then((value) => token = value.toString());
    if (token != null) {
      accessToken = token!;
    }

    return token;
  }

  // Future<String?> getuserEmail() async {
  //   String? userName;
  //   await storage
  //       .read(key: 'email')
  //       .then((value) => userName = value.toString());
  //   return userName;
  // }

  // Future<String?> getuserName() async {
  //   String? userName;
  //   await storage
  //       .read(key: 'userName')
  //       .then((value) => userName = value.toString());
  //   return userName;
  // }

  Future<bool> checkLoginStatus() async {
    //returns true if user is already loggedIn
    var test = await storage.containsKey(key: 'token');
    print("checklogin $test");
    return test;
  }

  Future<void> logOutUser() async {
    //logOutUser
    await storage.deleteAll();
  }
}
