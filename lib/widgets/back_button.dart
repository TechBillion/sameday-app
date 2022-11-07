import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sameday/size_config.dart';

import '../global_variables.dart';

class CustomBackButton extends StatelessWidget {
  BuildContext parentContext;
  CustomBackButton({Key? key, required this.parentContext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: ScreenHeight * 0.045, left: ScreenWidth * 0.09866),
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          width: ScreenWidth * 0.1146,
          height: ScreenWidth * 0.1146,
          child: Container(
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: const Color(0xff416FF4).withOpacity(0.22),
                  spreadRadius: -ScreenWidth * 0.01,
                  blurRadius: ScreenWidth * 0.08,
                  offset: Offset(0, ScreenHeight * 0.0098522))
            ]),
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0.0),
                padding: MaterialStateProperty.all(EdgeInsets.zero),
                shadowColor:
                MaterialStateProperty.all(blueThemeColor.withOpacity(0.3)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ScreenWidth * 0.013333),
                )),
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {
                Navigator.pop(parentContext);
              },
              child: Center(
                  child: Icon(
                    CupertinoIcons.left_chevron,
                    size: ScreenWidth * 0.04,
                    color: const Color(0xff040447),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

class LoaderImage extends StatelessWidget {
  const LoaderImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(child: Image.asset('images/loader_with_animation.gif',width: 80*SizeConfig.widthMultiplier!,));
  }
}

