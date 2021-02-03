import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'main_menu.dart';

class AddOutcome extends StatefulWidget {
  AddOutcome({Key key}) : super(key: key);

  @override
  _AddOutcomeState createState() => _AddOutcomeState();
}

class _AddOutcomeState extends State<AddOutcome> {
  final globalkey = GlobalKey<ScaffoldState>();

  TextEditingController jumlah = new TextEditingController();
  TextEditingController keterangan = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalkey,
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
        body: Column(children: [
          Container(
            margin: EdgeInsets.only(left: 47, bottom: 20),
            alignment: Alignment.topLeft,
            child: Image.asset(
              "images/logo.png",
              width: 100,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 318,
                height: 49,
                color: HexColor("#F1F1F1"),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: jumlah,
                  autocorrect: false,
                  autofocus: false,
                  style: GoogleFonts.raleway(
                      fontSize: 14, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#F1F1F1")),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Jumlah Pengeluaran",
                  ),
                  enableSuggestions: false,
                ),
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 318,
                height: 49,
                color: HexColor("#F1F1F1"),
                child: TextField(
                  controller: keterangan,
                  autocorrect: false,
                  autofocus: false,
                  style: GoogleFonts.raleway(
                      fontSize: 14, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: HexColor("#F1F1F1")),
                        borderRadius: BorderRadius.circular(10)),
                    hintText: "Keterangan",
                  ),
                  enableSuggestions: false,
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(top: 45),
                width: 318,
                height: 49,
                child: RaisedButton(
                  child: Text(
                    "Tambah",
                    style: GoogleFonts.raleway(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 14),
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  onPressed: () async {
                    if (jumlah.text == null || keterangan.text == null) {
                      showSnackBar('Please fill all field');
                    } else {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      String sJumlah = jumlah.text;
                      String sKeterangan = keterangan.text;
                      final url = 'http://18.217.56.142/api/addTransaction';
                      var token = prefs.getString('token');
                      var requestBody = {
                        'jumlah': sJumlah,
                        'keterangan': sKeterangan,
                        'kategori': 'outcome'
                      };

                      http.Response response =
                          await http.post(url, body: requestBody, headers: {
                        HttpHeaders.authorizationHeader: "Bearer $token",
                        "Accept": "application/json",
                      });

                      if (response.statusCode != 200) {
                        showSnackBar('Gagal!');
                      } else {
                        var token = jsonDecode(response.body)['token'];

                        print(prefs.getString('token'));
                        showSnackBar('Berhasil!');
                        // ignore: unused_local_variable
                        Timer timer;
                        timer = new Timer(const Duration(seconds: 5), () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainMenu()));
                        });
                      }
                    }
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
          ),
        ]));
  }

  showSnackBar(text) {
    final snackbar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red[900],
      action: SnackBarAction(
        label: '',
        onPressed: () {
          print('Clicked');
        },
      ),
    );
    globalkey.currentState.showSnackBar(snackbar);
  }
}
