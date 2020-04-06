import 'package:flutter/material.dart';
import 'package:final_project/drawer.dart';

class FriendsFeed extends StatefulWidget {
  FriendsFeed({Key key}) : super(key: key);

  _FriendsFeed createState() => _FriendsFeed();
}

class _FriendsFeed extends State<FriendsFeed> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friends Feed"),
        centerTitle: true,
      ),
      drawer: OurDrawer(),
      body: Center(
          child: Text("Just some filler text for Friends Feed Page.")
      )
    );
  }
}