import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/signIn.dart';

class AddFriend extends StatefulWidget {
  AddFriend({Key key}) : super(key: key);

  _AddFriend createState() => _AddFriend();
}

class _AddFriend extends State<AddFriend> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Stream<QuerySnapshot> profilesQuery = Firestore.instance.collection('Profiles').snapshots();

  void _isInputText(String value) async {
    final CollectionReference reference = Firestore.instance.collection("/Profiles").where('UserID', isEqualTo: userId);
    await reference
        .add({
      'Friends': FieldValue.arrayUnion([value]),
    });

  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {

      });
      return true;
    }
    return false;
  }

  String validate(String value) {
    if(value.isEmpty){
      _displaySnackBar(context, "Invalid Submission");
      return 'Field can\'t be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Text("Add a Friend on this Page from the list of given users below, must be exactly case specific."),
                //SizedBox(height:10),
                Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: buildInputs() + buildSubmitButtons()
                    )
                ),
                Text("All Users"),
                StreamBuilder(
                    stream: profilesQuery,
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
                      return printUsers(snapshot);
                    }
                ),
              ]
            ),
          )
        )
    );
  }

  _displaySnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      _displaySnackBar(context, "Adding Friend");
    }
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        key: Key('string'),
        decoration: InputDecoration(labelText: '(Enter a Valid User Name to Add a Friend)'),
        validator: validate,
        onSaved: _isInputText,
        //onSaved: (value) => _someString = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    return [
      RaisedButton(
        key: Key('submit'),
        child: Text('Submit'),
        onPressed: validateAndSubmit,
      ),];
  }

  printUsers(snapshot) {
    int length = snapshot.data.documents.length - 1;
    print(length);
    List<String> aList = [];
    for (int index = 0; index <= length; index++) {
      if (snapshot.data.documents[index] != null) {
//        String indexNum = (index+1).toString();
//        String aSteps = snapshot.data.documents[index]['Steps'].toString();
//        String aMiles = snapshot.data.documents[index]['Miles'].toString();
//        String aCalories = snapshot.data.documents[index]['Calories'].toString();
        String entireString = snapshot.data.documents[index]['User'];
        aList.add(entireString);
      }
    }
    return SizedBox(
      height: 400.0,
      child: ListView.builder(
          itemCount: aList.length,
          itemBuilder: (BuildContext ctxt, int i) {
            return new Text(aList[i]);
          }),
    );
  }

}
