import 'package:flutter/material.dart';
import 'package:samedaypro/page/setting.dart';
import 'createticket.dart';

class HelpDesk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "HelpDesk",
      home: TicketPage(),
    );
  }
}

class TicketPage extends StatefulWidget {
  @override
  _TicketPageState createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/tkt1.png'),
              fit: BoxFit.cover)
      ),

      child: Scaffold(
        appBar: AppBar(
          leading: Card(
            elevation:30,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context);

                }),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Center(
              child: Text(
                'HelpDesk Page',
                style: TextStyle(color: Colors.black),
              ),

          ),
          automaticallyImplyLeading: false, //back Button
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          padding: EdgeInsets.only(left: 16, top: 150, right: 16),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
              height: 350,
              child: Card(
                elevation:30,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => CreateTicket()),
                            );
                          },
                          color: Colors.orange,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Create Ticket",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,

                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Setting()),
                            );
                          },
                          color: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "Ticket Status",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,

                                color: Colors.black),
                          ),
                        ),

                      ],
                    )
                  ],
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}
