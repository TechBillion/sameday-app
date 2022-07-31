import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samedaypro/page/appointmentpage.dart';
import 'package:samedaypro/page/setting.dart';
import 'model/my_drawer_header.dart';


class SameDayHome extends StatelessWidget {
  const SameDayHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var currentPage = DrawerSections.dashboard;

  @override
  Widget build(BuildContext context) {
    Widget? container;
    if (currentPage == DrawerSections.dashboard) {
      container = null;
    } else if (currentPage == DrawerSections.contacts) {
      container = Calendar();
    } else if (currentPage == DrawerSections.events) {
      container = Calendar();
    } else if (currentPage == DrawerSections.notes) {
      container = Calendar();
    } else if (currentPage == DrawerSections.settings) {
      container = const Setting();
    } else if (currentPage == DrawerSections.notifications) {
      container = const Setting();
    } else if (currentPage == DrawerSections.privacy_policy) {
      container = const Setting();
    } else if (currentPage == DrawerSections.send_feedback) {
      container = const Setting();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('SameDay'),
        elevation: 0,
        backgroundColor: Colors.orange,
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const MyHeaderDrawer(),
              MyDrawerList(),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: container??
      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 90,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: TextField(
                  decoration: InputDecoration(
                      prefix: const Icon(
                        Icons.search_sharp,
                        color: Colors.orange,
                      ),
                      suffixIcon: const Icon(
                        Icons.mic_none_outlined,
                        color: Colors.orange,
                      ),
                      hintText: 'Search By Keyword Or By Product ID',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.blue))),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0.0),
              child: Divider(
                height: 2,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 70,
                    width: 70,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: SvgPicture.asset(
                        'assets/comrep.svg',
                      ),
                      onPressed: () {},
                      //do something,
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            'assets/comrep.svg',
                          ),
                          onPressed: () {}, //do something,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            'assets/comrep.svg',
                          ),
                          onPressed: () {}, //do something,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 70,
                        width: 70,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            'assets/comrep.svg',
                          ),
                          onPressed: () {}, //do something,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 280,
              width: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/bookopd.png'),
                ),

              ),
            ),
            Divider(
              height: 0.1,
              color: Colors.grey[800],
            ),
            Container(
              height: 280,
              width: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/help.png'),
                ),
              ),
            ),
            Divider(
              height: 0.1,
              color: Colors.grey[800],
            ),
            Container(
              height: 280,
              width: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/help3.png'),
                ),
              ),
            ),
            Divider(
              height: 0.1,
              color: Colors.grey[800],
            ),
            Container(
              height: 280,
              width: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/help2.png'),
                ),
              ),
            ),
            Divider(
              height: 0.1,
              color: Colors.grey[800],
            ),
            Container(
              height: 280,
              width: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/help1.png'),
                ),
              ),
            ),
            Divider(
              height: 0.1,
              color: Colors.grey[800],
            ),
            Container(
              height: 280,
              width: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/help3.png'),
                ),
              ),
            ),
            Divider(
              height: 0.1,
              color: Colors.grey[800],
            ),
            Container(
              height: 280,
              width: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/help2.png'),
                ),
              ),
            ),
            Divider(
              height: 2,
              color: Colors.grey[800],
            ),
            Container(
              height: 280,
              width: 500,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/help1.png'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget MyDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        // shows the list of menu drawer
        children: [
          menuItem(1, "Dashboard",
              Icons.dashboard_outlined,
              currentPage == DrawerSections.dashboard ? true : false),
          menuItem(2, "Contacts", Icons.people_alt_outlined,
              currentPage == DrawerSections.contacts ? true : false),
          menuItem(3, "Events", Icons.event,
              currentPage == DrawerSections.events ? true : false),
          menuItem(4, "Notes", Icons.notes,
              currentPage == DrawerSections.notes ? true : false),
          const Divider(),
          menuItem(5, "Settings", Icons.settings_outlined,
              currentPage == DrawerSections.settings ? true : false),
          menuItem(6, "Notifications", Icons.notifications_outlined,
              currentPage == DrawerSections.notifications ? true : false),
          const Divider(),
          menuItem(7, "Privacy policy", Icons.privacy_tip_outlined,
              currentPage == DrawerSections.privacy_policy ? true : false),
          menuItem(8, "Send feedback", Icons.feedback_outlined,
              currentPage == DrawerSections.send_feedback ? true : false),






        ],
      ),
    );
  }

  Widget menuItem(int id, String title, IconData icon, bool selected) {
    return Material(
      color: selected ? Colors.grey[300] : Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          setState(() {
            if (id == 1) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 2) {
              currentPage = DrawerSections.contacts;
            } else if (id == 3) {
              currentPage = DrawerSections.events;
            } else if (id == 4) {
              currentPage = DrawerSections.notes;
            } else if (id == 5) {
              currentPage = DrawerSections.settings;
            } else if (id == 6) {
              currentPage = DrawerSections.notifications;
            } else if (id == 7) {
              currentPage = DrawerSections.privacy_policy;
            } else if (id == 8) {
              currentPage = DrawerSections.send_feedback;
            }


          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                child: Icon(
                  icon,
                  size: 20,
                  color: Colors.orange,
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  title,
                  style:
                   GoogleFonts.poppins(
                      textStyle:
                      Theme.of(context).textTheme.bodyMedium,
                      fontWeight: FontWeight.w600,
                    ),


                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  dashboard,
  contacts,
  events,
  notes,
  settings,
  notifications,
  privacy_policy,
  send_feedback,

}
