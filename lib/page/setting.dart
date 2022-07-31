import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:samedaypro/alert_dialog.dart';
import 'package:samedaypro/loginhome.dart';
import 'package:samedaypro/page/changepass.dart';
import 'package:http/http.dart' as http;
import '../editprofile.dart';
import '../helpdesk.dart';
import '../model/profilemodel.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  late Future<ProfileModel> profileModel;
  final storage = const FlutterSecureStorage();
  bool circular = true;
  String? username;

  String title = 'AlertDialog';
  bool tappedYes = false;

  @override
  void initState() {
    super.initState();
    profileModel = getProfile();
    getuserEmail();
  }

  Future<ProfileModel> getProfile() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");
    final response = await http.get(
        Uri.parse(
            "http://armanshaikh-001-site1.itempurl.com/api/Account/UserInfo"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "true",
          'Authorization': 'Bearer $token',
          'Access-Control-Allow-Credentials': 'true',
          'Access-Control-Allow-Headers': 'Content-Type',
          'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
        });
    if (response.statusCode == 200) {
      ProfileModel.fromJson(json.decode(response.body));

      return ProfileModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed");
    }
  }

  void logout() async {
    await storage.delete(key: "access_token");
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => LoginHome()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/profile.png'), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title:  Center(
            child: Text(
              'Profile Page',
              style: GoogleFonts.poppins(
                textStyle:
                Theme.of(context).textTheme.bodyMedium,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          automaticallyImplyLeading: false, //back Button
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 30),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      child: Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0)),
                        color: Colors.orange,
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => const SettingsUI()),
                            );
                          },
                          title: Center(
                            child: Text(username ?? "loading..",
                              style: GoogleFonts.poppins(
                                textStyle:
                                Theme.of(context).textTheme.bodyMedium,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          leading: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/img.jpg'),
                            ),
                          ),
                          trailing: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.edit,
                              color: Colors.blue,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Card(
                      elevation: 10,
                      margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: SizedBox(
                        //height: 500,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading: const Icon(
                                Icons.email,
                                color: Colors.blue,
                              ),
                              title: FutureBuilder<ProfileModel>(
                                  future: profileModel,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: <Widget>[
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(snapshot.data!.Email,
                                              style: GoogleFonts.poppins(
                                                textStyle:
                                                Theme.of(context).textTheme.bodyMedium,
                                                fontWeight: FontWeight.w600,
                                              ),

                                            ),
                                          ),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    } else {
                                      return const Center(child: Text("loading.."));
                                    }
                                  }),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //email open
                              },
                            ),
                            _buildDivider(),
                            const SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.phone_iphone,
                                color: Colors.blue,
                              ),
                              title: FutureBuilder<ProfileModel>(
                                  future: profileModel,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return Column(
                                        children: <Widget>[
                                          Text(snapshot.data!.PhoneNumber,
                                            style: GoogleFonts.poppins(
                                              textStyle:
                                              Theme.of(context).textTheme.bodyMedium,
                                              fontWeight: FontWeight.w600,
                                            ),),
                                        ],
                                      );
                                    } else if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    } else {
                                      return const Center(
                                          child:   Center(child: Text("loading.."))
                                      );
                                    }
                                  }),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change password
                              },
                            ),
                            _buildDivider(),
                            const SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.lock_outline,
                                color: Colors.blue,
                              ),
                              title:
                                   Center(child: Text("Change Password",

                                    style: GoogleFonts.poppins(
                                      textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                      fontWeight: FontWeight.w600,
                                    ),


                                  )),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (context) => const ChangePass()),
                                );
                              },
                            ),
                            _buildDivider(),
                            const SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.help_center,
                                color: Colors.blue,
                              ),
                              title: Center(
                                  child: Text(
                                "HelpDesk",
                                style: GoogleFonts.poppins(
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        HelpDesk())); //open change password
                              },
                            ),
                            _buildDivider(),
                            const SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.account_balance_wallet,
                                color: Colors.blue,
                              ),
                              title: Center(child: Text("Wallet",
                                style: GoogleFonts.poppins(
                                  textStyle:
                                  Theme.of(context).textTheme.bodyMedium,
                                  fontWeight: FontWeight.w600,
                                ),)),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change language
                              },
                            ),
                            _buildDivider(),
                            const SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.star_rate,
                                color: Colors.blue,
                              ),
                              title:  Center(child: Text("Rating",
                                style: GoogleFonts.poppins(
                                  textStyle:
                                  Theme.of(context).textTheme.bodyMedium,
                                  fontWeight: FontWeight.w600,
                                ),
                              )),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change location
                              },
                            ),
                            _buildDivider(),
                            const SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.location_on,
                                color: Colors.blue,
                              ),
                              title: Center(child: Text("Location",
                                style: GoogleFonts.poppins(
                                  textStyle:
                                  Theme.of(context).textTheme.bodyMedium,
                                  fontWeight: FontWeight.w600,
                                ),)),
                              trailing: const Icon(Icons.keyboard_arrow_right),
                              onTap: () {
                                //open change location
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      children: [
                        Center(
                          child: RaisedButton(
                            onPressed: () async {
                              final action = await AlertDialogs.yesCancelDialog(
                                  context, 'Logout', 'Are you sure?');
                              if (action == DialogsAction.yes) {
                                setState(() => tappedYes = true);
                                {
                                  logout();
                                }
                              }
                            },
                            color: Colors.orange,
                            padding: const EdgeInsets.symmetric(horizontal: 50),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              'Logout'.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  getuserEmail() async {
    final String? userName = await storage.read(key: "userName");
    username = userName;
    setState(() {});
    return userName;
  }

  Container _buildDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      width: double.infinity,
      height: 1.0,
      color: Colors.grey.shade400,
    );
  }
}
