import 'package:flutter/material.dart';
import 'package:final_project/signIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreen createState() => _LoginScreen();
}


class _LoginScreen extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Do You Even Walk Bro?"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                signInWithGoogle().whenComplete(() {
                  if (userId != null) {
                    Navigator.pushNamed(context, '/homePage');
                    createProfile();
                  }
                });
              },
              child: Text("Google Login"),
            )
          //_signInButton(context),
          ],
        )
      )
    );
  }

  Future createProfile() async {
    final QuerySnapshot query = await Firestore.instance.collection('/Profiles')
        .where('UserID', isEqualTo: userId)
        .getDocuments();
    if (query.documents.length > 0) {
      return;
    } else {
      final CollectionReference reference = Firestore.instance.collection(
          "/Profiles");
      await reference
          .add({ //.add() will randomly generate document ID
        'UserID': userId,
        'User': name,
        'Friends': []
      });
    }
  }

}
