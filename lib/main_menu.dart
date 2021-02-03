import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'dart:convert';

// import 'login.dart';

import 'package:http/http.dart' as http;
import 'package:moneytory/add_income.dart';
import 'package:moneytory/add_outcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenu extends StatefulWidget {
  MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: 79,
          decoration: BoxDecoration(boxShadow: <BoxShadow>[
            BoxShadow(
                color: HexColor("#EDF3FF"), blurRadius: 20, spreadRadius: 4)
          ]),
          child: BottomNavigationBar(
            selectedItemColor: HexColor("#4D84FF"),
            unselectedItemColor: Colors.black,
            elevation: 0.0,
            backgroundColor: Colors.white,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(
                  FeatherIcons.home,
                  size: 22,
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: new Icon(FeatherIcons.clock, size: 22),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: new Icon(FeatherIcons.logOut, size: 22),
                label: "",
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(left: 47, bottom: 20),
              alignment: Alignment.topLeft,
              child: Image.asset(
                "images/logo.png",
                width: 100,
              ),
            ),
            Container(
              child: Center(
                child: Text("Current Balance",
                    style: GoogleFonts.raleway(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: HexColor("#A5A5A5"))),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: FutureBuilder<MyCredit>(
                  future: getCredit(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                          child: Container(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("Rp.${snapshot.data.currentBalance}",
                                  style: GoogleFonts.ptMono(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700,
                                      color: HexColor("#091D4B")))));
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return CircularProgressIndicator();
                  },
                )),
            Container(
                alignment: Alignment.center,
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30, right: 10),
                        width: 154,
                        height: 48,
                        child: RaisedButton(
                          child: Text(
                            "Add Income",
                            style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 14),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddIncome()));
                          },
                          textColor: Colors.white,
                          color: HexColor("#4D84FF"),
                          padding: EdgeInsets.all(10),
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        width: 154,
                        height: 48,
                        child: RaisedButton(
                          child: Text(
                            "Add Outcome",
                            style: GoogleFonts.raleway(
                                fontWeight: FontWeight.w500,
                                color: HexColor("#CAD7F4"),
                                fontSize: 14),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(color: HexColor("#CAD7F4"))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddOutcome()));
                          },
                          textColor: HexColor("#CAD7F4"),
                          color: Colors.white,
                          padding: EdgeInsets.all(10),
                          elevation: 0,
                          hoverElevation: 0,
                          focusElevation: 0,
                          highlightElevation: 0,
                        ),
                      )
                    ],
                  ),
                )),
            Container(
              margin: EdgeInsets.only(top: 40, left: 47),
              child: Text(
                "Latest Transaction",
                style: GoogleFonts.raleway(fontSize: 14),
              ),
            ),
            Container(
              child: Center(
                child: FutureBuilder<History>(
                    future: getHistory(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: Center(
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 40, top: 28),
                                  width: 52,
                                  height: 52,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: HexColor("#CAD7F4")),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset("images/ArrowUp.png"),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10, top: 40),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("${snapshot.data.email}",
                                            style: GoogleFonts.raleway(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                        Text("${snapshot.data.createdAt}",
                                            style: GoogleFonts.raleway(
                                                fontSize: 12,
                                                color: HexColor("#A5A5A5")))
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                    width: 100,
                                    margin: EdgeInsets.only(left: 20, top: 40),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "+ Rp.${snapshot.data.jumlah}",
                                          style: GoogleFonts.ptMono(
                                              fontSize: 12,
                                              color: HexColor("#14A433"),
                                              fontWeight: FontWeight.normal),
                                          textAlign: TextAlign.end,
                                        )
                                      ],
                                    ))
                              ],
                            ),
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return Text("${snapshot.data.id}");
                    }),
              ),
            ),
          ],
        ));
  }
}

Future<History> getHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var token = prefs.getString('token');
  String url = 'http://18.217.56.142/api/myHistory';
  final response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: "Bearer $token",
    "Accept": "application/json",
  });

  if (response.statusCode == 200) {
    return History.fromJson(json.decode(response.body)[0]);
  } else {
    throw Exception('Failed to load post');
  }
}

class History {
  History({
    this.id,
    this.email,
    this.jumlah,
    this.kategori,
    this.keterangan,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String email;
  int jumlah;
  String kategori;
  String keterangan;
  DateTime createdAt;
  DateTime updatedAt;

  factory History.fromJson(Map<String, dynamic> json) => History(
        id: json["id"],
        email: json["email"],
        jumlah: json["jumlah"],
        kategori: json["kategori"],
        keterangan: json["keterangan"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "jumlah": jumlah.toString(),
        "kategori": kategori,
        "keterangan": keterangan,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

Future<MyCredit> getCredit() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var token = prefs.getString('token');
  String url = 'http://18.217.56.142/api/myCredit';
  final response = await http.get(url, headers: {
    HttpHeaders.authorizationHeader: "Bearer $token",
    "Accept": "application/json",
  });

  if (response.statusCode == 200) {
    return MyCredit.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load post');
  }
}

class MyCredit {
  MyCredit({
    this.email,
    this.currentBalance,
    this.lastUpdated,
  });

  String email;
  int currentBalance;
  dynamic lastUpdated;

  factory MyCredit.fromJson(Map<String, dynamic> json) => MyCredit(
        email: json["email"],
        currentBalance: json["current_balance"],
        lastUpdated: json["last_updated"],
      );
}
