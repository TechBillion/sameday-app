import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sameday/size_config.dart';

import '../../widgets/sameday_appbar.dart';

class SecondHomeScreen extends StatefulWidget {
  const SecondHomeScreen({Key? key}) : super(key: key);

  @override
  _SecondHomeScreenState createState() => _SecondHomeScreenState();
}

class _SecondHomeScreenState extends State<SecondHomeScreen> {
  int activeIndex = 2;

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
                ])
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: SameDayAppBar(
              parentContext: context,
              wantBackButton: false,
            ),
            body: ListView(
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
                    margin: EdgeInsets.only(
                        left: 22 * SizeConfig.widthMultiplier!,
                        right: 22 * SizeConfig.widthMultiplier!),
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
                          _serviceContainer(
                            // onTap:   Navigator.push(
                            //     context, MaterialPageRoute(builder: (context) =>  NoConnection())),
                            imagePath: 'images/opd_icon.png',
                            text: 'OPD\nBuddy',
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
                    Container(
                      width: 331 * SizeConfig.widthMultiplier!,
                      margin: EdgeInsets.only(
                        left: 14 * SizeConfig.widthMultiplier!,
                        right: 15 * SizeConfig.widthMultiplier!,
                      ),
                      padding: EdgeInsets.only(
                          bottom: 14 * SizeConfig.heightMultiplier!),
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
                          borderRadius: BorderRadius.circular(
                              11 * SizeConfig.widthMultiplier!),
                          color: const Color(0xffFFFFFF)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 21 * SizeConfig.widthMultiplier!,
                                    top: 25 * SizeConfig.heightMultiplier!),
                                child: Image.asset(
                                  'images/opd_booking_icon.png',
                                  width: 49 * SizeConfig.widthMultiplier!,
                                  height: 49 * SizeConfig.heightMultiplier!,
                                ),
                              ),
                              Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 12 * SizeConfig.widthMultiplier!,
                                        top: 23 * SizeConfig.heightMultiplier!),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'OPD Buddy Booking',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 20 *
                                                  SizeConfig.textMultiplier!,
                                              color: Color(0xff2066DA)),
                                        ),
                                        Text(
                                          'Lucknow 28-07-2022',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16 *
                                                  SizeConfig.textMultiplier!,
                                              color: Color(0xff2066DA)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 27 * SizeConfig.heightMultiplier!,
                          ),
                          Divider(
                            color: Color(0xff2066DA).withOpacity(0.2),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 18.0 * SizeConfig.widthMultiplier!),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Book Date',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              10 * SizeConfig.textMultiplier!,
                                          color: Color(0xff2066DA)),
                                    ),
                                    Text(
                                      '28-07-2022',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              9 * SizeConfig.textMultiplier!,
                                          color: Color(0xff2066DA)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 40 * SizeConfig.widthMultiplier!,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Schedule Date ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              10 * SizeConfig.textMultiplier!,
                                          color: Color(0xff2066DA)),
                                    ),
                                    Text(
                                      '28-07-2022',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              9 * SizeConfig.textMultiplier!,
                                          color: Color(0xff2066DA)),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 40 * SizeConfig.widthMultiplier!,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Time',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize:
                                              10 * SizeConfig.textMultiplier!,
                                          color: Color(0xff2066DA)),
                                    ),
                                    Text(
                                      '28-07-2022',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize:
                                              9 * SizeConfig.textMultiplier!,
                                          color: Color(0xff2066DA)),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right:
                                          15.0 * SizeConfig.widthMultiplier!),
                                  child: Column(
                                    children: [
                                      SvgPicture.asset('images/arrow.svg')
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 11 * SizeConfig.heightMultiplier!,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 22.0 * SizeConfig.widthMultiplier!),
                        child: _serviceScroller(
                          imagePath: 'images/doctor_icon.png',
                          text: 'CSC',
                        ),
                      ),
                      SizedBox(
                        width: 6 * SizeConfig.widthMultiplier!,
                      ),
                      _serviceScroller(
                        imagePath: 'images/camputer_repair.png',
                        text: 'CSC',
                      ),
                      SizedBox(
                        width: 6 * SizeConfig.widthMultiplier!,
                      ),
                      _serviceScroller(
                        imagePath: 'images/csc_logo.png',
                        text: 'CSC',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15 * SizeConfig.heightMultiplier!,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding:  EdgeInsets.only(left: 24 * SizeConfig.widthMultiplier!),
                    child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _offerTab(
                          imagePath: 'images/girl_icon.png',
                          text: '60 % OFF',
                          textColor: Color(0xffFFFFFF),
                        ),
                        SizedBox(
                          width: 10 * SizeConfig.widthMultiplier!,
                        ),
                        _offerTab(
                          imagePath: 'images/special_offer_icon.png',
                          text: '60 % OFF',
                          textColor: Color(0xff0398FF),
                        ),
                      ],
                    ),
                  ),
                )
                
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

