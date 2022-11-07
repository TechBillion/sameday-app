import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../global_variables.dart';
import '../screens/login_screens/loginscreen.dart';
import '../size_config.dart';

class SameDayAppBar extends StatefulWidget with PreferredSizeWidget {
  bool? wantBackButton;
  bool? wantOtherIcons;
  BuildContext parentContext;
  SameDayAppBar(
      {Key? key,
        required this.parentContext,
        this.wantBackButton,
        this.wantOtherIcons})
      : super(key: key);

  @override
  _SameDayAppBarState createState() => _SameDayAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(ScreenHeight * 0.07);
}

class _SameDayAppBarState extends State<SameDayAppBar> {
  // final logInStatus _loginHandler = logInStatus();
  // cashaaAppBar({Key? key}) : super(key: key);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        widget.wantBackButton != null
            ? Container()
            : Padding(
          padding: EdgeInsets.only(
              top: ScreenHeight * 0.045, left: ScreenWidth * 0.09866),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              width: ScreenWidth * 0.1146,
              height: ScreenWidth * 0.1146,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:Color(0xffE8ECF4)

                  ),
                    borderRadius:
                    BorderRadius.circular(12 * SizeConfig.widthMultiplier!),

                    boxShadow: [
                  BoxShadow(
                      color: const Color(0xff0398FF).withOpacity(0.2),
                      spreadRadius: -ScreenWidth * 0.01,
                      blurRadius: 10 * SizeConfig.widthMultiplier!,
                      offset: Offset(0, ScreenHeight * 0.0098522))
                ]),
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0.0),
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    shadowColor: MaterialStateProperty.all(
                        blueThemeColor.withOpacity(0.3)),
                    shape:
                    MaterialStateProperty.all(RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius.circular(12 * SizeConfig.widthMultiplier!),
                    )),
                    backgroundColor:
                    MaterialStateProperty.all(Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(widget.parentContext).pop();
                  },
                  child: Center(
                      child: Icon(
                        CupertinoIcons.left_chevron,
                        size: ScreenWidth * 0.04,
                        color: const Color(0xff0398FF),
                      )),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
                right: ScreenWidth * 0.02,
                top: ScreenHeight * 0.04,
                bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.scale(
                  child: Image.asset(
                    'images/sameday_text.png',
                    width: ScreenWidth * 0.5,
                    height: ScreenHeight * 0.03,
                  ),
                  scale: 1.3,

                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            //Bell icon
            widget.wantOtherIcons != null
                ? Container(
              width: 40 * SizeConfig.imageSizeMultiplier!,
            )
                : Padding(
              padding: EdgeInsets.only(
                  right: ScreenWidth * .0373,
                  bottom: 10.0),
              child: GestureDetector(
                  child: Container(
                    height: ScreenWidth * 0.04,
                    width: ScreenWidth * 0.04,
                  )),
            ),

            //Account icon
            widget.wantOtherIcons != null
                ? Container(
              width: 40 * SizeConfig.imageSizeMultiplier!,
            )
                : Padding(
              padding: EdgeInsets.only(
                  right: ScreenWidth * 0.103,

                  bottom: 10.0 * SizeConfig.heightMultiplier!),
              child: GestureDetector(
                  child: Theme(
                    data: ThemeData(
                        shadowColor: blueThemeColor,
                        hoverColor: Color(0xff233EC2)),
                    child: PopupMenuTheme(
                      data: const PopupMenuThemeData(elevation: 20.0),
                      child: PopupMenuButton<int>(

                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xffEEEEEE)),
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(
                                      10 * SizeConfig.widthMultiplier!),
                                  bottomLeft: Radius.circular(
                                      10 * SizeConfig.widthMultiplier!),
                                  bottomRight: Radius.circular(
                                      10 * SizeConfig.widthMultiplier!))),
                          offset: Offset(0, ScreenHeight * 0.05),
                          itemBuilder: (BuildContext context) {
                            return [
                              PopupMenuItem<int>(
                                  onTap: () {

                                    // Future.delayed(Duration(milliseconds: 40),
                                    //         () {
                                    //       Get.to(
                                    //               () => plansForIndividualCurrency());
                                    //     });
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "images/menu_icons/loyalty_level_icon_.svg",
                                        width:
                                        28 * SizeConfig.widthMultiplier!,
                                        height:
                                        28 * SizeConfig.heightMultiplier!,
                                      ),
                                      SizedBox(
                                        width: ScreenWidth * 0.02,
                                      ),
                                      Text("Services",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16 *
                                                  SizeConfig.textMultiplier!,
                                              color: Color(0xff3E4B5B)))
                                    ],
                                  )),
                              PopupMenuDivider(
                                height: 0,
                              ),
                              PopupMenuItem<int>(
                                  onTap: () {
                                    // Future.delayed(Duration(milliseconds: 50),(){
                                    //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>ActivityScreen()), (route) => false).then((value){
                                    //
                                    //   });
                                    //   selectedPageIndex.value = 3;
                                    //   pageController!.jumpToPage(3);
                                    //
                                    // });
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "images/menu_icons/setting_icon.svg",
                                        width:
                                        26 * SizeConfig.widthMultiplier!,
                                        height:
                                        26 * SizeConfig.heightMultiplier!,
                                      ),
                                      SizedBox(
                                        width:
                                        9 * SizeConfig.widthMultiplier!,
                                      ),
                                      Text("Settings",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16 *
                                                  SizeConfig.textMultiplier!,
                                              color: Color(0xff3E4B5B)))
                                    ],
                                  )),
                              PopupMenuDivider(
                                height: 0,
                              ),
                              PopupMenuItem<int>(
                                  onTap: () {
                                    // Future.delayed(Duration(milliseconds: 40),
                                    //         () {
                                    //       activityBloc _activityBloc =
                                    //       activityBloc();
                                    //       _showHelpDesk(context, _activityBloc);
                                    //     });
                                  },
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        "images/menu_icons/helpdesk_icon.svg",
                                        width:
                                        26 * SizeConfig.widthMultiplier!,
                                        height:
                                        26 * SizeConfig.heightMultiplier!,
                                      ),
                                      SizedBox(
                                        width: 10.66 *
                                            SizeConfig.widthMultiplier!,
                                      ),
                                      Text("Help Desk",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16 *
                                                  SizeConfig.textMultiplier!,
                                              color: Color(0xff3E4B5B)))
                                    ],
                                  )),
                              PopupMenuDivider(
                                height: 0,
                              ),
                              PopupMenuItem<int>(
                                  onTap: () {
                                    FirebaseAuth.instance.signOut().then((value) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => LogInScreen(),
                                          ));


                                    });

                                    // //log out user and delete its data
                                    // _loginHandler.logOutUser();
                                    // Future.delayed(
                                    //     const Duration(microseconds: 50), () {
                                    //   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const LogInScreen()), (route) => false);
                                    //   // Get.offAll(() => const LogInScreen());
                                    //   selectedPageIndex.value = 0;
                                    //   pageController!.jumpToPage(0);
                                    // });
                                  },
                                  child: Container(
                                    width: 150 * SizeConfig.widthMultiplier!,
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "images/menu_icons/logout_icon.svg",
                                          width: 26 *
                                              SizeConfig.widthMultiplier!,
                                          height: 26 *
                                              SizeConfig.heightMultiplier!,
                                          color: Color(0xff3570F4),
                                        ),
                                        SizedBox(
                                          width: ScreenWidth * 0.03,
                                        ),
                                        Text("Log Out",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16 *
                                                    SizeConfig
                                                        .textMultiplier!,
                                                color: Color(0xff3E4B5B)))
                                      ],
                                    ),
                                  )),
                            ];
                          },
                          child: SvgPicture.asset(
                            'images/popup_icon.svg',
                            height: 31 * SizeConfig.heightMultiplier!,
                            width: 31 * SizeConfig.widthMultiplier!,

                          )),
                    ),
                  )),
            )
          ],
        ),
      ],
    );
  }

  // @override
   Size get preferredSize => Size.fromHeight(kToolbarHeight);

  //show helpDesk alert dialog
  // _showHelpDesk(BuildContext context, activityBloc _activityBloc) {
  //   TextEditingController _subjectController = TextEditingController();
  //   TextEditingController _messageController = TextEditingController();
  //   String? categoryId;
  //   final _validatorSubject = GlobalKey<FormState>();
  //   final _validatorMessage = GlobalKey<FormState>();
  //   final _categoryValidator = GlobalKey<FormState>();
  //   _activityBloc.setHelpDeskCategoryModel();
  //
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return StatefulBuilder(builder: (BuildContext context, setState) {
  //           return AlertDialog(
  //             title: Text("Create new ticket",
  //               style: TextStyle(
  //                   fontSize:
  //                   23* SizeConfig.textMultiplier!,
  //                   color: darkBlueTextColor,
  //                   fontWeight:FontWeight.w700
  //
  //               ),
  //             ),
  //
  //
  //             elevation: 5.0,
  //             insetPadding: EdgeInsets.zero,
  //             content: SizedBox(
  //               width: ScreenWidth * 0.7,
  //               child: ListView(
  //                 shrinkWrap: true,
  //                 physics: const BouncingScrollPhysics(),
  //                 children: [
  //                   StreamBuilder(
  //                     stream: _activityBloc.getHelpDeskModel,
  //                     builder: (BuildContext context,
  //                         AsyncSnapshot<List<HelpDeskCategoryModel>> snapshot) {
  //                       if (snapshot.hasData) {
  //                         return Form(
  //                           key: _categoryValidator,
  //                           child: DropdownButtonFormField(
  //                             style: TextStyle(
  //                                 fontSize: 13 * SizeConfig.textMultiplier!,
  //                                 color: darkBlueTextColor
  //
  //                             ),
  //                             validator: (value) {
  //                               if (value == null) {
  //                                 return "Please select an option";
  //                               } else {
  //                                 null;
  //                                 return null;
  //                               }
  //                             },
  //                             icon: const Icon(
  //                                 Icons.keyboard_arrow_down_outlined),
  //                             hint: Text("Category",style:TextStyle(
  //                                 fontSize: 13 * SizeConfig.textMultiplier!,
  //                                 color: Color(0xffADADAD).withOpacity(0.8)
  //
  //                             )),
  //
  //                             decoration: InputDecoration(
  //                               hintStyle: TextStyle(
  //                                   fontSize: 13 * SizeConfig.textMultiplier!,
  //                                   color: Color(0xffADADAD).withOpacity(0.8)
  //
  //                               ),
  //                               focusedErrorBorder: OutlineInputBorder(
  //                                 borderSide: BorderSide(
  //                                     color: Colors.red.withOpacity(0.5),
  //                                     width: 1.2),
  //                                 borderRadius: BorderRadius.circular(5),
  //                               ),
  //                               errorBorder: OutlineInputBorder(
  //                                 borderSide: BorderSide(
  //                                     color: Colors.red.withOpacity(0.5),
  //                                     width: 1.2),
  //                               ),
  //                               contentPadding: EdgeInsets.only(
  //                                   left: ScreenWidth * 0.05,
  //                                   right: ScreenWidth * 0.02),
  //                               focusedBorder: const OutlineInputBorder(
  //                                 borderSide: BorderSide(
  //                                     color: Color(0x33adadad), width: 1.2),
  //                               ),
  //                               enabledBorder:  const OutlineInputBorder(
  //                                 borderSide: BorderSide(
  //                                     color: Color(0x33adadad), width: 1.2),
  //                               ),
  //                             ),
  //                             onChanged: (value) {
  //                               for (int i = 0;
  //                               i < snapshot.data!.length;
  //                               i++) {
  //                                 if (snapshot.data![i].categoryName == value) {
  //                                   categoryId = snapshot.data![i].id!;
  //                                 }
  //                               }
  //                               _categoryValidator.currentState!.validate();
  //                               setState(() {});
  //                             },
  //                             items: snapshot.data!
  //                                 .map((e) => DropdownMenuItem(
  //                               child: Text(e.categoryName.toString()),
  //                               value: e.categoryName,
  //                             ))
  //                                 .toList(),
  //                           ),
  //                         );
  //                       } else {
  //                         return DropdownButtonFormField<Text>(
  //                           icon:
  //                           const Icon(Icons.keyboard_arrow_down_outlined),
  //                           hint: Text("Loading..",style: TextStyle(
  //                             fontSize: 13 * SizeConfig.textMultiplier!,
  //                             color:darkBlueTextColor,
  //                           ),),
  //                           decoration: InputDecoration(
  //                             hintStyle: TextStyle(
  //                               fontSize: 13 * SizeConfig.textMultiplier!,
  //                               color: Color(0xffADADAD).withOpacity(0.8),
  //
  //                             ),
  //                             contentPadding: EdgeInsets.only(
  //                                 left: ScreenWidth * 0.05,
  //                                 right: ScreenWidth * 0.02),
  //                             focusedBorder: const OutlineInputBorder(
  //                               borderSide:  BorderSide(
  //                                   color: Color(0x33adadad), width: 1.2),
  //                             ),
  //                             enabledBorder: const OutlineInputBorder(
  //                               borderSide:  BorderSide(
  //                                   color: Color(0x33adadad), width: 1.2),
  //                             ),
  //                           ),
  //                           items:  [
  //                             DropdownMenuItem(child: Text("Loading",style: TextStyle(
  //                               fontSize: 13 * SizeConfig.textMultiplier!,
  //                               color:const Color(0xffADADAD).withOpacity(0.8),
  //                             ),))
  //                           ],
  //                           onChanged: (value) {},
  //                         );
  //                       }
  //                     },
  //                   ),
  //                   SizedBox(
  //                     height: ScreenHeight * 0.02,
  //                   ),
  //                   Form(
  //                     key: _validatorSubject,
  //                     child: TextFormField(
  //                       validator: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return 'Please fill out this field';
  //                         }
  //                         return null;
  //                       },
  //                       onChanged: (value) {
  //                         setState(() {
  //                           _validatorSubject.currentState!.validate();
  //                         });
  //                       },
  //                       style: TextStyle(
  //                           fontSize: 13 * SizeConfig.textMultiplier!,
  //                           fontWeight:FontWeight.w500,
  //                           color: darkBlueTextColor
  //                       ),
  //                       controller: _subjectController,
  //                       decoration: InputDecoration(
  //                         hintStyle: TextStyle(
  //                             fontSize: 13 * SizeConfig.textMultiplier!,
  //                             fontWeight:FontWeight.w500,
  //                             color: Color(0xffADADAD).withOpacity(0.8)
  //                         ),
  //                         hintText: "Subject",
  //                         focusedErrorBorder:  OutlineInputBorder(
  //
  //                           borderSide:
  //                           BorderSide(color: Colors.red, width: 1.2),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                         errorBorder: const OutlineInputBorder(
  //                           borderSide:
  //                           BorderSide(color: Colors.red, width: 1.2),
  //                         ),
  //                         contentPadding: EdgeInsets.only(
  //                             left: ScreenWidth * 0.05,
  //                             right: ScreenWidth * 0.02),
  //                         focusedBorder: const OutlineInputBorder(
  //                           borderSide:  BorderSide(
  //                               color: Color(0x33adadad), width: 1.2),
  //                         ),
  //                         enabledBorder: const OutlineInputBorder(
  //                           borderSide:  BorderSide(
  //                               color: Color(0x33adadad), width: 1.2),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: ScreenHeight * 0.02,
  //                   ),
  //                   Form(
  //                     key: _validatorMessage,
  //                     child: TextFormField(
  //                       validator: (value) {
  //                         if (value == null || value.isEmpty) {
  //                           return 'Please fill out this field';
  //                         }
  //                         return null;
  //                       },
  //                       onChanged: (value) {
  //                         setState(() {
  //                           _validatorMessage.currentState!.validate();
  //                         });
  //                       },
  //                       style: TextStyle(
  //                           fontSize: 13 * SizeConfig.textMultiplier!,
  //                           fontWeight:FontWeight.w500,
  //                           color: darkBlueTextColor
  //                       ),
  //                       keyboardType: TextInputType.multiline,
  //                       maxLines: null,
  //                       minLines: 6,
  //                       controller: _messageController,
  //                       decoration: InputDecoration(
  //                         hintStyle: TextStyle(
  //                             fontSize: 13 * SizeConfig.textMultiplier!,
  //                             fontWeight:FontWeight.w500,
  //                             color: Color(0xffADADAD).withOpacity(0.8)
  //                         ),
  //                         hintText: "Message",
  //                         contentPadding: EdgeInsets.only(
  //                             top: 20 * SizeConfig.heightMultiplier!,
  //                             left: ScreenWidth * 0.05,
  //                             right: ScreenWidth * 0.02),
  //                         focusedErrorBorder:  OutlineInputBorder(
  //                           borderSide:
  //                           BorderSide(color: Colors.red, width: 1.2),
  //                           borderRadius: BorderRadius.circular(5),
  //                         ),
  //                         errorBorder: const OutlineInputBorder(
  //                           borderSide:
  //                           BorderSide(color: Colors.red, width: 1.2),
  //                         ),
  //                         focusedBorder: const OutlineInputBorder(
  //                           borderSide:  BorderSide(
  //                               color: Color(0x33adadad), width: 1.2),
  //                         ),
  //                         enabledBorder: const OutlineInputBorder(
  //                           borderSide:  BorderSide(
  //                               color: Color(0x33adadad), width: 1.2),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //                   SizedBox(
  //                     height: ScreenHeight * 0.02,
  //                   ),
  //                   Center(
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                       children: [
  //                         SizedBox(
  //
  //                           height: 45* SizeConfig.heightMultiplier!,
  //                           width: 118 * SizeConfig.widthMultiplier!,
  //                           child: RawMaterialButton(
  //
  //                             child: const Text(
  //                               'Submit',
  //                               style: TextStyle(color: Colors.white),
  //                             ),
  //                             shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(2),
  //                                 side: BorderSide(
  //                                     color: blueThemeColor, width: 1)),
  //                             //if any text field is empty button disable
  //                             fillColor: blueThemeColor,
  //                             elevation: 0,
  //                             highlightElevation: 0,
  //                             splashColor: Colors.black12,
  //                             highlightColor: blueThemeColor,
  //                             onPressed: () {
  //                               //validating fields
  //                               _categoryValidator.currentState!.validate();
  //                               _validatorMessage.currentState!.validate();
  //                               _validatorSubject.currentState!.validate();
  //                               //if no field is empty then create ticket
  //                               if (_categoryValidator.currentState!.validate() &&
  //                                   _validatorMessage.currentState!.validate() &&
  //                                   _validatorSubject.currentState!.validate()) {
  //                                 //creating helpdesk ticket
  //                                 _activityBloc.createHelpDeskTicket(
  //                                     CategoryId: categoryId!,
  //                                     Subject: _subjectController.text,
  //                                     Message: _messageController.text);
  //                                 Navigator.pop(context);
  //                               }
  //                             },
  //                           ),
  //                         ),
  //                         SizedBox(
  //                           width: ScreenWidth * 0.05,
  //                         ),
  //                         SizedBox(
  //                           height: 45* SizeConfig.heightMultiplier!,
  //                           width: 118 * SizeConfig.widthMultiplier!,
  //                           child: RawMaterialButton(
  //                             child: Padding(
  //                               padding: EdgeInsets.only(
  //                                   left: ScreenWidth * 0.05,
  //                                   right: ScreenWidth * 0.05),
  //                               child:  Text(
  //                                 'Cancel',
  //                                 style: TextStyle(color:blueThemeColor,
  //                                 ),
  //                               ),
  //                             ),
  //                             shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(2),
  //                                 side:  BorderSide(
  //                                     color: blueThemeColor, width: 1)),
  //                             fillColor: Colors.transparent,
  //                             elevation: 0,
  //                             highlightElevation: 0,
  //                             splashColor: Colors.black12,
  //                             highlightColor: blueThemeColor.withOpacity(0.2),
  //                             onPressed: () {
  //                               Navigator.pop(context);
  //                             },
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           );
  //         });
  //       });
  // }
}

openSettingsDirectly({bool? show2fa,bool? showFeeOption}){
  // Future.delayed(Duration(milliseconds: 50),(){
  //   Navigator.push(Get.context!, MaterialPageRoute(builder: (context)=>UserSettingScreen(wantBackButton: true,show2FA: show2fa??false,showFeeOption: showFeeOption??false,)),).then((value){
  //
  //   });
  //
  //
  // });
}
