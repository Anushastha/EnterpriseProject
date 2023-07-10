// import 'package:flutter/material.dart';
// import '../../custom/theme.dart';
// import 'editProfile.dart';
//
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Center(
//             child: Text(
//               'Rescue Team Dashboard',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: CustomTheme.blue,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Align(
//               alignment: Alignment.topRight,
//               child: IconButton(
//                 icon: Icon(
//                   Icons.edit,
//                   color: CustomTheme.blue,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => EditProfileScreen()),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: CircleAvatar(
//               radius: 50.0,
//               backgroundColor: Colors.grey,
//               backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPEZReC1Pu5YrUBFjENhqQNFsI2crcnfBdIw&usqp=CAU'),
//             ),
//           ),
//           Card(
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     'Name',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                       'Jason Rai',
//                     style: TextStyle(
//                       color: CustomTheme.lightText,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Card(
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     'Email',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     'jason.rai@example.com',
//                     style: TextStyle(
//                       color: CustomTheme.lightText,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Card(
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     'Phone',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                       '9841568095',
//                     style: TextStyle(
//                       color: CustomTheme.lightText,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Card(
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     'Gender',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text('Male'),
//                 ),
//               ],
//             ),
//           ),
//           Card(
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     'Rescue Department',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                       'Search and Rescue Team',
//                     style: TextStyle(
//                       color: CustomTheme.lightText,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom/theme.dart';
// import 'editProfile.dart';

class ProfileScreen extends StatefulWidget {
  final String name;
  final String email;
  final String contactNo;
  final String address;
  final String image;

  const ProfileScreen({
    Key? key,
    required this.name,
    required this.email,
    required this.contactNo,
    required this.address,
    required this.image,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  //when logged in, this screen comes first
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
                  '${widget.name}',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),

              SizedBox(height: 20.0),
              Center(
                child: Text(
                  '${widget.email}',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  '${widget.contactNo}',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  '${widget.address}',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Joined: August, 2022',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Spacer(), // Adds spacer widget to push the text to the bottom
              Center(
                child: Text(
                  'Search and Rescue Department',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomTheme.textColor,
                    fontSize: 20,
                  ),
                ),
              ),
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
  final String email;
  final String contactNo;
  final String address;

  UserData({
    required this.name,
    required this.email,
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
  var emailPass;
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
      final String address = data['address'] as String;
      // final String email = data['email'] as String;
      return UserData(
        name: name,
        contactNo: contactNo,
        address: address,
        email: 'emailStatic',
      );
    }).toList();

    for (var i in users) {
      if (i.contactNo == contact) {
        contactNoPass = i.contactNo;
        namePass = i.name;
        addressPass = i.address;
        emailPass = i.email;
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
      final String address = data['address'] as String;
      final String name = '$firstName $lastName';
      return UserData(
        name: name,
        contactNo: contactNo,
        address: address,
        email: 'emailStaic',
      );
    }).toList();

    setState(() {
      _registeredUsers = users;
    });
  }

  @override
  // ignore: dead_code
  Widget build(BuildContext context) {
    var name = namePass;
    var email = emailPass;
    var contactNo = contactNoPass;
    var address = addressPass;
    if (_currentUser == null) {
      // Handle the case when _currentUser is null
      name = name; // or provide a default value for the name
      email = email;
      contactNo = contactNo;
      address = address; // or provide a default value for the contactNo
    }

    return ProfileScreen(
      name: name,
      email: email,
      contactNo: contactNo,
      address: address,
      image: 'https://example.com/profile-image.jpg',
    );
  }
}
