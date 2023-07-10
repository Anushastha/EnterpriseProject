import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference();

  Completer<GoogleMapController> _googleMapController =
      Completer<GoogleMapController>();
  final markerId = MarkerId("Current Location");
  Map<MarkerId, Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _markers[markerId] = Marker(
      markerId: markerId,
      position: _initialLocation,
    );
    initialCurrentLocation();
  }

  initialCurrentLocation() async {
    final _controller = await _googleMapController.future;
    final _result = await Permission.location.request();
    if (_result.isGranted) {
      final _currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      final _altitude = _currentLocation.altitude;
      print("Current altitude : $_altitude");
      final _currentLoc =
          LatLng(_currentLocation.latitude, _currentLocation.longitude);
      _markers[markerId] = Marker(
        markerId: markerId,
        position: _currentLoc,
      );

      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _currentLoc,
            zoom: 15,
          ),
        ),
      );

      // send loacation to databse
      sendLocation(_currentLocation.latitude, _currentLocation.longitude,
          _currentLocation.altitude);
      setState(() {});
    }
  }

  void sendLocation(double latitude, double longitude, double altitude) {
    _databaseReference.update({
      'Latitude': latitude,
      'Longitude': longitude,
      'Altitude': altitude,
    }).then((value) {
      print("sent successfully");
      print("Latitide $latitude");
      print("Longitude $longitude");
      print("altitude $altitude");
    }).catchError((error) {
      print("Failed to send location");
    });
  }

  final _initialLocation = LatLng(27.7172, 85.3240);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _initialLocation,
          zoom: 15,
        ),
        markers: _markers.values.toSet(),
        onMapCreated: (controller) {
          _googleMapController.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {},
        child: Icon(Icons.navigation_outlined),
      ),
    );
  }
}
