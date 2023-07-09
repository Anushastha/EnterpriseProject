import 'package:flutter/material.dart';
import 'package:enterprise_project/custom/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'addTeam.dart';

class TeamScreen extends StatefulWidget {
  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  late User _currentUser;
  List<UserData> _registeredUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchRegisteredUsers();
    //_getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    _currentUser = FirebaseAuth.instance.currentUser!;
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
      final String name = '$firstName $lastName';
      return UserData(
        name: name,
        contactNo: contactNo,
      );
    }).toList();

    setState(() {
      _registeredUsers = users;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 40.0),
                      child: Text(
                        'Team',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: CustomTheme.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: CustomTheme.blue,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTeam()),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _registeredUsers.length,
              itemBuilder: (context, index) {
                final user = _registeredUsers[index];
                return CardItem(
                  name: user.name,
                  contactNo: user.contactNo,
                  image:
                      'https://hoopshype.com/wp-content/uploads/sites/92/2021/12/i_33_11_09_jayson-tatum.png?w=1000&h=600&crop=1',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String name;
  final String contactNo;
  final String image;

  const CardItem({
    Key? key,
    required this.name,
    required this.contactNo,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Team Member Details'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(image),
                    ),
                    SizedBox(height: 16.0),
                    Text('Name: $name'),
                    SizedBox(height: 8.0),
                    Text('Contact No: $contactNo'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(image),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          contactNo,
          style: TextStyle(
            color: CustomTheme.lightText,
          ),
        ),
      ),
    );
  }
}

class UserData {
  final String name;
  final String contactNo;

  UserData({
    required this.name,
    required this.contactNo,
  });
}
