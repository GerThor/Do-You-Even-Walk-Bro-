import 'package:flutter/material.dart';
import 'package:final_project/homePage.dart';
import 'package:final_project/login.dart';
import 'package:final_project/profile.dart';
import 'package:final_project/startWalk.dart';
import 'package:final_project/walkHistory.dart';
import 'package:final_project/friendsFeed.dart';

//might add more pages such as startWalkStats page, and addFriends page haven't figured it out yet.

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Final Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/homePage': (context) => HomePageScreen(),
        '/profile': (context) => ProfileScreen(),
        '/startWalk': (context) => StartWalk(),
        '/walkHistory': (context) => WalkHistory(),
        '/friendsFeed': (context) => FriendsFeed(),
      },
    );
  }
}