// Future  onTap;

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

class _serviceScroller extends StatelessWidget {
  _serviceScroller({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  final String imagePath;
  String text;

// Future  onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 146 * SizeConfig.widthMultiplier!,
      height: 167 * SizeConfig.heightMultiplier!,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(5 * SizeConfig.widthMultiplier!),
      ),
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
                    width: 98 * SizeConfig.widthMultiplier!,
                    height: 98 * SizeConfig.heightMultiplier!,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15 * SizeConfig.heightMultiplier!,
          ),
          Container(
            margin: EdgeInsets.only(
                left: 5 * SizeConfig.widthMultiplier!,
                top: 10 * SizeConfig.heightMultiplier!),
            width: 84 * SizeConfig.widthMultiplier!,
            height: 20 * SizeConfig.heightMultiplier!,
            decoration: BoxDecoration(
              color: const Color(0xff0398FF),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(
                    0,
                    5,
                  ),
                  color: const Color(0xff0398FF).withOpacity(0.25),
                  blurRadius: 6,
                ),
              ],
              borderRadius:
                  BorderRadius.circular(24 * SizeConfig.widthMultiplier!),
            ),
            child: Center(
              child: Text(
                'Book Now',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color(0xffFFFFFF),
                  fontSize: 10 * SizeConfig.textMultiplier!,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _offerTab extends StatelessWidget {
  _offerTab({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.textColor,
  }) : super(key: key);

  String imagePath;

  String text;
  Color textColor;

// Future  onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10 * SizeConfig.widthMultiplier!),
   
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            // stops: [0.0,0.2],
            colors: [Color(0xff7AD7F0), Color(0xffDBF3FA).withOpacity(0.9)],
            tileMode: TileMode.clamp),
        borderRadius: BorderRadius.circular(5 * SizeConfig.widthMultiplier!),
      ),
      child: Row(
        children: [
          Container(

            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 5.0 * SizeConfig.widthMultiplier!,
                    top: 11 * SizeConfig.heightMultiplier!,
                  ),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Up to',
                            style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 8 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            text,
                            style: TextStyle(
                                color: textColor,
                                fontSize: 18 * SizeConfig.textMultiplier!,
                                fontWeight: FontWeight.w700),
                          ),
                          Container(
                            width: 25,
                            child: Divider(
                              thickness: 2,
                              color: Color(0xffFFFFFF),
                            ),
                          ),


                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'OPD Buddy',
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize:
                                            11 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'September',
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize:
                                            10 * SizeConfig.textMultiplier!,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 10 * SizeConfig.widthMultiplier!,
                              ),
                              SvgPicture.asset(
                                'images/green_arrow.svg',
                                width: 15 * SizeConfig.widthMultiplier!,
                                height: 15 * SizeConfig.heightMultiplier!,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 8 * SizeConfig.widthMultiplier!,),
          Transform.scale(
            scale: 1.3,
            child: Image.asset(imagePath,
            width: 50,

            ),
          )

        ],
      ),
    );
  }
}
