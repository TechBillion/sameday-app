import 'package:flutter/cupertino.dart';

class RemoveScrollGlow extends ScrollBehavior {
  // @override
  // Widget buildViewportChrome(
  //     BuildContext context, Widget child, AxisDirection axisDirection) {
  //     return child;
  // }
  // @override
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}
