import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../custom/theme.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final form = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController rescuedepartmentController = TextEditingController();
  String? _errormessage;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phonenumberController.dispose();
    rescuedepartmentController.dispose();
    super.dispose();
  }

  Future<void> _changeProfilePhoto() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      // The image was successfully picked from the gallery
      final File imageFile = File(pickedImage.path);
      // You can now use the selected image file to update the profile photoThe argument type 'String' can't be assigned to th
      // For example, you can upload it to Firebase Storage and save the URL in the user's document in Firestore.
    } else {
      // No image was picked
    }
  }

  Future<void> _fetchUserData() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userSnapshot =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(user.uid)
                .get();
        if (userSnapshot.exists) {
          Map<String, dynamic> userData = userSnapshot.data()!;
          nameController.text = userData['name'] as String? ?? '';
          emailController.text = userData['email'] as String? ?? '';
          phonenumberController.text = userData['phonenumber'] as String? ?? '';
          rescuedepartmentController.text =
              userData['rescuedepartment'] as String? ?? '';
        }
      }
    } catch (e) {
      setState(() {
        _errormessage = 'Failed to fetch user data: $e';
      });
    }
  }

  Future<void> _updateUserProfile() async {
    if (form.currentState!.validate()) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updateEmail(emailController.text);
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
            'name': nameController.text,
            'email': emailController.text,
            'phonenumber': phonenumberController.text,
            'rescuedepartment': rescuedepartmentController.text,
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully.')),
          );
        }
      } catch (e) {
        setState(() {
          _errormessage = 'Failed to update profile.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('Edit Profile'),
        backgroundColor: CustomTheme.backgroundColor,
        foregroundColor: CustomTheme.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10.0),
                Center(
                  child: CircleAvatar(
                    radius: 80.0,
                    backgroundColor: Colors.grey,
                    // Replace with the actual image widget or load image from network
                    // backgroundImage: AssetImage('assets/images/profile_image.jpg'),
                  ),
                ),
                SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    // Open photo picker or camera to choose/update profile photo
                    _changeProfilePhoto();
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
                        'Change Photo',
                        style: TextStyle(
                          color: CustomTheme.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.0),
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
                    if (value!.isEmpty) {
                      return 'Please enter your name.';
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
                    if (value!.isEmpty) {
                      return 'Please enter an email address.';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email address.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: phonenumberController,
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
                    if (value!.isEmpty) {
                      return 'Please enter a phone number.';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  controller: rescuedepartmentController,
                  decoration: InputDecoration(
                    labelText: 'Rescue Department',
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
                    if (value!.isEmpty) {
                      return 'Please enter a rescue department.';
                    }
                    return null;
                  },
                ),
                if (_errormessage != null)
                  Text(
                    _errormessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: _updateUserProfile,
                  child: Text('Save Changes'),
                  style: ElevatedButton.styleFrom(
                    primary: CustomTheme.blue,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
