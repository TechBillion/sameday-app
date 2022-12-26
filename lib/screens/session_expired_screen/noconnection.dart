import 'package:app_settings/app_settings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sameday/global_variables.dart';
import 'package:sameday/size_config.dart';
import 'package:sameday/widgets/blue_button.dart';
import 'package:sameday/widgets/polygon_image.dart';

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        InternetConnectionStatus isDeviceConnected =
            await InternetConnectionChecker().connectionStatus;
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
                turns: AlwaysStoppedAnimation(122 / 360),
                child: PolygonImage()),
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
          SizedBox(height: 20 * SizeConfig.heightMultiplier!,),
          Transform.scale(
            scale: 1.3,
            child: Image.asset(
              'images/sameday_text.png',
              width: ScreenWidth * 0.5,
              height: ScreenHeight * 0.03,
            ),
          ),
          SizedBox(height: 50 * SizeConfig.heightMultiplier!,),


          Image.asset(
            "assets/no_connection.png",
            height: 300 * SizeConfig.imageSizeMultiplier!,
          ),
          SizedBox(height: 10* SizeConfig.heightMultiplier!,),

          Text(
            'No Connection To\nThe Internet',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16 * SizeConfig.textMultiplier!,
                fontWeight: FontWeight.w700,
                color: Color(0xff0398FF)),
          ),
          SizedBox(height: 10 * SizeConfig.heightMultiplier!,),

          Text(
            'You’re offline. check your connection\n or try again later',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11 * SizeConfig.textMultiplier!,
                fontWeight: FontWeight.w500,
                color: Color(0xff56646C)),
          ),
          SizedBox(
            height: 20 * SizeConfig.heightMultiplier!,
          ),
          BlueButton(
            title: "Try Again",
            onTap: (){

              AppSettings.openWirelessSettings();

            },

          )
        ],
      ),
    );
  }
}
