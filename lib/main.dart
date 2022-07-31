import 'package:samedaypro/screeen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:samedaypro/loginhome.dart';
import 'package:samedaypro/page/dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;

  Widget page = SplashScreen();
  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();

    checkLogin();
    isLoading = false;
  }

  void checkLogin() async {
    String? token = await storage.read(key: "access_token");
    if (token != null) {
      setState(() {
        page = const Dashboard();
      });
    } else {
      setState(() {
        page = LoginHome();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
