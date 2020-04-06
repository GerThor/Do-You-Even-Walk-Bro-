import 'package:flutter/material.dart';
import 'package:final_project/drawer.dart';

class HomePageScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          centerTitle: true,
        ),
        drawer: OurDrawer(),
        body: Center(
          child: Text("Just some filler text for HomePage.")
        )
    );
  }
}