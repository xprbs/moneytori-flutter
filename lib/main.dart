import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:moneytory/login.dart';
// import 'package:moneytory/login.dart';
import 'package:moneytory/main_menu.dart';
// import 'package:moneytory/login.dart';
// import 'package:moneytory/main_menu.dart';
// import 'package:moneytory/history.dart';
// import 'package:moneytory/main_menu.dart';
// import 'package:moneytory/getstarted.dart';
// import 'package:moneytory/main_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(HexColor("#4D84FF"));
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MaterialApp(
          home: Login(),
          debugShowCheckedModeBanner: false,
        ));
  }
}
