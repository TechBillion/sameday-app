
import 'package:flutter/material.dart';



class TestHome extends StatefulWidget {
  const TestHome({Key? key}) : super(key: key);

  @override
  State<TestHome> createState() => _TestHomeState();
}

class _TestHomeState extends State<TestHome> {


  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/Testhome.png'),

          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(

        ),
      ),
    );
  }


}

