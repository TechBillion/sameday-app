import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sameday/global_variables.dart';
import 'package:sameday/size_config.dart';

import '../../widgets/sameday_appbar.dart';

class OpdBookingScreen extends StatefulWidget {
  const OpdBookingScreen({Key? key}) : super(key: key);

  @override
  _OpdBookingScreenState createState() => _OpdBookingScreenState();
}

class _OpdBookingScreenState extends State<OpdBookingScreen> {
  TimeOfDay time = const TimeOfDay(hour: 10, minute: 30);

  @override
  void iniState() {}

  @override
  void dispose() {
    name.dispose();
    age.dispose();
    gender.dispose();
    docName.dispose();
    contactNumber.dispose();
    address.dispose();
    appointmentbooked.dispose();
    date.dispose();
    datetime.dispose();
    buddyRequired.dispose();
    carRequired.dispose();
    bikeRequired.dispose();
    super.dispose();
  }

  int currentStep = 0;
  bool isCompleted = false;
  final name = TextEditingController();
  final age = TextEditingController();
  final gender = TextEditingController();
  final docName = TextEditingController();
  final contactNumber = TextEditingController();
  final address = TextEditingController();
  final appointmentbooked = TextEditingController();
  final date = TextEditingController();
  final datetime = TextEditingController();
  final buddyRequired = TextEditingController();
  final carRequired = TextEditingController();
  final bikeRequired = TextEditingController();
  final ScrollController _verticalListController = ScrollController();
  int counter = 1;
  String genderText = "Gender";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: SameDayAppBar(
          parentContext: context,
        ),
        body: SingleChildScrollView(
            controller: _verticalListController,
            physics: const BouncingScrollPhysics(),
            child: Column(
          children: [
            isCompleted
                ? _serviceContainer()
                : SizedBox(
              height: 700 * SizeConfig.heightMultiplier!,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stepper(
                        physics: const PageScrollPhysics(),
                        elevation: 0,
                        type: StepperType.horizontal,
                        steps: getSteps(),
                        currentStep: currentStep,
                        onStepContinue: () {
                          final isLastStep = currentStep == getSteps().length - 1;
                          if (isLastStep) {
                            setState(() => isCompleted = true);
                            print('Completed');
                          } else {
                            setState(() => currentStep += 1);
                          }
                        },
                        onStepCancel: currentStep == 0
                            ? null
                            : () => setState(() => currentStep -= 1),
                        controlsBuilder:
                            (BuildContext context, ControlsDetails controls) {
                          final isLastStep = currentStep == getSteps().length - 1;
                          return Container(
                            child: Row(
                              children: [
                                if (currentStep != 0)
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              7 * SizeConfig.widthMultiplier!),
                                          border: Border.all(
                                              color: const Color(0xff2BD67B))),
                                      height: 53 * SizeConfig.heightMultiplier!,
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.transparent,
                                              elevation: 0.0,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(7 *
                                                          SizeConfig
                                                              .widthMultiplier!)),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 16 *
                                                      SizeConfig
                                                          .heightMultiplier!),
                                              textStyle: TextStyle(
                                                  fontSize: 15 *
                                                      SizeConfig.textMultiplier!,
                                                  fontWeight: FontWeight.bold)),
                                          onPressed: controls.onStepCancel,
                                          child: const Text(
                                            "Cancel",
                                            style: TextStyle(
                                                color: Color(0xff3E4B5B)),
                                          )),
                                    ),
                                  ),
                                SizedBox(
                                  width: 10 * SizeConfig.widthMultiplier!,
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          7 * SizeConfig.widthMultiplier!),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0xffE97A0A)
                                                .withOpacity(0.3),
                                            offset: const Offset(0, 10),
                                            blurRadius:
                                                35 * SizeConfig.widthMultiplier!,
                                            spreadRadius: 0)
                                      ],
                                      gradient: const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: [0.0, 1.0],
                                        colors: [
                                          Color(0xffE97A0A),
                                          Color(0xffE97A0A),
                                        ],
                                      ),
                                    ),
                                    height: 53 * SizeConfig.heightMultiplier!,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(7 *
                                                        SizeConfig
                                                            .widthMultiplier!)),
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 16 *
                                                    SizeConfig.heightMultiplier!),
                                            textStyle: TextStyle(
                                                fontSize: 15 *
                                                    SizeConfig.textMultiplier!,
                                                fontWeight: FontWeight.bold)),
                                        onPressed: controls.onStepContinue,
                                        child:
                                            Text(isLastStep ? "Pay" : "Proceed")),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ),
                ),
          ],
        )));
  }

  List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            title: const Text('Details'),
            content: Column(
              children: [
                //first name field
                Container(
                  width: 298 * SizeConfig.widthMultiplier!,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    ],
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this field is mandetory";
                      } else {
                        return null;
                      }
                    },
                    controller: name,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: SizeConfig.textMultiplier! * 11),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 10,
                          height: 1.2,
                          color: Colors.red.withOpacity(0.9)),
                      prefixIcon: SizedBox(
                        width: ScreenWidth * 0.05,
                        child: Center(
                            child: SvgPicture.asset(
                          "images/user_icon.svg",
                          width: ScreenWidth * 0.04,
                        )),
                      ),
                      hintText: "First Name",
                      hintStyle: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 11,
                          color: const Color(0xffADADAD)),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: greenThemeColor.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15 * SizeConfig.heightMultiplier!,
                ),


                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //age field
                    Container(
                      width: 105 * SizeConfig.widthMultiplier!,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "this field is mandetory";
                          } else {
                            return null;
                          }
                        },
                        controller: age,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: SizeConfig.textMultiplier! * 11),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: SizeConfig.textMultiplier! * 10,
                              height: 1.2,
                              color: Colors.red.withOpacity(0.9)),
                          prefixIcon: SizedBox(
                            width: ScreenWidth * 0.05,
                            child: Transform.scale(
                              scale: 0.6,
                              child: SvgPicture.asset(
                                "images/age_icon.svg",
                              ),
                            ),
                          ),
                          hintText: "Age",
                          hintStyle: TextStyle(
                              fontSize: SizeConfig.textMultiplier! * 11,
                              color: const Color(0xffADADAD)),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x33adadad), width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: greenThemeColor.withOpacity(0.2),
                                width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x33adadad), width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x33adadad), width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 17 * SizeConfig.widthMultiplier!,
                    ),
                    //gender field
                    Container(
                      width: 174 * SizeConfig.widthMultiplier!,
                      child: Theme(
                        data: ThemeData(
                            textTheme: TextTheme(
                                subtitle1: TextStyle(
                                    color: const Color(0xff585858),
                                    fontSize:
                                        SizeConfig.textMultiplier! * 11.0))),
                        child:DropdownSearch<String>(
                          selectedItem:
                          gender.text.isEmpty || gender.text == null
                              ? gender.text
                              : null,
                          popupProps: PopupProps.bottomSheet(
                              bottomSheetProps: const BottomSheetProps(
                                backgroundColor: Color(0xffFFFFFF),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.0),
                                        topRight: Radius.circular(10.0))),
                              ),
                              textStyle: TextStyle(
                                  fontSize: SizeConfig.textMultiplier! * 11.0,
                                  color: const Color(0xff9A9A9A)),
                              constraints: BoxConstraints(
                                  maxHeight:
                                  300 * SizeConfig.heightMultiplier!),
                              showSearchBox: true,
                              searchFieldProps: TextFieldProps(
                                  style: TextStyle(
                                      fontSize:
                                      SizeConfig.textMultiplier! * 11.0,
                                      color: const Color(0xff9A9A9A)),
                                  controller: gender,
                                  decoration: InputDecoration(
                                    hintText: "Gender",
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xff56646C)
                                              .withOpacity(0.2),
                                          width: 0.75),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenWidth * 0.0133333)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: const Color(0xff56646C)
                                              .withOpacity(0.2),
                                          width: 0.75),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenWidth * 0.0133333)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                          greenThemeColor.withOpacity(0.3),
                                          width: 1.7),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              ScreenWidth * 0.0133333)),
                                    ),
                                    hintStyle: TextStyle(
                                        fontSize:
                                        SizeConfig.textMultiplier! * 11.0,
                                        color: const Color(0xff9A9A9A)),
                                    suffixIcon: Icon(
                                      CupertinoIcons.search,
                                      color: greenThemeColor,
                                      size: ScreenWidth * 0.05,
                                    ),
                                  ))),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              baseStyle: TextStyle(
                                  fontSize: SizeConfig.textMultiplier! * 1.0,
                                  color: const Color(0xff585858)),
                              dropdownSearchDecoration: InputDecoration(
                                counterStyle: TextStyle(
                                    fontSize: SizeConfig.textMultiplier! * 1.0,
                                    color: const Color(0xff585858)),
                                prefixIcon: SizedBox(
                                  width: ScreenWidth * 0.05,
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "images/gender_ icon.svg",

                                    ),
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff56646C)
                                          .withOpacity(0.2),
                                      width: 0.75),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenWidth * 0.0133333)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff56646C)
                                          .withOpacity(0.2),
                                      width: 0.75),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenWidth * 0.0133333)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: greenThemeColor.withOpacity(0.3),
                                      width: 1.7),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenWidth * 0.0133333)),
                                ),
                                hintText: "$genderText",
                                hintStyle: TextStyle(
                                    fontSize: SizeConfig.textMultiplier! * 12.0,
                                    color:  const Color(0xff56646C)),


                              )),
                          // showSelectedItem: true,
                          items: [("Male"), ('Female')],
                          onChanged: (val) {
                            gender.text = val!;
                            // FocusScope.of(context)
                            //     .requestFocus(_usernameFocusNode);
                          },
                          // selectedItem:
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15 * SizeConfig.heightMultiplier!,
                ),
                //doctorname field
                Container(
                  width: 298 * SizeConfig.widthMultiplier!,
                  child: TextFormField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    ],
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this field is mandetory";
                      } else {
                        return null;
                      }
                    },
                    controller: docName,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: SizeConfig.textMultiplier! * 11),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 10,
                          height: 1.2,
                          color: Colors.red.withOpacity(0.9)),
                      prefixIcon: SizedBox(
                        width: ScreenWidth * 0.05,
                        child: Center(
                            child: SvgPicture.asset(
                          "images/docter _icon.svg",
                          width: ScreenWidth * 0.04,
                        )),
                      ),
                      hintText: "Doctor Name and Hospital Name",
                      hintStyle: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 11,
                          color: const Color(0xffADADAD)),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: greenThemeColor.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15 * SizeConfig.heightMultiplier!,
                ),
                //hospital contact field

                Container(
                  width: 298 * SizeConfig.widthMultiplier!,
                  child: TextFormField(
                    keyboardType: const TextInputType.numberWithOptions(
                        signed: false, decimal: true),
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this field is mandetory";
                      } else {
                        return null;
                      }
                    },
                    controller: contactNumber,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: SizeConfig.textMultiplier! * 11),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 10,
                          height: 1.2,
                          color: Colors.red.withOpacity(0.9)),
                      prefixIcon: SizedBox(
                        width: ScreenWidth * 0.05,
                        child: Center(
                            child: SvgPicture.asset(
                          "images/contact_ no.svg",
                          width: ScreenWidth * 0.045,
                        )),
                      ),
                      hintText: "Phone No",
                      hintStyle: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 11,
                          color: const Color(0xffADADAD)),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: greenThemeColor.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 15 * SizeConfig.heightMultiplier!,
                ),
                //hospital address field
                Container(
                  width: 298 * SizeConfig.widthMultiplier!,
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this field is mandetory";
                      } else {
                        return null;
                      }
                    },
                    controller: address,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: SizeConfig.textMultiplier! * 11),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 10,
                          height: 1.2,
                          color: Colors.red.withOpacity(0.9)),
                      prefixIcon: SizedBox(
                        width: ScreenWidth * 0.05,
                        child: Center(
                            child: SvgPicture.asset(
                          "images/address_icon.svg",
                          width: ScreenWidth * 0.04,
                        )),
                      ),
                      hintText: "Hospital Address",
                      hintStyle: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 11,
                          color: const Color(0xffADADAD)),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: greenThemeColor.withOpacity(0.2), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15 * SizeConfig.heightMultiplier!,
                ),
                //appointment booked?
                Container(
                  width: 298 * SizeConfig.widthMultiplier!,
                  child: Theme(
                    data: ThemeData(
                        textTheme: TextTheme(
                            subtitle1: TextStyle(
                                color: const Color(0xff585858),
                                fontSize: SizeConfig.textMultiplier! * 11.0))),
                    child: DropdownSearch<String>(
                      selectedItem: appointmentbooked.text.isEmpty ||
                              appointmentbooked.text == null
                          ? appointmentbooked.text
                          : null,
                      popupProps: PopupProps.bottomSheet(
                          bottomSheetProps: const BottomSheetProps(
                            backgroundColor: Color(0xffFFFFFF),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0))),
                          ),
                          textStyle: TextStyle(
                              fontSize: SizeConfig.textMultiplier! * 11.0,
                              color: const Color(0xff9A9A9A)),
                          constraints: BoxConstraints(
                              maxHeight: 300 * SizeConfig.heightMultiplier!),
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                              style: TextStyle(
                                  fontSize: SizeConfig.textMultiplier! * 11.0,
                                  color: const Color(0xff9A9A9A)),
                              controller: appointmentbooked,
                              decoration: InputDecoration(
                                hintText: "Select YES or NO",
                                isDense: true,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff56646C)
                                          .withOpacity(0.2),
                                      width: 0.75),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenWidth * 0.0133333)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: const Color(0xff56646C)
                                          .withOpacity(0.2),
                                      width: 0.75),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenWidth * 0.0133333)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: greenThemeColor.withOpacity(0.3),
                                      width: 1.7),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(ScreenWidth * 0.0133333)),
                                ),
                                hintStyle: TextStyle(
                                    fontSize: SizeConfig.textMultiplier! * 11.0,
                                    color: const Color(0xff9A9A9A)),
                                suffixIcon: Icon(
                                  CupertinoIcons.search,
                                  color: greenThemeColor,
                                  size: ScreenWidth * 0.05,
                                ),
                              ))),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                          baseStyle: TextStyle(
                              fontSize: SizeConfig.textMultiplier! * 1.0,
                              color: const Color(0xff585858)),
                          dropdownSearchDecoration: InputDecoration(
                            counterStyle: TextStyle(
                                fontSize: SizeConfig.textMultiplier! * 1.0,
                                color: const Color(0xff585858)),
                            prefixIcon: SizedBox(
                              width: ScreenWidth * 0.05,
                              child: Center(
                                child: SvgPicture.asset(
                                  "images/appointment_icon.svg",
                                  width: ScreenWidth * 0.037,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color(0xff56646C).withOpacity(0.2),
                                  width: 0.75),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenWidth * 0.0133333)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      const Color(0xff56646C).withOpacity(0.2),
                                  width: 0.75),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenWidth * 0.0133333)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: greenThemeColor.withOpacity(0.3),
                                  width: 1.7),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenWidth * 0.0133333)),
                            ),
                            hintText: "AppointMent Booked?",
                            hintStyle: TextStyle(
                                height: 1,
                                fontSize: SizeConfig.textMultiplier! * 12.0,
                                color: const Color(0xff56646C)),
                          )),
                      // showSelectedItem: true,
                      items: [("Yes"), ('No')],
                      onChanged: (val) {
                        appointmentbooked.text = val!;
                        // FocusScope.of(context)
                        //     .requestFocus(_usernameFocusNode);
                      },
                      // selectedItem:
                    ),
                  ),
                ),

                SizedBox(
                  height: 15 * SizeConfig.heightMultiplier!,
                ),




                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 120 * SizeConfig.widthMultiplier!,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "this field is mandetory";
                          } else {
                            return null;
                          }
                        },
                        controller: date,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: SizeConfig.textMultiplier! * 11),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: SizeConfig.textMultiplier! * 10,
                              height: 1.2,
                              color: Colors.red.withOpacity(0.9)),
                          suffixIcon: SizedBox(
                            width: ScreenWidth * 0.05,
                            child: Center(
                                child: InkWell(
                              onTap: () async {
                                final DateTime? picked = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  lastDate: DateTime.now(),
                                  firstDate: DateTime(1930),
                                );
                                if (picked != null) {
                                  setState(() {
                                    date.text = picked.day.toString() +
                                        "-" +
                                        picked.month.toString() +
                                        "-" +
                                        picked.year.toString();
                                  });
                                }
                              },
                              child: SvgPicture.asset(
                                "images/appointment_icon.svg",
                                width: ScreenWidth * 0.04,
                              ),
                            )),
                          ),
                          contentPadding: EdgeInsets.only(
                              top: ScreenHeight * 0.00,
                              bottom: ScreenHeight * 0.00),
                          hintText: "Select Date",
                          hintStyle: TextStyle(
                              fontSize: SizeConfig.textMultiplier! * 11,
                              color: const Color(0xffADADAD)),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x33adadad), width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: greenThemeColor.withOpacity(0.2),
                                width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x33adadad), width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x33adadad), width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 17 * SizeConfig.widthMultiplier!,
                    ),
                    Container(
                      width: 160 * SizeConfig.widthMultiplier!,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "this field is mandetory";
                          } else {
                            return null;
                          }
                        },
                        controller: datetime,
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: SizeConfig.textMultiplier! * 11),
                        decoration: InputDecoration(
                          errorStyle: TextStyle(
                              fontSize: SizeConfig.textMultiplier! * 10,
                              height: 1.2,
                              color: Colors.red.withOpacity(0.9)),
                          suffixIcon: SizedBox(
                            width: ScreenWidth * 0.05,
                            child: Center(
                                child: InkWell(
                              onTap: () async {
                                final TimeOfDay? picked = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now());
                                if (picked != null) {
                                  setState(() {
                                    datetime.text =
                                        picked.format(context).toString();
                                  });
                                }
                              },
                              child: SvgPicture.asset(
                                "images/time_icon.svg",
                                width: ScreenWidth * 0.04,
                              ),
                            )),
                          ),
                          contentPadding: EdgeInsets.only(
                              top: ScreenHeight * 0.00,
                              bottom: ScreenHeight * 0.00),
                          hintText: "select time",
                          hintStyle: TextStyle(
                              fontSize: SizeConfig.textMultiplier! * 11,
                              color: const Color(0xffADADAD)),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x33adadad), width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: greenThemeColor.withOpacity(0.2),
                                width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x33adadad), width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Color(0x33adadad), width: 1),
                            borderRadius: BorderRadius.all(
                                Radius.circular(ScreenWidth * 0.0133333)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 15 * SizeConfig.heightMultiplier!,
                ),
                Container(
                  width: 298* SizeConfig.widthMultiplier!,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this field is mandetory";
                      } else {
                        return null;
                      }
                    },
                    controller: buddyRequired,
                    style: TextStyle(
                        color: Colors.black.withOpacity(0.7),
                        fontSize: SizeConfig.textMultiplier! * 11),
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 10,
                          height: 1.2,
                          color: Colors.red.withOpacity(0.9)),
                      suffixIcon: SizedBox(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [

                            IconButton(
                              icon: const Icon(
                                Icons.remove,
                                color: Color(0xff2BD67B),                              ),
                              iconSize: 20 * SizeConfig.heightMultiplier!,
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                setState(() {
                                  if (counter >= 2) {
                                    counter--;
                                  }
                                });
                              },
                            ),

                            Text(
                              '$counter',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add,
                                color:  Color(0xff2BD67B),
                              ),
                              iconSize: 20 * SizeConfig.heightMultiplier!,
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                                setState(() {
                                  if (counter <= 2) {
                                    counter++;
                                  }
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      contentPadding: EdgeInsets.only(
                          top: ScreenHeight * 0.00,
                          bottom: ScreenHeight * 0.00),
                      hintText: "Buddy Required",
                      hintStyle: TextStyle(
                          fontSize: SizeConfig.textMultiplier! * 11,
                          color: const Color(0xffADADAD)),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: greenThemeColor.withOpacity(0.2),
                            width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color(0x33adadad), width: 1),
                        borderRadius: BorderRadius.all(
                            Radius.circular(ScreenWidth * 0.0133333)),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height: 15 * SizeConfig.heightMultiplier!,
                ),


              ],
            )),
        Step(
            isActive: currentStep >= 1,
            title: const Text('Confirm'),
            content: Container(
              width: 320 * SizeConfig.widthMultiplier!,
              height: 450 * SizeConfig.heightMultiplier!,
              decoration: BoxDecoration(
                  color: const Color(0xffFFFFFF),
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xff7AD7F0).withOpacity(0.1),
                        const Color(0xffDBF3FA).withOpacity(0.1)
                      ])),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12 * SizeConfig.widthMultiplier!,
                        top: 9 * SizeConfig.heightMultiplier!),
                    child: Row(
                      children: [
                        Text(
                          "Booking Details",
                          style: TextStyle(
                            color: const Color(0xff0398FF),
                            fontSize: 15 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 13 * SizeConfig.widthMultiplier!,
                        top: 23 * SizeConfig.heightMultiplier!),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "images/user_icon.svg",
                          width: ScreenWidth * 0.04,
                        ),
                        SizedBox(width: 5 * SizeConfig.widthMultiplier!),
                        Text('${name.text}')
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 13 * SizeConfig.widthMultiplier!,
                        top: 10 * SizeConfig.heightMultiplier!),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "images/gender_ icon.svg",
                          width: ScreenWidth * 0.04,
                        ),
                        SizedBox(width: 5 * SizeConfig.widthMultiplier!),
                        Text('${age.text}')
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 13 * SizeConfig.widthMultiplier!,
                        top: 10 * SizeConfig.heightMultiplier!),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "images/contact_ no.svg",
                          width: ScreenWidth * 0.05,
                        ),
                        SizedBox(width: 5 * SizeConfig.widthMultiplier!),
                        Text('${contactNumber.text}')
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12 * SizeConfig.widthMultiplier!,
                        top: 9 * SizeConfig.heightMultiplier!),
                    child: Row(
                      children: [
                        Text(
                          "Address",
                          style: TextStyle(
                            color: const Color(0xff8E8E8E),
                            fontSize: 14 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12 * SizeConfig.widthMultiplier!,
                        top: 9 * SizeConfig.heightMultiplier!),
                    child: Row(
                      children: [
                        Text(
                          '${address.text}',
                          style: TextStyle(
                            color: const Color(0xff8E8E8E),
                            fontSize: 12 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 11 * SizeConfig.heightMultiplier!,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12 * SizeConfig.widthMultiplier!,
                        top: 9 * SizeConfig.heightMultiplier!),
                    child: Row(
                      children: [
                        Text(
                          "Date & Time",
                          style: TextStyle(
                            color: const Color(0xff0398FF),
                            fontSize: 14 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 13 * SizeConfig.widthMultiplier!,
                        top: 8 * SizeConfig.heightMultiplier!),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          "images/appointment_icon.svg",
                          width: ScreenWidth * 0.04,
                        ),
                        SizedBox(width: 5 * SizeConfig.widthMultiplier!),
                        Text('${date.text}')
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12 * SizeConfig.widthMultiplier!,
                        top: 9 * SizeConfig.heightMultiplier!),
                    child: Row(
                      children: [
                        Text(
                          "Booked  For Buddy",
                          style: TextStyle(
                            color: const Color(0xff8E8E8E),
                            fontSize: 14 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 5 * SizeConfig.heightMultiplier!),
                  const Divider(),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 12 * SizeConfig.widthMultiplier!,
                        top: 9 * SizeConfig.heightMultiplier!),
                    child: Row(
                      children: [
                        Text(
                          "Buddy Details",
                          style: TextStyle(
                            color: const Color(0xff0398FF),
                            fontSize: 15 * SizeConfig.textMultiplier!,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )),
        Step(
            isActive: currentStep >= 2,
            title: const Text('Pay'),
            content: Container()),
      ];
}

class _serviceContainer extends StatelessWidget {
  _serviceContainer({
    Key? key,
  }) : super(key: key);

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
          Text(
            'hii',
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

class CustomStepIndicator extends StatelessWidget {
  const CustomStepIndicator(
      {Key? key,
      required this.length,
      required this.currentStep,
      required this.lineWidth,
      required this.stepNameList,
      this.textWidth})
      : super(key: key);
  final int length;
  final int currentStep;
  final double lineWidth;
  final double? textWidth;
  final List<String> stepNameList;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 28 * SizeConfig.heightMultiplier!,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(length, (index) {
              return Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 50 * SizeConfig.heightMultiplier!,
                      width: 50 * SizeConfig.widthMultiplier!,
                      decoration: BoxDecoration(
                          color: (index < currentStep)
                              ? const Color(0xffFF7800)
                              : (index == currentStep)
                                  ? const Color(0xffFF7800)
                                  : const Color(0xffD2E5F2),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                color: (index < currentStep)
                                    ? const Color(0xffFF7800)
                                    : (index == currentStep)
                                        ? const Color(0xffFF7800)
                                        : grayTextColor.withOpacity(0.0),
                                blurRadius: 3,
                                offset: const Offset(0, 2))
                          ]),
                      child: Column(
                        children: [
                          Container(
                            height: 50 * SizeConfig.heightMultiplier!,
                            width: 40 * SizeConfig.widthMultiplier!,
                            decoration: const BoxDecoration(
                              color: Color(0xffFFFFFF),
                              shape: BoxShape.circle,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 23 * SizeConfig.heightMultiplier!,
                                  width: 23 * SizeConfig.widthMultiplier!,
                                  decoration: BoxDecoration(
                                      color: (index < currentStep)
                                          ? const Color(0xffFF7800)
                                          : (index == currentStep)
                                              ? const Color(0xffFF7800)
                                              : const Color(0xff0398FF)
                                                  .withOpacity(0.2),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            color: (index < currentStep)
                                                ? const Color(0xffFF7800)
                                                : (index == currentStep)
                                                    ? const Color(0xffFF7800)
                                                    : grayTextColor
                                                        .withOpacity(0.0),
                                            blurRadius: 3,
                                            offset: const Offset(0, 2))
                                      ]),
                                  child: Center(
                                    child: Text(
                                      (index + 1).toString(),
                                      style: TextStyle(
                                          color: index > currentStep
                                              ? const Color(0xff0398FF)
                                              : Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontSize:
                                              11 * SizeConfig.textMultiplier!),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (index < length - 1)
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 3 * SizeConfig.widthMultiplier!),
                        height: 1,
                        width: lineWidth * SizeConfig.widthMultiplier!,
                        color: index < currentStep
                            ? const Color(0xff0398FF)
                            : const Color(0xffE9ECFB),
                      )
                  ],
                ),
              );
            }),
          ),
          SizedBox(
            height: 10 * SizeConfig.heightMultiplier!,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              length,
              (index) => SizedBox(
                  width: textWidth ?? ScreenWidth * 0.15,
                  child: Text(
                    stepNameList[index],
                    style: TextStyle(
                        color: const Color(0xff0398FF),
                        fontSize: SizeConfig.textMultiplier! * 10,
                        fontWeight: FontWeight.w500),
                    textAlign: TextAlign.center,
                  )),
            ),
          ),
          SizedBox(
            height: 30 * SizeConfig.heightMultiplier!,
          ),
        ],
      ),
    );
  }
}
