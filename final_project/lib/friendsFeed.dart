import 'package:flutter/material.dart';
import 'package:final_project/drawer.dart';
import 'package:final_project/addFriend.dart';
import 'package:final_project/friendHistory.dart';

class FriendsFeed extends StatefulWidget {
  FriendsFeed({Key key}) : super(key: key);

  _FriendsFeed createState() => _FriendsFeed();
}

class _FriendsFeed extends State<FriendsFeed> {
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
          title: Text("Friends Feed"),
          centerTitle: true,
        ),
        drawer: OurDrawer(),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            FriendHistory(),
            AddFriend(),
          ],
        )
    );
  }
}