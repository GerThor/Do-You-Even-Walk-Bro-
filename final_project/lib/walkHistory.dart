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
        .limit(20)
        .snapshots();

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
      body: SingleChildScrollView(
        child: Center(
          child:Column(
            children: <Widget> [
              Text("Add data to this page by starting a walk and ending a walk on the StartWalk page. "
                  "You will receive a snackbar notification when you successfully end a walk and add data to this page. "
                  "List is scrollable, limited to 20 as project deliverable. There is a bug where two data sets are added, and one data set is when "
                  "I have reset values to a question mark, even though I only call my add function once."),
              SizedBox(height:20),
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
        ),
      )
    );
  }
}


  printHistory(snapshot) {
  int length = snapshot.data.documents.length - 1;
  print(length);
  List<String> aList = [];
  for (int index = 0; index <= length; index++) {
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

