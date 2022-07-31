import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  _MyHeaderDrawerState createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  final storage = const FlutterSecureStorage();

  String? username ;

  @override
  void initState() {
    super.initState();
    getuserEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/img.jpg'),
              ),
            ),
          ),
          Text(
            username??"loading..",
            style: GoogleFonts.poppins(
              textStyle:
              Theme.of(context).textTheme.bodyMedium,
              fontWeight: FontWeight.bold,
            ),

          ),

        ],
      ),



    );


  }


  getuserEmail() async {
    final String? userName = await storage.read(key: "userName");
    username = userName;
    setState(() {

    });
    return userName;
  }
}
