import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sameday/screens/services_screens/opd_booking_screen.dart';
import 'package:sameday/size_config.dart';

import '../../widgets/sameday_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  const Color(0xff7AD7F0).withOpacity(0.1),
                  const Color(0xffDBF3FA).withOpacity(0.1)
                ])),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: SameDayAppBar(
              parentContext: context,
              wantBackButton: false,
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: 35 * SizeConfig.widthMultiplier!,
                      top: 15 * SizeConfig.heightMultiplier!),
                  child: Row(
                    children: [
                      Text(
                        'Services',
                        style: TextStyle(
                            color: const Color(0xffFF7D05),
                            fontSize: 14 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5 * SizeConfig.heightMultiplier!,
                ),
                Container(
                    width: 328 * SizeConfig.widthMultiplier!,
                    height: 106 * SizeConfig.heightMultiplier!,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xff1682FA).withOpacity(0.2),
                            blurRadius: 5.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(
                            11 * SizeConfig.widthMultiplier!),
                        color: const Color(0xffFFFFFF)),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 5 * SizeConfig.widthMultiplier!,
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(OpdBookingScreen());
                            },
                            child: _serviceContainer(
                              // onTap:   Navigator.push(
                              //     context, MaterialPageRoute(builder: (context) =>  NoConnection())),
                              imagePath: 'images/opd_icon.png',
                              text: 'OPD\nBuddy',
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          _serviceContainer(
                            // onTap:   Navigator.push(
                            //     context, MaterialPageRoute(builder: (context) =>  NoConnection())),
                            imagePath: 'images/computer_repair_icon.png',
                            text: 'Computer\nRepair',
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          _serviceContainer(
                            // onTap:   Navigator.push(
                            //     context, MaterialPageRoute(builder: (context) =>  NoConnection())),
                            imagePath: 'images/csc_icon.png',
                            text: 'CSC',
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          _serviceContainer(
                            // onTap:   Navigator.push(
                            //     context, MaterialPageRoute(builder: (context) => const NoConnection())),
                            imagePath: 'images/other_icon.png',
                            text: 'Other',
                          ),
                        ],
                      ),
                    )),
                SizedBox(
                  height: 11 * SizeConfig.heightMultiplier!,
                ),
                Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 188 * SizeConfig.widthMultiplier!,
                        viewportFraction: 1,
                        autoPlay: false,
                        autoPlayInterval: Duration(seconds: 2),
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        onPageChanged: (index, reason) =>
                            setState(() => activeIndex = index),
                      ),
                      items: [
                        _serviceScroll(
                          text: 'Book your OPD \nbuddy',
                          imagePath: 'images/doctor_icon.png',
                        ),
                        _serviceScroll(
                          text: 'For Computer\nRelated Query',
                          imagePath: 'images/camputer_repair.png',
                        ),
                        _serviceScroll(
                          text: 'CSC Services',
                          imagePath: 'images/csc_logo.png',
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10 * SizeConfig.heightMultiplier!,
                    ),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 10 * SizeConfig.heightMultiplier!,
                              width: 10 * SizeConfig.widthMultiplier!,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10 * SizeConfig.widthMultiplier!),
                                  color: activeIndex < 0
                                      ? const Color(0xffE7ECF9)
                                      : const Color(0xffFF7800)),
                            ),
                          ),
                          SizedBox(
                            width: 3 * SizeConfig.widthMultiplier!,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 10 * SizeConfig.heightMultiplier!,
                              width: 10 * SizeConfig.widthMultiplier!,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10 * SizeConfig.widthMultiplier!),
                                  color: activeIndex < 1
                                      ? const Color(0xffE7ECF9)
                                      : const Color(0xffFF7800)),
                            ),
                          ),
                          SizedBox(
                            width: 3 * SizeConfig.widthMultiplier!,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 10 * SizeConfig.heightMultiplier!,
                              width: 10 * SizeConfig.widthMultiplier!,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      20 * SizeConfig.widthMultiplier!),
                                  color: activeIndex < 2
                                      ? const Color(0xffE7ECF9)
                                      : const Color(0xffFF7800)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10 * SizeConfig.heightMultiplier!,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 35 * SizeConfig.widthMultiplier!,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Support',
                        style: TextStyle(
                            color: const Color(0xffFF7D05),
                            fontSize: 14 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5 * SizeConfig.heightMultiplier!,
                ),
                Container(
                  width: double.infinity,
                  height: 286 * SizeConfig.heightMultiplier!,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(
                            0,
                            5,
                          ),
                          color: const Color(0xff000000).withOpacity(0.1),
                          blurRadius: 6,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                          20 * SizeConfig.widthMultiplier!),
                      color: const Color(0xffFFFFFF)),
                  child: Transform.scale(
                    scale: 1,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10 * SizeConfig.heightMultiplier!,
                        ),
                        Image.asset('images/support.png',
                            width: 240 * SizeConfig.widthMultiplier!,
                            height: 210 * SizeConfig.heightMultiplier!)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _serviceContainer extends StatelessWidget {
  _serviceContainer({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  final String imagePath;
  String text;

  // Future onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 9 * SizeConfig.widthMultiplier!),
      width: 65 * SizeConfig.widthMultiplier!,
      height: 70 * SizeConfig.heightMultiplier!,
      decoration: BoxDecoration(
          color: const Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(19 * SizeConfig.widthMultiplier!),
          boxShadow: [
            BoxShadow(
              offset: const Offset(
                0,
                5,
              ),
              color: const Color(0xff000000).withOpacity(0.2),
              blurRadius: 5,
            ),
          ]),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.only(top: 7.0 * SizeConfig.heightMultiplier!),
                child: Transform.scale(
                  scale: 1.1,
                  child: Image.asset(
                    imagePath,
                    width: 26 * SizeConfig.widthMultiplier!,
                    height: 26 * SizeConfig.heightMultiplier!,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3 * SizeConfig.heightMultiplier!,
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 10 * SizeConfig.textMultiplier!,
              color: const Color(0xff090D96),
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}

class _serviceScroll extends StatelessWidget {
  _serviceScroll({Key? key, required this.imagePath, required this.text})
      : super(key: key);

  final String imagePath;
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 331 * SizeConfig.widthMultiplier!,
      margin: EdgeInsets.only(
          left: 14 * SizeConfig.widthMultiplier!,
          right: 15 * SizeConfig.widthMultiplier!),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(
                0,
                0,
              ),
              color: const Color(0xff1682FA).withOpacity(0.1),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(11 * SizeConfig.widthMultiplier!),
          color: const Color(0xffFFFFFF)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(
                  top: 49 * SizeConfig.heightMultiplier!,
                  left: 18 * SizeConfig.widthMultiplier!),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    text,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12 * SizeConfig.textMultiplier!,
                        color: const Color(0xff090D96)),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        left: 5 * SizeConfig.widthMultiplier!,
                        top: 10 * SizeConfig.heightMultiplier!),
                    width: 81 * SizeConfig.widthMultiplier!,
                    height: 29 * SizeConfig.heightMultiplier!,
                    decoration: BoxDecoration(
                      color: const Color(0xffFFFFFF),
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(
                            0,
                            5,
                          ),
                          color: const Color(0xff1682FA).withOpacity(0.1),
                          blurRadius: 6,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(
                          24 * SizeConfig.widthMultiplier!),
                    ),
                    child: Center(
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                          color: Color(0xff0398FF),
                          fontSize: 12 * SizeConfig.textMultiplier!,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
                top: 8.0 * SizeConfig.heightMultiplier!,
                bottom: 20 * SizeConfig.heightMultiplier!),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Image.asset(imagePath)

                // Image.asset('images/camputer_repair.png'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
