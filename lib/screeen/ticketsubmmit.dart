import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:samedaypro/page/dashboard.dart';
import '../createticket.dart';


class TicketSubmit extends StatefulWidget {
  @override
  State<TicketSubmit> createState() => _TicketSubmitState();
}

class _TicketSubmitState extends State<TicketSubmit> {
  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/tkt1.png'),
            fit: BoxFit.cover),
      ),

      child: Scaffold(
        appBar: AppBar(
          leading: Card(
            elevation:2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            child: IconButton(
                icon: Icon(Icons.arrow_back_ios_sharp),
                color: Colors.blue,
                onPressed: () {

                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => CreateTicket()),
                  );
                }),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false, //back Button
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  Container(
                      child: Center(child: SvgPicture.asset('assets/tktsuccess.svg'),
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Center(
              child: Container(
                height: 200,
                child: Card(
                    elevation:30,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Your Ticket Has Been Successfully Summited ',
                                style: TextStyle
                                  (fontWeight: FontWeight.bold, color: Colors.black),

                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Your Ticket ID Is #12FF42',
                                style: TextStyle
                                  (fontWeight: FontWeight.bold, color: Colors.black),

                              ),
                            ),

                          ],
                        )
                      ],
                    )
                ),
              ),
            ),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 0, top: 500),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Dashboard()),
                      );
                    },
                    color: Colors.orange,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Goto HomePage",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
