import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global_variables.dart';

class CustomBackButton extends StatelessWidget {
  BuildContext parentContext;
  CustomBackButton({Key? key, required this.parentContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: 5, left: 6),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width:46,
          height: 46,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: const Color(0xff416FF4).withOpacity(0),
                  spreadRadius: 20,
                  blurRadius: 5,
                  offset: const Offset(0, 22))
            ]),
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(2),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                shadowColor:
                MaterialStateProperty.all(blueThemeColor.withOpacity(0)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.orange),
              ),
              onPressed: () {
                Navigator.pop(parentContext);
              },
              child: const Center(
                  child: Icon(
                    CupertinoIcons.left_chevron,
                    size: 40,
                    color: Color(0xff040447),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}