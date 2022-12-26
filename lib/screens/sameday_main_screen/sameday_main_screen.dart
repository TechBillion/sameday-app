import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sameday/screens/sameday_main_screen/homescreen.dart';
import 'package:sameday/screens/sameday_main_screen/secondhome_screen.dart';

import '../../global_variables.dart';
import '../../notificationservice/local_notification_service_dart.dart';
import '../../size_config.dart';
import '../services_screens/opd_booking_screen.dart';
import '../user_setting_screen/user_setting_screen.dart';

class SameDayMainScreen extends StatefulWidget {
  const SameDayMainScreen({Key? key}) : super(key: key);

  @override
  SameDayMainScreenState createState() => SameDayMainScreenState();
}

class SameDayMainScreenState extends State<SameDayMainScreen>
    with TickerProviderStateMixin {
  String deviceTokenToSendPushNotification = "";

  //scaffoldKey to open drawer
  var scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<SameDayMainScreenState> key = GlobalKey();

  Future<void> getDeviceTokenToSendNotification() async {
    final FirebaseMessaging _fcm = FirebaseMessaging.instance;
    final token = await _fcm.getToken();
    deviceTokenToSendPushNotification = token.toString();
    print("Token Value $deviceTokenToSendPushNotification");
  }

  //index for screen management in indexed stack

  @override
  void initState() {
    pageController =
        PageController(initialPage: selectedPageIndex.value, keepPage: true);
    super.initState();

    // 1. This method call when app in terminated state and you get a notification
    // when you click on notification app open from terminated state and you can get notification data in this method

    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
      (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
      (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message.data22 ${message.data['_id']}");
        }
      },
    );

    Future.delayed(const Duration(seconds: 1, milliseconds: 100), () {
      //checkupdate();
    });
    pageController!.addListener(() {
      if (isUserVisitedUpdate == false) {
        Future.delayed(const Duration(seconds: 1, milliseconds: 100), () {
          //checkupdate();
        });
      } else if (isUpdateCrucial == true && isUserVisitedUpdate == true) {
        Future.delayed(const Duration(seconds: 1, milliseconds: 100), () {
          //checkupdate();
        });
      }
    });
  } //bottom navigation bar items

  List<BottomNavigationBarItem> buildBottomNavBarItems() {
    return [
      BottomNavigationBarItem(
        icon: SvgPicture.asset("images/home_icon.svg",
            height: ScreenWidth * 0.0642,
            width: ScreenWidth * 0.0642,
            color: selectedPageIndex == 0
                ? const Color(0xff4AB4FF).withOpacity(0.51)
                : const Color(0xffD8D2E4)),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset("images/cart_icon.svg",
            height: ScreenWidth * 0.0642,
            width: ScreenWidth * 0.0642,
            color: selectedPageIndex == 1
                ? const Color(0xff82CCFF)
                : const Color(0xffD8D2E4)),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset("images/fav_icon.svg",
            height: ScreenWidth * 0.0642,
            width: ScreenWidth * 0.0642,
            color: selectedPageIndex == 2
                ? const Color(0xff82CCFF)
                : const Color(0xffD8D2E4)),
        label: "",
      ),
      BottomNavigationBarItem(
        icon: SvgPicture.asset(
          "images/proflie_icon.svg",
          height: ScreenWidth * 0.0642,
          width: ScreenWidth * 0.0642,
          color: selectedPageIndex == 3
              ? const Color(0xff82CCFF)
              : const Color(0xffD8D2E4),
        ),
        label: "",
      ),
    ];
  }

  //Map of key to handle navigator pop in screens
  Map<int, GlobalKey<NavigatorState>?> navigatorKeys = {
    0: GlobalKey(),
    1: GlobalKey(),
    2: GlobalKey(),
    3: GlobalKey(),
    4: GlobalKey(),
  };

  @override
  Widget build(BuildContext context) {
    getDeviceTokenToSendNotification();
    return Scaffold(
        extendBody: true,
        key: key,
        body: WillPopScope(
          onWillPop: () async {
            // return !await navigatorKeys[_pageIndex].currentState.context;
            return true;
            // Navigator.pop(navigatorKeys[_pageIndex].currentState.context);
          },
          child: Obx(
            () => (selectedPageIndex.value != null)
                ? PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: pageController,
                    //list of pages to navigate through bottom navigation bar
                    children: [
                      HomeScreen(),
                      SecondHomeScreen(),
                      OpdBookingScreen(),

                      // const  activityAndTransactionsScreen(),
                       UserSettingScreen(),
                    ],
                  )
                : Container(),
          ),
        ),
        bottomNavigationBar: Obx(
          () => Container(
              height: (Platform.isAndroid)
                  ? 65 * SizeConfig.heightMultiplier!
                  : ScreenHeight * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10 * SizeConfig.widthMultiplier!),
                    topLeft: Radius.circular(10 * SizeConfig.widthMultiplier!)),
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromRGBO(
                        30,
                        56,
                        187,
                        0.1,
                      ),
                      spreadRadius: 0,
                      blurRadius: ScreenHeight * 0.0615,
                      offset: const Offset(10, 0)),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10 * SizeConfig.widthMultiplier!),
                  topRight: Radius.circular(10 * SizeConfig.widthMultiplier!),
                ),
                child: Theme(
                  data: ThemeData(
                      highlightColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent),
                  child: BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    backgroundColor: Colors.white,
                    type: BottomNavigationBarType.fixed,
                    currentIndex: selectedPageIndex.value,
                    unselectedItemColor: Colors.black54,
                    items: buildBottomNavBarItems(),
                    onTap: (index) {
                      setState(() {
                        selectedPageIndex.value = index;
                      });
                      pageController!.jumpToPage(index);
                    },
                    selectedIconTheme: IconThemeData(
                      color: blueThemeColor,
                    ),
                    selectedLabelStyle: TextStyle(color: blueThemeColor),
                    selectedItemColor: blueThemeColor,
                  ),
                ),
              )),
        ));
  }
}
