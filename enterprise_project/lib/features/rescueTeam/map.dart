import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';

class RescueMapScreen extends StatefulWidget {
  @override
  _RescueMapScreenState createState() => _RescueMapScreenState();
}

class _RescueMapScreenState extends State<RescueMapScreen> {
  DatabaseReference? _databaseRef;
  double? latitude;
  double? longitude;
  List<Map<String, dynamic>> sensorData = [];
  GoogleMapController? _mapController;
  Set<Marker> markers = {};

  @override
  void initState() {
    super.initState();
    initializeFirebase();
  }

  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
    _databaseRef = FirebaseDatabase.instance.reference();

    // Listen to latitude and longitude changes
    _databaseRef!.child('Latitude').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          latitude = double.parse(data.toString());
          addToSensorData();
        });
      }
    });

    _databaseRef!.child('Longitude').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          longitude = double.parse(data.toString());
          addToSensorData();
        });
      }
    });
  }

  void addToSensorData() {
    if (latitude != null && longitude != null) {
      sensorData.add({
        'latitude': latitude,
        'longitude': longitude,
      });
    }
  }

  void showNotification(String? title, String? body) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? ''),
        content: Text(body ?? ''),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    if (latitude != null && longitude != null) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(
          LatLng(latitude!, longitude!),
          15.0,
        ),
      );
    }
  }

  void zoomInOnMarker(MarkerId markerId) {
    final marker = markers.firstWhere((marker) => marker.markerId == markerId);
    if (marker != null) {
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(marker.position, 16.0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (latitude != null && longitude != null) {
      final marker1 = Marker(
        markerId: MarkerId('currentLocation'),
        position: LatLng(latitude!, longitude!),
        icon: BitmapDescriptor.defaultMarker,
        onTap: () => zoomInOnMarker(MarkerId('currentLocation')),
      );
      markers = {
        marker1,
      };
      _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(marker1.position, 16.0),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Latitude: ${latitude ?? 'N/A'}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Longitude: ${longitude ?? 'N/A'}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude ?? 0.0, longitude ?? 0.0),
          zoom: 15.0,
        ),
        markers: markers,
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
//
// class MapScreen extends StatefulWidget {
//   const MapScreen({Key? key}) : super(key: key);
//
//   @override
//   State<MapScreen> createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   DatabaseReference _databaseRef = FirebaseDatabase.instance.reference();
//   double? latitude;
//   double? longitude;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchDataFromDatabase();
//   }
//
//   Future<void> fetchDataFromDatabase() async {
//     DataSnapshot dataSnapshot = (await _databaseRef.once()) as DataSnapshot;
//
//     // Access the retrieved data
//     Map<dynamic, dynamic>? data = dataSnapshot.value as Map<dynamic, dynamic>?;
//     if (data != null) {
//       setState(() {
//         latitude = data['Latitude']?.toDouble();
//         longitude = data['Longitude']?.toDouble();
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Map Screen'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Latitude: ${latitude ?? 'N/A'}'),
//             Text('Longitude: ${longitude ?? 'N/A'}'),
//           ],
//         ),
//       ),
//     );
//   }
// }
