import 'package:flutter/material.dart';
import 'package:final_project/drawer.dart';

class WalkHistory extends StatefulWidget {
  WalkHistory({Key key}) : super(key: key);

  _WalkHistory createState() => _WalkHistory();
}

class _WalkHistory extends State<WalkHistory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Walk History"),
        centerTitle: true,
      ),
      drawer: OurDrawer(),
      body: Center(
          child: Text("Just some filler text for Walk History Page.")
      )
    );
  }
}