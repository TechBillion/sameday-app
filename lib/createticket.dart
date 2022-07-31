import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:samedaypro/screeen/ticketsubmmit.dart';
import 'package:samedaypro/widgets/back_button.dart';

class CreateTicket extends StatelessWidget {
  const CreateTicket({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Create Ticket",
      home: CreateTicketPage(),
    );
  }
}

class CreateTicketPage extends StatefulWidget {
  const CreateTicketPage({Key? key}) : super(key: key);

  @override
  _CreateTicketPage createState() => _CreateTicketPage();
}

class _CreateTicketPage extends State<CreateTicketPage> {
  final TextEditingController orderId = TextEditingController();
  final TextEditingController subject = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController description = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> createTicket() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");
    if (orderId.text.isNotEmpty &&
        subject.text.isNotEmpty &&
        mobileNo.text.isNotEmpty &&
        description.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse("http://armanshaikh-001-site1.itempurl.com/SaveTicket"),
          encoding: const Utf8Codec(),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "true",
            'Authorization': 'Bearer $token',
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
          },
          body: json.encode({
            'OrderId': orderId.text,
            'Subject': subject.text,
            'MobileNo': mobileNo.text,
            'Discription': description.text,
          }));

      if (response.statusCode == 200) {
        jsonDecode(response.body.toString());
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TicketSubmit()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.body)));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(" Please fill the details")));
    }
  }

  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/tkt1.png'), fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(parentContext: context),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title:  Center(
            child: Text(
              'Create Ticket',
              style: GoogleFonts.poppins(
                textStyle:
                Theme.of(context).textTheme.bodyMedium,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          automaticallyImplyLeading: false, //back Button
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 16, top: 50, right: 16),
          child: Form(
            child: Column(
              children: [
                Card(
                  child: Column(
                    children: [
                      TextField(
                        controller: orderId,
                        decoration: const InputDecoration(
                          hintText: 'Please enter your order ID',
                          labelText: 'Order ID',
                          labelStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          TextField(
                            controller: subject,
                            decoration: const InputDecoration(
                              hintText: 'Please enter your issue',
                              labelText: 'Subject',
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          TextField(
                            controller: mobileNo,
                            decoration: const InputDecoration(
                              hintText: 'MobileNo',
                              labelText: 'MobileNo',
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          TextField(
                            controller: description,
                            decoration: const InputDecoration(
                              hintText: 'Discription',
                              labelText: 'Discription',
                              labelStyle: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                              ),
                              border: OutlineInputBorder(),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: orderId.text == "" ||
                              subject.text == "" ||
                              mobileNo.text == "" ||
                              description.text == ""
                          ? null
                          : () {
                              setState(() {
                                _isLoading = true;
                              });
                              createTicket();
                            },
                      color: Colors.orange,
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text(
                        "Submit",
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
