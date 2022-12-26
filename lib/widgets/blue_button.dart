import 'package:flutter/material.dart';

import '../size_config.dart';

class BlueButton extends StatelessWidget {
  bool buttonIsEnabled;
  GestureTapCallback? onTap;
  bool isLoading;
  bool wantMargin;
  String? title;

  BlueButton(
      {Key? key,
      this.buttonIsEnabled = true,
      this.onTap,
      this.isLoading = false,
      this.wantMargin = true,
      this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: wantMargin
          ? EdgeInsets.symmetric(horizontal: 10 * SizeConfig.widthMultiplier!)
          : EdgeInsets.zero,
      width: 330 * SizeConfig.widthMultiplier!,
      height: 56 * SizeConfig.heightMultiplier!,
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(7 * SizeConfig.widthMultiplier!)),
        color: !buttonIsEnabled
            ? Color(0xff9F9F9F).withOpacity(0.1)
            : Color(0xffFF7800),
      ),
      child: Stack(
        children: [
          Center(
              child: isLoading
                  ? Image.asset(
                      'images/loader_with_animation.gif',
                      width: 80 * SizeConfig.widthMultiplier!,
                    )
                  : Text(
                      title != null ? title ?? '' : "Continue",
                      style: TextStyle(
                          color: !buttonIsEnabled
                              ? Color(0xff9F9F9F)
                              : Color(0xffEDFCFE),
                          fontWeight: FontWeight.w500,
                          fontSize: SizeConfig.textMultiplier! * 16.0),
                    )),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(7 * SizeConfig.widthMultiplier!),
                onTap: onTap,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
