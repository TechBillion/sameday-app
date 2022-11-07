import 'package:flutter/material.dart';

import '../../widgets/sameday_appbar.dart';

class AccountCreated extends StatelessWidget {
  const AccountCreated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xffF9FBFF),
      appBar: SameDayAppBar(
        parentContext: context,
        wantOtherIcons: false,
      ),
      resizeToAvoidBottomInset: true,
      body:   Image.asset(
        "assets/polygon_.png",
      ),
    );



  }
}
