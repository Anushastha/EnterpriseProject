import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../custom/theme.dart';

class AddTeam extends StatefulWidget {
  const AddTeam({Key? key}) : super(key: key);

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  XFile? image;
  final ImagePicker picker = ImagePicker();
  final form = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController rescueDepartmentController = TextEditingController();
  String? _errorMessage;

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
    });
  }

  Future<void> _saveProfile() async {
    try {
      // Initialize Firebase (if not already initialized)
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }

      // Get a reference to the Firestore collection
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('users');

      // Create a new user document
      DocumentReference newUserRef = await usersCollection.add({
        'name': nameController.text,
        'email': emailController.text,
        'phone': phoneNumberController.text,
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('User created successfully'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to create user';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('Add members'),
        backgroundColor: CustomTheme.backgroundColor,
        foregroundColor: CustomTheme.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.0),
              Center(
                child: CircleAvatar(
                  radius: 80.0,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      image != null ? FileImage(File(image!.path)) : null,
                ),
              ),
              SizedBox(height: 10.0),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  getImage(ImageSource.gallery);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt,
                      color: CustomTheme.blue,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Add Photo',
                      style: TextStyle(
                        color: CustomTheme.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30.0),
              Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        floatingLabelStyle: TextStyle(
                          color: CustomTheme.blue,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        floatingLabelStyle: TextStyle(
                          color: CustomTheme.blue,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter an email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: phoneNumberController,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        floatingLabelStyle: TextStyle(
                          color: CustomTheme.blue,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a phone number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (form.currentState!.validate()) {
                          _saveProfile();
                        }
                      },
                      child: Text('Save Profile'),
                    ),
                    if (_errorMessage != null)
                      Text(
                        _errorMessage!,
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../custom/theme.dart';

// class AddTeam extends StatefulWidget {
//   const AddTeam({super.key});

//   @override
//   State<AddTeam> createState() => _AddTeamState();
// }

// class _AddTeamState extends State<AddTeam> {
//   XFile? image;

//   final ImagePicker picker = ImagePicker();

//   final form = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phonenumberController = TextEditingController();
//   TextEditingController rescuedepartmentController = TextEditingController();
//   String? _errormessage;

//   Future getImage(ImageSource media) async {
//     var img = await picker.pickImage(source: media);

//     setState(() {
//       image = img;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomTheme.backgroundColor,
//       appBar: AppBar(
//         elevation: 0.0,
//         centerTitle: true,
//         title: Text('Add members'),
//         backgroundColor: CustomTheme.backgroundColor,
//         foregroundColor: CustomTheme.blue,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               SizedBox(height: 10.0),
//               Center(
//                 child: CircleAvatar(
//                   radius: 80.0,
//                   backgroundColor: Colors.grey,
//                   // Replace with the actual image widget or load image from network
//                   // backgroundImage: AssetImage('assets/images/profile_image.jpg'),
//                 ),
//               ),
//               SizedBox(height: 10.0),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                   getImage(ImageSource.gallery);
//                   // Open photo picker or camera to choose/update profile photo
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.camera_alt,
//                       color: CustomTheme.blue,
//                     ),
//                     SizedBox(width: 8.0),
//                     Text(
//                       'Add Photo',
//                       style: TextStyle(
//                         color: CustomTheme.blue,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     image != null
//                         ? Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 20),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(8),
//                               child: Image.file(
//                                 //to show image, you type like this.
//                                 File(image!.path),
//                                 fit: BoxFit.cover,
//                                 width: MediaQuery.of(context).size.width,
//                                 height: 300,
//                               ),
//                             ),
//                           )
//                         : Text(
//                             ".",
//                             style: TextStyle(fontSize: 20),
//                           )
//                   ],
//                 ),
//               ),
//               SizedBox(height: 30.0),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Name',
//                   floatingLabelStyle: TextStyle(
//                     color: CustomTheme.blue,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Email',
//                   floatingLabelStyle: TextStyle(
//                     color: CustomTheme.blue,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Phone Number',
//                   floatingLabelStyle: TextStyle(
//                     color: CustomTheme.blue,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: InputDecoration(
//                   labelText: 'Rescue Department',
//                   floatingLabelStyle: TextStyle(
//                     color: CustomTheme.blue,
//                   ),
//                   filled: true,
//                   fillColor: Colors.grey[200],
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 32.0),
//               ElevatedButton(
//                 onPressed: () {
//                   // Save profile
//                 },
//                 child: Text('Save'),
//                 style: ElevatedButton.styleFrom(
//                   primary: CustomTheme.blue,
//                   textStyle: TextStyle(
//                     color: Colors.white,
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8.0),
//                   ),
//                   padding: EdgeInsets.symmetric(vertical: 16.0),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
