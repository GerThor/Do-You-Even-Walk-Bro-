import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_project/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/signIn.dart';
import 'package:time_formatter/time_formatter.dart';

class WalkHistory extends StatefulWidget {
  WalkHistory({Key key}) : super(key: key);

  _WalkHistory createState() => _WalkHistory();
}

class _WalkHistory extends State<WalkHistory> {
  List<String> history = [];
  Stream<QuerySnapshot> query = Firestore.instance.collection('WalkHistory')
        .where('UserID', isEqualTo: userId)
        .orderBy('Created', descending: true)
        .limit(10)
        .snapshots();


  // adapted from https://medium.com/@atul.sharma_94062/how-to-use-cloud-firestore-with-flutter-e6f9e8821b27
  void _addData () async {
    final CollectionReference reference = Firestore.instance.collection("/WalkHistory");
    await reference // DYEWB Collection ID for final project
        .add({ //.add() will randomly generate document ID
      'UserID': userId,
      'User': name,
      'Steps': '121212',
      'Calories': '5361',
      'Miles': '20',
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
              child: Text("Add Data"),
            ),
              StreamBuilder(
              stream: query,
              builder: (context, snapshot) {
                if (!snapshot.hasData) return Text(
                  'Loading Clicks...',
                  style: TextStyle(color: Colors.white),
                );
                if (snapshot.hasError) {
                  print("SNAPSHOT ERROR");
                }
                if (snapshot.hasData) {
                  print("SNAPSHOT HAS DATA");
                }
                return printHistory(snapshot);
              }
            ),
          ]
        )
      )
    );
  }
}

  printHistory(snapshot) {
  List<String> aList = [];
  for (int index = 0; index <= 9; index++) {
    if (snapshot.data.documents[index] != null) {
      int timeStamp = snapshot.data.documents[index]['Created']
          .toDate()
          .millisecondsSinceEpoch;
      String indexNum = (index+1).toString();
      String aTime = formatTime(timeStamp);
      String aSteps = snapshot.data.documents[index]['Steps'].toString();
      String aMiles = snapshot.data.documents[index]['Miles'].toString();
      String aCalories = snapshot.data.documents[index]['Calories'].toString();
      String entireString = indexNum + ") " + name + " walked " +
          aSteps + " steps, " + "for " + aMiles + " miles, " + "and \nburned " +
          aCalories + " calories, " + aTime;
      aList.add(entireString);
    }
  }
  return SizedBox(
    height: 400.0,
    child: ListView.builder (
        itemCount: aList.length,
        itemBuilder: (BuildContext ctxt, int i) {
      return new Text(aList[i]);
    }),
  );
  }