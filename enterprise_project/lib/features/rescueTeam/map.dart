import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class RescueMapScreen extends StatefulWidget {
  @override
  _RescueMapScreenState createState() => _RescueMapScreenState();
}

class _RescueMapScreenState extends State<RescueMapScreen> {
  DatabaseReference? _databaseRef;
  double? latitude;
  double? longitude;
  List<Map<String, dynamic>> sensorData = [];


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
          sensorData.add({
            'timestamp': DateTime.now(),
            'latitude': latitude,
          });
        });
      }
    });

    _databaseRef!.child('Longitude').onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null) {
        setState(() {
          longitude = double.parse(data.toString());
          sensorData.add({
            'timestamp': DateTime.now(),
            'longitude': longitude,
          });
        });
      }
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Latitude: ${latitude ?? 'N/A'}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Longitude: ${longitude ?? 'N/A'}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'History',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Card(
                elevation: 4,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: 20,
                    headingRowHeight: 40,
                    dataRowHeight: 56,
                    horizontalMargin: 12,
                    headingTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    dataTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                    columns: [
                      DataColumn(label: Text('Timestamp')),
                      DataColumn(label: Text('Latitude')),
                      DataColumn(label: Text('Longitude')),
                    ],
                    rows: sensorData
                        .map(
                          (data) => DataRow(
                        cells: [
                          DataCell(
                            Text(data['timestamp'].toString()),
                          ),
                          DataCell(
                            Text(
                              '${data['latitude'] ?? 'N/A'}',
                            ),
                          ),
                          DataCell(
                            Text(
                              '${data['longitude'] ?? 'N/A'}',
                            ),
                          ),
                        ],
                      ),
                    )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
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
