//import 'package:final_project/startWalk.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:core';




// Do Google Map work here

//Anonymous Version
//googleMap() {
//  return Scaffold(
//    body: SingleChildScrollView(
//        child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget> [
//              SizedBox(
//                height:500,
//                width: 400,
//                child: GoogleMap(
//                  mapType: MapType.normal,
//                  initialCameraPosition: CameraPosition(
//                    target: LatLng(40.688841, -74.044015),
//                    zoom: 15,
//                  ),
//                ),
//              ),
//
//              SizedBox(height:5),
//              RaisedButton(
//                onPressed: (){},
//                child: Text("Start Walk"),
//              )
//            ]
//        )
//    ),
//  );
//}

//Class Version

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

  @override
  void initState() {
    super.initState();
  }

  void startWalk() async {
    print("startWalk");
    positionStream = geolocator.getPositionStream(locationOptions).listen(
            (Position aPosition) {
            curPosition = aPosition;
//            posLat = double.parse(curPosition.latitude.toString());
//            posLong = double.parse(curPosition.longitude.toString());
//            curCam = CameraPosition(
//                target: LatLng(posLong, posLong),
//                zoom: 15
//            );
            if (controller != null) {
              controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
                  target: LatLng(curPosition.latitude, curPosition.longitude),
                  tilt: 0,
                  zoom: 15)));
              updateMarker(curPosition);
              print(curPosition == null ? 'Unknown' : curPosition.latitude.toString() +
                  ', ' + curPosition.longitude.toString());
            }
            //getLocation();
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
            child: Text("Cancel Subscr"),
          ),
          SizedBox(height:2000),
          Text("You reached Bottom")
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
      LatLng latlng = LatLng(newPosition.latitude, newPosition.longitude);
      marker = Marker(
        markerId: MarkerId("mark"),
        draggable: false,
        position: latlng,
        //flat: true,
        icon: BitmapDescriptor.defaultMarker,
      );
      print("NewMarker");
    });
  }

  @override
  void dispose() {
    if (positionStream != null) {
      positionStream.cancel();
    }
    super.dispose();
  }

}





