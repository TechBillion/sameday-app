import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screeen/changePassSucess.dart';
import '../widgets/back_button.dart';

class ChangePass extends StatefulWidget {
  const ChangePass({Key? key}) : super(key: key);

  @override
  State<ChangePass> createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  bool _isLoading = false;
  bool showPassword = false;
  final storage = const FlutterSecureStorage();

  final TextEditingController OldPassword = TextEditingController();
  final TextEditingController NewPasswordController = TextEditingController();
  final TextEditingController ConfirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() async {
    String? token = await storage.read(key: "access_token");
  }

  Future<void> chnagepass() async {
    const storage = FlutterSecureStorage();
    String? token = await storage.read(key: "access_token");

    if (OldPassword.text.isNotEmpty &&
        NewPasswordController.text.isNotEmpty &&
        ConfirmPasswordController.text.isNotEmpty) {
      var response = await http.post(
          Uri.parse(
              "http://armanshaikh-001-site1.itempurl.com/api/Account/ChangePassword"),
          encoding: const Utf8Codec(),
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Access-Control_Allow_Origin": "true",
            'Authorization': 'Bearer ${token}',
            'Access-Control-Allow-Credentials': 'true',
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
          },
          body: json.encode({
            'OldPassword': OldPassword.text,
            'NewPassword': NewPasswordController.text,
            'ConfirmPassword': ConfirmPasswordController.text,
          }));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        await storage.delete(key: "access_token");
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChangePassSuccess()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(response.body),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(" Please fill the details")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/rstpass2.png'), fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          leading: CustomBackButton(parentContext: context),
          elevation: 0,
          backgroundColor: Colors.transparent,

          automaticallyImplyLeading: false, //back Button
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 35, top: 120),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    right: 35,
                    left: 35),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: OldPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        prefixIcon: const Icon(Icons.password),
                        filled: true,
                        hintText: 'CurrentPassword',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.orange,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: NewPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        prefixIcon: const Icon(Icons.password),
                        filled: true,
                        hintText: 'NewPassword',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.orange,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: ConfirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        prefixIcon: const Icon(Icons.password),
                        filled: true,
                        hintText: 'Confirm Password',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.orange,
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            height: 55.99,
                            child: Material(
                              borderRadius: BorderRadius.circular(10.0),
                              shadowColor: Colors.orange[500],
                              color: Colors.orange[500],
                              elevation: 7.0,
                              child: TextButton(
                                onPressed: OldPassword.text == "" ||
                                        NewPasswordController.text == "" ||
                                        ConfirmPasswordController.text == ""
                                    ? null
                                    : () {
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        chnagepass();
                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        });
                                      },
                                child: const Center(
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Montserrat'),
                                  ),
                                ),
                              ),
                            ),
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

  Widget _textFieldOTP({required bool first, last}) {
    return SizedBox(
      height: 60,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: TextField(
          autofocus: true,
          onChanged: (value) {
            if (value.length == 1 && last == false) {
              FocusScope.of(context).nextFocus();
            }
            if (value.length == 0 && first == false) {
              FocusScope.of(context).previousFocus();
            }
          },
          showCursor: false,
          readOnly: false,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          keyboardType: TextInputType.number,
          maxLength: 1,
          decoration: InputDecoration(
            counter: const Offstage(),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.black12),
                borderRadius: BorderRadius.circular(12)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 2, color: Colors.orange),
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
    );
  }
}
