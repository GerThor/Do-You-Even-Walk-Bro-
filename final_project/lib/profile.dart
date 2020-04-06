import 'package:flutter/material.dart';
import 'package:final_project/drawer.dart';

// Do your work here, if you need help reading some of this or where to start working, text me.

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Profile"),
          centerTitle: true,
        ),
        drawer: OurDrawer(),
        body: Center(
            child: Text("Just some filler text for Profile Page.")
        )
    );
  }
}