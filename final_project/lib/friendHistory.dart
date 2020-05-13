import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendHistory extends StatefulWidget {
  FriendHistory({Key key}) : super(key: key);

  _FriendHistory createState() => _FriendHistory();
}

class _FriendHistory extends State<FriendHistory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child:Column(
              children: <Widget>[
                Text("Swipe the page to head right and add a friend on the next page."),
                SizedBox(height:20),
              ],
            ),
          ),
        )
    );
  }
}