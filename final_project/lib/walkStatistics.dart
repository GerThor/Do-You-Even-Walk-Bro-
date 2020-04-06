import 'package:flutter/material.dart';
// This file is connected to the StartWalk Page when you Swipe Left and go to the right of the Google Maps Page.
// Do walk statistics here, Steps Taken, Distance Traveled, Calories burnt, etc.

walkStats() {
  return Container( // Modify starting here however you want, I put a Container but you can change it, definitely get rid of "child: Center()" and "child: Text()" though.
      child: Center(
        child: Text("Put Walk Statistics Here, Steps Taken, Distance,\n"
            "Calories, etc. Swipe Right to go back to Google Map"),
      )
  );
}