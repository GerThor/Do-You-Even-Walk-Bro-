import 'package:flutter/material.dart';
import 'package:final_project/signIn.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  _LoginScreen createState() => _LoginScreen();
}


class _LoginScreen extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                signInWithGoogle().whenComplete(() {
                  Navigator.pushNamed(context, '/homePage');
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
}
