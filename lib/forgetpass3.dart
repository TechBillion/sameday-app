import 'package:flutter/material.dart';

class Forgetpass3 extends StatefulWidget {
  const Forgetpass3({Key? key}) : super(key: key);

  @override
  State<Forgetpass3> createState() => _Forgetpass3State();
}

class _Forgetpass3State extends State<Forgetpass3> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/rstpass3.png'), fit: BoxFit.cover)),
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
                    top: MediaQuery.of(context).size.height * 0.7,
                    right: 35,
                    left: 35),
                child: Column(
                  children: [
                    const Text(
                      'Your Password Has Been Reset SuccessFully',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontFamily: 'Montserrat'),                      ),
                    const SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: 55.99,
                      child: Material(
                        borderRadius: BorderRadius.circular(10.0),
                        shadowColor: Colors.orange[500],
                        color: Colors.orange[500],
                        elevation: 7.0,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, 'login');
                          },
                          child: const Center(
                            child: Text(
                              'Sign In',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat'),
                            ),
                          ),
                        ),
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
}
