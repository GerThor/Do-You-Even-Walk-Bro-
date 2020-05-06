//import 'package:final_project/startWalk.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:core';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';




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


  @override
  void initState() {
    super.initState();
  }

  void startWalk() async {
    print("startWalk");
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

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          SizedBox(height:400),
          Text("You reached the Bottom")
        ]
      )
    ),
  );
  }



//  Future<void> updateLocation(CameraPosition newCam, Position newPosition) async {
//    final GoogleMapController aController = await controller.future;
//    var newLat = double.parse(newPosition.latitude.toString());
//    var newLong = double.parse(newPosition.longitude.toString());
//    setState(() {
//      aController.animateCamera(CameraUpdate.newCameraPosition(newCam));
//      marker = Marker(
//        markerId: MarkerId("mark"),
//        draggable: false,
//        position: LatLng(newLat, newLong),
//        //flat: true,
//        icon: BitmapDescriptor.defaultMarker,
//      );
//    });
//  }

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

        // insert miles, steps, calories into firebase
      }
    }
    super.dispose();
  }

}





