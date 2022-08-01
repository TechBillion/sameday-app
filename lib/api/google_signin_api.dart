
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static const _clientIDWeb ='278227473131-4ifvbc4g8itri8q9bq2ippsafs3250qt.apps.googleusercontent.com';
  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}
