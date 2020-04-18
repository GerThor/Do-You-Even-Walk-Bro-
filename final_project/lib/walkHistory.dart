import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_project/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/signIn.dart';

class WalkHistory extends StatefulWidget {
  WalkHistory({Key key}) : super(key: key);

  _WalkHistory createState() => _WalkHistory();
}

class _WalkHistory extends State<WalkHistory> {
  Stream<QuerySnapshot> _query =
  Firestore.instance.collection('WalkHistory')
      .where('User', isEqualTo: user_id)
      .orderBy('Created', descending: true)
      //.endAt(values)
      .snapshots();
  void _addData () async {
//    Firestore.instance.runTransaction((transaction) async {
//      DocumentSnapshot freshSnap = await Firestore.instance.collection('test').document('MOGqdOb5xVvLPQXP8FIt').get();
//      await transaction.update(freshSnap.reference, {
//        'aString': _awesomest,
//      });
//    });
//    String test = "test";

    // adapted from https://medium.com/@atul.sharma_94062/how-to-use-cloud-firestore-with-flutter-e6f9e8821b27
    final CollectionReference reference = Firestore.instance.collection("/WalkHistory");
    await reference // DYEWB Collection ID for final project
        .add({ //.add() will randomly generate document ID
      'User': user_id,
      'Steps': '413',
      'Calories': '5151',
      'Miles': '4161',
      'Created': DateTime.now()
    });

    print(DateTime.now());

  }

  @override
  initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Walk History"),
        centerTitle: true,
      ),
      drawer: OurDrawer(),
      body: Center(
        child:Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Text("Just some filler text for Walk History Page."),
            RaisedButton(
              onPressed: _addData,
              child: Text("Test Add Data"),
            ),
              StreamBuilder(
              stream: _query,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text(
                  'Loading Clicks...',
                  style: TextStyle(color: Colors.white),
                );
                return Text(
                  "You are " + snapshot.data.documents[0].toString(),
                  style: TextStyle(color: Colors.white),
                );
              }
            ),
          ]
        )
      )
    );
  }
}