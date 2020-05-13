import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:core';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/signIn.dart';
import 'package:pedometer/pedometer.dart';


// Do Google Map work here
class AGoogleMap extends StatefulWidget {
  AGoogleMap({Key key}) : super(key: key);

  _AGoogleMap createState() => _AGoogleMap();
}

class _AGoogleMap extends State<AGoogleMap> {
  GoogleMapController controller;
  Position curPosition;
  var geolocator = Geolocator();
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.best, distanceFilter: 1);
  var posLat;
  var posLong;
  StreamSubscription<Position> positionStream;
  CameraPosition curCam;
  Marker marker;

  var originLatitude = 0.0;
  var originLongitude = 0.0;
  var destLatitude;
  var destLongitude;
  String googleAPiKey = "AIzaSyDGfH2MCCY_swzUQL9ib8b9VrycXLK3oEM";
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  Pedometer pedometer;
  StreamSubscription<int> pedometerSub;
  String _stepCountValue = '?';
  String milesCount = "?";
  String caloriesCount = "?";

  @override
  void initState() {
    super.initState();
  }

  // adapted from https://medium.com/@atul.sharma_94062/how-to-use-cloud-firestore-with-flutter-e6f9e8821b27
  void _addData () async {
    final CollectionReference reference = Firestore.instance.collection("/WalkHistory");
    await reference
        .add({ //.add() will randomly generate document ID
      'UserID': userId,
      'User': name,
      'Steps': _stepCountValue,
      'Calories': caloriesCount,
      'Miles': milesCount,
      'Created': DateTime.now()
    });

    print(DateTime.now());
    _displaySnackBar(context, "Added Data to WalkHistory and Ended Walk");

  }

  Future<void> initPlatformState() async {
    startListening();
  }

  void startListening() {
    pedometer = new Pedometer();
    pedometerSub = pedometer.pedometerStream.listen(_onData, cancelOnError: true);
  }

  void startWalk() async {
    print("startWalk");
    initPlatformState();
    positionStream = geolocator.getPositionStream(locationOptions).listen(
            (Position aPosition) {
            curPosition = aPosition;
            if (controller != null) {
              controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(curPosition.latitude, curPosition.longitude),
                  tilt: 0,
                  zoom: 17)));
              // use zoom 17 or 18 for demo
              updateMarker(curPosition);
              updatePolyLines(curPosition);
            }
        });
    _displaySnackBar(context, "Starting Walk");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          SizedBox(
            height: 500,
            width: 400,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(37.43296265331129, -122.08832357078792),
                zoom: 15,
              ),
              markers: Set.of((marker != null) ? [marker] : []),
              polylines: Set<Polyline>.of(polylines.values),
              onMapCreated: (GoogleMapController aController) {
                controller = aController;
              },
            ),
          ),
          SizedBox(height:5),
          RaisedButton(
            onPressed: startWalk,
            child: Text("Start Walk"),
          ),
          RaisedButton(
            onPressed: dispose,
            child: Text("End Walk"),
          ),
          SizedBox(height:5),
          Text("$_stepCountValue" + " Steps taken"),
          Text("$caloriesCount" + " Calories Burned"),
          Text("$milesCount" + " Distance Traveled in Miles"),
          SizedBox(height:10),
          Text("Currently a bug where pedometer doesn't reset values at all unless I think the phone is restarted, so the steps just keep growing. Step counts also don't start during successive Start and End Walks. Replace the "
              "page to get counters to work again. Map does work for successive Start and End walks though. Step counter may be slow, so be patient with it."),
          SizedBox(height:400),
          Text("You reached the Bottom")
        ]
      )
    ),
  );
  }

  void updateMarker(Position newPosition) {

    setState(() {
      LatLng latLng = LatLng(newPosition.latitude, newPosition.longitude);
      marker = Marker(
        markerId: MarkerId("mark"),
        draggable: false,
        position: latLng,
        icon: BitmapDescriptor.defaultMarker,
      );
      print("NewMarker");
    });
  }

  void updatePolyLines(Position newPosition) async {
    if (originLatitude == 0.0 && originLongitude == 0.0) {
      originLatitude = newPosition.latitude;
      originLongitude = newPosition.longitude;
    }
    destLatitude = newPosition.latitude;
    destLongitude = newPosition.longitude;
    List<PointLatLng> result = await polylinePoints.getRouteBetweenCoordinates(googleAPiKey,
        originLatitude, originLongitude, destLatitude, destLongitude);

    if (result.isNotEmpty) {
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      PolylineId id = PolylineId("poly");
      Polyline polyline = Polyline (
        polylineId: id, color: Colors.blue, points: polylineCoordinates);
      polylines[id] = polyline;
    });
    print(result);
  }

  @override
  void dispose() {
    if (positionStream != null) {
      positionStream.cancel();
      if (controller != null) {
        controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(37.43296265331129, -122.08832357078792),
            tilt: 0,
            zoom: 15)));
      }
      _addData();
    }
    if(pedometerSub != null) {
      pedometerSub.cancel();
      setState(() {
        _stepCountValue = "?";
        caloriesCount = "?";
        milesCount = "?";
      });

    }
    super.dispose();
  }

  _displaySnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    _scaffoldKey.currentState.showSnackBar(snackBar);
  }

  void _onData(int stepValue) async {
    setState(() => _stepCountValue = "$stepValue");
    setState(() {
      caloriesCount = (stepValue.toDouble() * 0.04).toString();
      milesCount = (stepValue.toDouble() * 0.00047).toString();
    });
    print(_stepCountValue);
  }
}





