import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// Do Google Map work here

googleMap() {
  return Scaffold(
    body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget> [
          SizedBox(
            height:500,
            width: 400,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(40.688841, -74.044015),
                zoom: 15,
              ),
            ),
          ),

          SizedBox(height:5),
          RaisedButton(
            onPressed: (){},
            child: Text("Start Walk"),
          )
        ]
      )
    ),
  );
}