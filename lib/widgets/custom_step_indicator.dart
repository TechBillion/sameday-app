import 'package:flutter/material.dart';
import 'package:sameday/global_variables.dart';
import 'package:sameday/size_config.dart';

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
                            decoration: BoxDecoration(
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
                                              ? Color(0xff0398FF)
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
                            ? Color(0xff0398FF)
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
