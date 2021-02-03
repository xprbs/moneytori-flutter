import 'package:flutter/material.dart';
// import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class History extends StatefulWidget {
  History({Key key}) : super(key: key);

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(length: 3, vsync: this);
    //tambahkan SingleTickerProviderStateMikin pada class _HomeState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Container(
            // padding: EdgeInsets.only(top: 10),
            child: Column(children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(top: 20, left: 40),
                child: Image.asset(
                  "images/logo.png",
                  width: 95,
                ),
              )
            ],
          ),
        ])));
  }
}
