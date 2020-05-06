import 'package:flutter/material.dart';
import 'package:final_project/signIn.dart';

class OurDrawer extends StatefulWidget {
  OurDrawer({Key key}) : super(key: key);

  _OurDrawer createState() => _OurDrawer();
}

class _OurDrawer extends State<OurDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text("Do You Even Walk Bro?"),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text("HomePage"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/homePage');
            },
          ),
          ListTile(
            title: Text("Profile"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/profile');
            },
          ),
          ListTile(
            title: Text("StartWalk"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/startWalk'); // this might break you stuff when doing the actual walk, so test and change if needed
            },
          ),
          ListTile(
            title: Text("Walk History"),
            onTap: () {
              print(userId);
              print(name); // just testing that I can access a username
              Navigator.pushReplacementNamed(context, '/walkHistory');
            },
          ),
          ListTile(
            title: Text("Friends Feed"),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/friendsFeed');
            },
          ),
          ListTile(
            title: Text("Logout"),
            onTap: () {
              // Line below adapted from (see README.MD, Works Cited 1.)
              signOutGoogle();
              Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
            },
          ),
        ],
      )
    );
  }
}