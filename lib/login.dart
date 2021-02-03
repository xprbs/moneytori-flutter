// import 'dart:async';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
// import 'package:moneytory/main_menu.dart';
import 'package:moneytory/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import 'main_menu.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final globalkey = GlobalKey<ScaffoldState>();

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalkey,
      body: Container(
        // padding: EdgeInsets.only(top: 110.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 47),
                  child: Image.asset("images/logo.png"),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 100, left: 47),
                    child: Text(
                      "Login",
                      style: GoogleFonts.raleway(
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          color: HexColor("#091D4B")),
                    ))
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                    margin: EdgeInsets.only(top: 10, left: 47),
                    width: 200,
                    child: Text("Enter your email and password before continue",
                        style: GoogleFonts.raleway(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: HexColor("#A5A5A5"))))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 46),
                  width: 318,
                  height: 49,
                  color: HexColor("#F1F1F1"),
                  child: TextField(
                    controller: email,
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
                      hintText: "enter your email",
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 20),
                  width: 318,
                  height: 49,
                  color: HexColor("#F1F1F1"),
                  child: TextField(
                      controller: password,
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
                        hintText: "enter your password",
                      ),
                      enableSuggestions: false,
                      obscureText: true),
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
                      "Login",
                      style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          fontSize: 14),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () async {
                      if (email.text == null || password.text == null) {
                        showSnackBar('Please fill all field');
                      } else {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        String sEmail = email.text;
                        String sPassword = password.text;
                        final url = 'http://18.217.56.142/api/login';

                        var requestBody = {
                          'email': sEmail,
                          'password': sPassword,
                        };

                        http.Response response = await http.post(
                          url,
                          body: requestBody,
                        );
                        if (response.statusCode != 200) {
                          showSnackBar('Login Gagal!');
                        } else {
                          var token = jsonDecode(response.body)['token'];
                          await prefs.setString('token', token);

                          print(prefs.getString('token'));
                          showSnackBar('Login Berhasil!');
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 80),
                  child: RaisedButton(
                    child: Text(
                      "Don't have an account? Register Here",
                      style: GoogleFonts.raleway(
                          fontWeight: FontWeight.w400,
                          color: HexColor("#A5A5A5"),
                          fontSize: 14),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    textColor: HexColor("#A5A5A5"),
                    color: HexColor("#FFFFF"),
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
