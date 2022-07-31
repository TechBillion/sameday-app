import 'package:flutter/material.dart';
import 'package:samedaypro/login.dart';
import 'package:samedaypro/page/dashboard.dart';
import 'package:samedaypro/register.dart';
import 'package:samedaypro/screeen/loginotp.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:samedaypro/screeen/singnup.dart';

import 'api/google_signin_api.dart';

class LoginHome extends StatefulWidget {
  @override
  State<LoginHome> createState() => _MyLoginHomeState();
}
class _MyLoginHomeState extends State<LoginHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/login.png'), fit: BoxFit.fill)),
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
                    top: MediaQuery.of(context).size.height * 0.6,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    Container(
                      height: 55.99,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.orange[500],
                        color: Colors.orange[500],
                        elevation: 7.0,
                        child:  TextButton(
                          onPressed:  () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => MyLogin()));
                          },
                          child: Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Motserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 55.99,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.blue[500],
                        color: Colors.blue[500],
                        elevation: 7.0,
                        child:  TextButton(
                          onPressed:  ()  {

                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) => SignUp()));
                          },
                          child: const Center(
                            child: Text(
                              'SIGN UP',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      height: 55.99,
                       child: ElevatedButton.icon(
                         style: ElevatedButton.styleFrom(
                           primary: Colors.white,
                           onPrimary: Colors.black,
                           minimumSize: Size(double.infinity,50),
                         ),
                         icon: const FaIcon(
                           FontAwesomeIcons.google,
                           color:Colors.red,
                         ),
                         label: Text('Sing Up with google'),
                         onPressed: signIn,
                       ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Future signIn()  async{
   final user = await GoogleSignInApi.login();
   if(user==null){
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Sign in issue')));
   }

   Navigator.of(context)
       .pushReplacement(MaterialPageRoute(builder: (context) => Dashboard(user:user)));

  }
}
