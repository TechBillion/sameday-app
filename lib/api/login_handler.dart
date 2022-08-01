import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class logInStatus {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  late String accessToken;
  Future<void> userHasLoggedin(
      String token,
      String userName,
  ) async {
    //Storing user token to make user loggedIn for further

    accessToken = token;
    storage.write(key: 'access_token', value: token);

    storage.write(key: 'userName', value: userName);

  }

  Future<String?> getUserToken() async {
    //return stored token
    String? token;
    await storage.read(key: 'access_token').then((value) => token = value.toString());
    if (token != null) {
      accessToken = token!;
    }

    return token;
  }





  Future<String?> getuserEmail() async {
    String? userName;
    await storage.read(key: 'userName').then((value) => userName = value.toString());
    return userName;
  }


  Future<bool> checkLoginStatus() async {
    //returns true if user is already loggedIn
    return await storage.containsKey(key: 'access_token');
  }



  Future<void> logOutUser() async {
    //logOutUser
    await storage.deleteAll();
  }
}
