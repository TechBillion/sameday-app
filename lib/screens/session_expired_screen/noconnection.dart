import 'package:app_settings/app_settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sameday/global_variables.dart';
import 'package:sameday/size_config.dart';
import 'package:sameday/widgets/polygon_image.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        InternetConnectionStatus isDeviceConnected = await InternetConnectionChecker().connectionStatus;
        return isDeviceConnected == InternetConnectionStatus.connected;
      },
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
          Transform.translate(
            offset: Offset(0, -50 * SizeConfig.heightMultiplier!),
            child: Container(
              margin: EdgeInsets.only(
                  left: 110 * SizeConfig.widthMultiplier!,
                  top: 0 * SizeConfig.heightMultiplier!),
              height: 130 * SizeConfig.imageSizeMultiplier!,
              child: const RotationTransition(
                  turns: AlwaysStoppedAnimation(122 / 360),
                  child: PolygonImage()),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: 230 * SizeConfig.widthMultiplier!,
                top: 30 * SizeConfig.heightMultiplier!),
            height: 130 * SizeConfig.imageSizeMultiplier!,
            child: const RotationTransition(
                turns: AlwaysStoppedAnimation(122 / 360), child: PolygonImage()),
          ),
          const SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: NoConnections()),
          ),
        ],
      ),
    );
  }
}

class NoConnections extends StatelessWidget {
  const NoConnections({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 20 * SizeConfig.heightMultiplier!,
          ),
          Image.asset(
            "assets/samedaylogo.png",
            height: 26 * SizeConfig.imageSizeMultiplier!,
          ),
          SizedBox(
            height: 100 * SizeConfig.heightMultiplier!,
          ),
          Image.asset(
            "assets/no_connection.png",
            height: 330 * SizeConfig.imageSizeMultiplier!,
          ),
          Text(
            'No Connection To\nThe internet',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16.93 * SizeConfig.textMultiplier!,
                fontWeight: FontWeight.w700,
                color: darkBlueTextColor),
          ),
          Text(
            'You’re offline. check your connection\n or try again later',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11 * SizeConfig.textMultiplier!,
                fontWeight: FontWeight.w400,
                color: Color(0xff56646C)),
          ),
          SizedBox(
            height: 15 * SizeConfig.heightMultiplier!,
          ),
          GestureDetector(
            onTap: (){
              AppSettings.openWirelessSettings();

            },
            child: Container(
                margin: EdgeInsets.fromLTRB(
                    ScreenWidth * 0.1, 0.0, ScreenWidth * 0.1, 0.0),
                child: Container(
                  width: 270 * SizeConfig.widthMultiplier!,
                  height: 60 * SizeConfig.heightMultiplier!,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(2)),
                    color: Color(0xff223DC1),
                  ),
                  child: Stack(
                    children: [
                      Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: ScreenWidth * 0.01,
                              ),
                              Text(
                                "Try Again",
                                style: TextStyle(
                                    color: const Color(0xffEDFCFE),
                                    fontWeight: FontWeight.w500,
                                    fontSize: SizeConfig.textMultiplier! * 16.0),
                              ),


                            ],
                          )),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
