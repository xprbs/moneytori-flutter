import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moneytory/login.dart';

class GetStarted extends StatefulWidget {
  GetStarted({Key key}) : super(key: key);

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 140.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Moneytory',
                  style: GoogleFonts.raleway(
                      fontWeight: FontWeight.w900,
                      color: HexColor("#091D4B"),
                      fontSize: 28),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 14),
                  width: 180,
                  child: Text(
                    'Learn how to manage and balance your budget with us!',
                    style: GoogleFonts.raleway(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: HexColor("#A5A5A5")),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 51, bottom: 51),
                  child: Image.asset("images/i1.png"),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 318,
                  height: 49,
                  child: RaisedButton(
                    child: Text(
                      "Get Started",
                      style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    textColor: Colors.white,
                    color: HexColor("#4D84FF"),
                    padding: EdgeInsets.all(10),
                    elevation: 0,
                    hoverElevation: 0,
                    focusElevation: 0,
                    highlightElevation: 0,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
