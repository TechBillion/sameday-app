import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:samedaypro/homepage.dart';
import 'package:samedaypro/page/setting.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({Key? key, GoogleSignInAccount? user}) : super(key: key);

  

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {


  int currentTab = 0;
  final List<Widget> screens = [HomePage()];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: SizedBox(
        height: 50,
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = HomePage();
                    currentTab = 0;
                  });
                },
                child: Icon(
                  Icons.home,
                  color: currentTab == 0 ? Colors.blue : Colors.grey,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = HomePage();
                    currentTab = 0;
                  });
                },
                child: Icon(
                  Icons.category,
                  color: currentTab == 0 ? Colors.blue : Colors.grey,
                ),
              ),

              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = HomePage();
                    currentTab = 0;
                  });
                },
                child: Icon(
                  Icons.supervisor_account_sharp,
                  color: currentTab == 0 ? Colors.blue : Colors.grey,
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = const Setting();
                    currentTab = 0;
                  });
                },
                child: Icon(
                  Icons.person,
                  color: currentTab == 0 ? Colors.blue : Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
