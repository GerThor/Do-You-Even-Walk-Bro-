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
        body: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Text("Welcome to the Do You Even Walk Bro? app. To get started head over to the Profile page to fill out "
              "your profile. Next head over to the StartWalk page to begin walking and making or losing gains today! View "
              "your most recent 20 walk results in the WalkHistory page, or add friends and see their recent walks in the "
              "Friends Feed page.")
        ]
        )
    );
  }
}