//screen height and width of user device will be stored here
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

///selected page for nottom navigation bar

Rx<int> selectedPageIndex = 0.obs;
PageController? pageController;

double ScreenHeight = 0;
double ScreenWidth = 0;
String currentAppVersion = "1.0.4";

bool userIsNew = true;
bool isUserVisitedUpdate = false;
bool? isUpdateCrucial;
String? appVerison;

///user referal code
RxString userReferalCode = ''.obs;

Color blueThemeColor = const Color(0xff1840a4);
//TODO change this to production APi


const greenThemeColor = Color(0xff2BD67B);
const samedayThemeColor = Color(0xffDBF3FA);

const grayTextColor = Color(0xffADADAD);
const grayBorderColor = Color(0xff33adadad);
const darkBlueTextColor = Color(0xff040447);
const grey56Color = Color(0xff56646C);



