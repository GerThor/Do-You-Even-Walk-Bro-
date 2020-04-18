import 'package:flutter/material.dart';
// This file is connected to the StartWalk Page when you Swipe Left and go to the right of the Google Maps Page.
// Do walk statistics here, Steps Taken, Distance Traveled, Calories burnt, etc.




//Anonymous Version
//walkStats() {
//  return Container( // Modify starting here however you want, I put a Container but you can change it, definitely get rid of "child: Center()" and "child: Text()" though.
//      child: Center(
//        child: Text("Put Walk Statistics Here, Steps Taken, Distance,\n"
//            "Calories, etc. Swipe Right to go back to Google Map"),
//      )
//  );
//}

//Class Version

class WalkStats extends StatefulWidget {
  WalkStats({Key key}) : super(key: key);

  _WalkStats createState() => _WalkStats();
}

class _WalkStats extends State<WalkStats> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Put Walk Stats here.")
          ],
        )
      ),
    );
  }
}

