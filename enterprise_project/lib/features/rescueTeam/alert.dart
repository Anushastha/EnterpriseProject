import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:enterprise_project/features/rescueTeam/map.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

import '../../custom/theme.dart';

class AlertScreen extends StatefulWidget {
  @override
  State<AlertScreen> createState() => _AlertScreenState();
}

class _AlertScreenState extends State<AlertScreen> {
  late User _currentUser; //late = will be initialized later

  List<UserData> _registeredUsers = [];

  DatabaseReference? _databaseRef;

  int _numDevices = 0; // Number of devices from the Realtime Database

  bool isButtonPressed = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _getCurrentUser();

      _fetchRegisteredUsers();

      _fetchNumDevices(); // Fetch number of devices from Realtime Database

      print(_registeredUsers);
    });
  }

  Future<void> _getCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      setState(() {
        _currentUser = currentUser;
      });
    }
  }

//   Future<void> _fetchRegisteredUsers() async {

//   final QuerySnapshot snapshot = await FirebaseFirestore.instance

//       .collection('users')

//       .where('role', isEqualTo: 'User')

//       .get();

//   final List<UserData> users = snapshot.docs.map((doc) {

//     final data = doc.data() as Map<String, dynamic>;

//     final String firstName = data['firstName'] as String;

//     final String middleName = data['middleName'] as String;

//     final String lastName = data['lastName'] as String;

//     final String contactNo = doc.id;

//     final int bpm = data['BPM'] as int;

//     final int heartbeat = data['Heartbeat'] as int;

//     final double temperature = data['Temperature'] as double;

//     final double spo2 = data['SPO2'] as double;

//     final String name =

//         '$firstName ${middleName.isNotEmpty ? '$middleName ' : ''}$lastName';

//     return UserData(

//       name: name,

//       contactNo: contactNo,

//       heartbeat: heartbeat.toString(),

//       temperature: temperature.toString(),

//       spO2: spo2.toString(),

//     );

//   }).toList();

//   setState(() {

//     _registeredUsers = users;

//   });

// }

  Future<void> _fetchRegisteredUsers() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'User')
        .get();

    final List<UserData> users = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      final String firstName = data['firstName'] as String;

      final String middleName = data['middleName'] as String;

      final String lastName = data['lastName'] as String;

      final String contactNo = doc.id; // Using document ID as contactNo

      final String name =
          '$firstName ${middleName.isNotEmpty ? '$middleName ' : ''}$lastName';

      return UserData(
        name: name,
        contactNo: contactNo,
        heartbeat: data["Heartbeat  "],
        spO2: data["SP02"],
        temperature: data["Temperature"],
      );
    }).toList();

    print(_registeredUsers);

    setState(() {
      _registeredUsers = users;
    });
  }

  Future<void> _fetchNumDevices() async {
    _databaseRef = FirebaseDatabase.instance.reference();

    // Listen to the number of devices in the Realtime Database

    _databaseRef!.child('Devices').once().then((event) {
      final snapshot = event.snapshot;

      final data = snapshot.value;

      if (data != null) {
        setState(() {
          _numDevices = data as int;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_registeredUsers);

    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Rescue Alerts',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: CustomTheme.blue,
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_registeredUsers.isEmpty)
                    Column(
                      children: [
                        Icon(
                          Icons.notifications_off,
                          size: 80.0,
                          color: CustomTheme.red,
                        ),
                        Text(
                          'No alerts',
                          style: TextStyle(
                            fontSize: 25.0,
                            color: CustomTheme.red,
                          ),
                        ),
                      ],
                    ),
                  if (!isButtonPressed)
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isButtonPressed = true;
                        });
                      },
                      child: Text('Show Alerts'),
                    ),
                  if (isButtonPressed && _registeredUsers.isNotEmpty)
                    SizedBox(height: 20.0),
                  if (isButtonPressed && _registeredUsers.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _registeredUsers.length,
                        itemBuilder: (context, index) {
                          final user = _registeredUsers[index];

                          final bool isHighlighted = index == _numDevices;

                          return Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: isHighlighted
                                      ? CustomTheme.red
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(10.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2.0,
                                      blurRadius: 1.5,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0),
                                  tileColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  leading: CircleAvatar(
                                    radius: 25.0,
                                    backgroundColor: Colors.grey,
                                    backgroundImage: NetworkImage(
                                      'https://t4.ftcdn.net/jpg/05/50/60/55/360_F_550605549_PaTP81pjaCsrNTnfUaYlUZ8wmPpQSHY8.jpg',
                                    ),
                                  ),
                                  title: Text(
                                    user.name.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                      color: isHighlighted
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        user.contactNo.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: isHighlighted
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        user.heartbeat.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: isHighlighted
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        user.spO2.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: isHighlighted
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        user.temperature.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.0,
                                          color: isHighlighted
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      if (isHighlighted)
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    RescueMapScreen(),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.location_on),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.0),
                            ],
                          );
                        },
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserData {
  final String? name;

  final String? contactNo;

  final num? heartbeat;

  final num? temperature;

  final num? spO2;

  UserData({
    required this.name,
    required this.contactNo,
    required this.heartbeat,
    required this.temperature,
    required this.spO2,
  });
}
