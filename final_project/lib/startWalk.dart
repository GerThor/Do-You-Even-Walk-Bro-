import 'package:flutter/material.dart';
import 'package:final_project/googleMap.dart';
import 'package:final_project/walkStatistics.dart';
import 'package:final_project/drawer.dart';

class StartWalk extends StatefulWidget {
  StartWalk({Key key}) : super(key: key);

  _StartWalk createState() => _StartWalk();
}

//Page Controller adapted from (see README.md, Works Cited 2.)

class _StartWalk extends State<StartWalk> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Start Walk"),
          centerTitle: true,
        ),
        drawer: OurDrawer(),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            AGoogleMap(), // see file googleMap.dart //AGoogleMap for Class version
            WalkStats(), // see file walkStatistics.dart //WalkStats for Class Version
          ],
        )
    );
  }
}
