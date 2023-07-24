import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom/theme.dart';

class ProfileScreen extends StatefulWidget {
  final String? name;
  final String? contactNo;
  final String? address;
  final String? dob;
  final String? image;

  const ProfileScreen({
    Key? key,
    required this.name,
    required this.dob,
    required this.contactNo,
    required this.address,
    required this.image,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? _formattedDOB;

  @override
  void initState() {
    super.initState();
    _formattedDOB = _formatDOB(widget.dob);
  }

  String _formatDOB(String? dob) {
    if (dob == null || dob.isEmpty) return '';
    final Timestamp timestamp =
        Timestamp.fromMillisecondsSinceEpoch(int.parse(dob));
    final DateTime dateTime = timestamp.toDate();
    final String formattedDate =
        '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Rescue Team ID',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: CustomTheme.blue,
                ),
              ),
              SizedBox(height: 50.0),
              Center(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPEZReC1Pu5YrUBFjENhqQNFsI2crcnfBdIw&usqp=CAU'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Center(
                child: Text(
                  '${widget.name.toString()}',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  '${widget.contactNo.toString()}',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  '${widget.address.toString()}',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'DOB: $_formattedDOB',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              SizedBox(height: 10.0),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class UserData {
  final String name;
  final String contactNo;
  final String address;
  final String dob;

  UserData({
    required this.name,
    required this.dob,
    required this.contactNo,
    required this.address,
  });
}

class Profile extends StatefulWidget {
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User? _currentUser;
  List<UserData> _registeredUsers = [];
  var contact;
  var contactNoPass;
  var namePass;
  var dobPass;
  var addressPass;

  @override
  void didChangeDependencies() {
    contact = ModalRoute.of(context)!.settings.arguments as String?;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _getCurrentUser();
    _fetchRegisteredUsers();
  }

  Future<void> _getCurrentUser() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'Rescue')
        .get();

    final List<UserData> users = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final String firstName = data['firstName'] as String;
      final String lastName = data['lastName'] as String;
      final String contactNo = data['contactNo'].toString();
      final String name = '$firstName $lastName';
      final String dob = data['dob'].toString();
      final String address = data['address'] as String;
      return UserData(
        name: name,
        contactNo: contactNo,
        address: address,
        dob: dob,
      );
    }).toList();

    for (var i in users) {
      if (i.contactNo == contact) {
        contactNoPass = i.contactNo;
        namePass = i.name;
        addressPass = i.address;
        dobPass = i.dob;
      }
      setState(() {});
    }
  }

  Future<void> _fetchRegisteredUsers() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'Rescue')
        .get();

    final List<UserData> users = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final String firstName = data['firstName'] as String;
      final String lastName = data['lastName'] as String;
      final String contactNo = data['contactNo'].toString();
      final String dob = data['dob'].toString();
      final String address = data['address'] as String;
      final String name = '$firstName $lastName';
      return UserData(
        name: name,
        contactNo: contactNo,
        address: address,
        dob: dob,
      );
    }).toList();

    setState(() {
      _registeredUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    var name = namePass;
    var dob = dobPass;
    var contactNo = contactNoPass;
    var address = addressPass;

    if (_currentUser == null) {
      // Handle the case when _currentUser is null
      name = name; // or provide a default value for the name
      contactNo = contactNo;
      address = address;
      dob = dob; // or provide a default value for the contactNo
    }

    return ProfileScreen(
      name: name,
      dob: dob,
      contactNo: contactNo,
      address: address,
      image: 'https://example.com/profile-image.jpg',
    );
  }
}
