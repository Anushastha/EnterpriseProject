import 'package:flutter/material.dart';

import '../../custom/theme.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
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
              ),
              SizedBox(height: 16.0),
              TextFormField(
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
              ),
              SizedBox(height: 16.0),
              TextFormField(
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
              ),
              SizedBox(height: 16.0),
              TextFormField(
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
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  // Save changes and update profile
                },
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
    );
  }
}
