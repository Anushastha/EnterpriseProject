import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enterprise_project/custom/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTeam extends StatefulWidget {
  final VoidCallback? onTeamMemberAdded;

  const AddTeam({Key? key, this.onTeamMemberAdded}) : super(key: key);

  @override
  State<AddTeam> createState() => _AddTeamState();
}

class _AddTeamState extends State<AddTeam> {
  final form = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController rescueDepartmentController = TextEditingController();

  @override
  void initState() {
    dobController.text = ""; // Set the initial value of the date of birth text field
    super.initState();
  }

  Future<void> _saveTeamMember() async {
    try {
      // Get a reference to the Firestore collection
      CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

      // Create a new user document with contactNo as the document ID
      await usersCollection.doc(contactNoController.text).set({
        'firstName': firstNameController.text,
        'middleName': middleNameController.text,
        'lastName': lastNameController.text,
        'contactNo': contactNoController.text,
        'address': addressController.text,
        'dob': dobController.text,
        'gender': genderController.text,
        'role': 'Rescue',
        'rescueDepartment': rescueDepartmentController.text,
      });

      // Show success dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Team member added successfully'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  // Call the callback function to update the team list
                  widget.onTeamMemberAdded?.call();
                  Navigator.of(context).pop();
                  Navigator.pop(context); // Pop the AddTeam screen
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Show error dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to add team member'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: CustomTheme.blue,
        elevation: 0.0,
        centerTitle: true,
        title: Text('Add Team Member'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Form(
            key: form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: middleNameController,
                  decoration: InputDecoration(labelText: 'Middle Name'),
                  // Add validation logic for middle name if required
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  maxLength: 10,
                  controller: contactNoController,
                  decoration: InputDecoration(labelText: 'Contact No'),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: addressController,
                  decoration: InputDecoration(labelText: 'Address'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  controller: dobController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date of Birth',
                    suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            dobController.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          });
                        }
                      },
                    ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select your date of birth';
                    }
                    return null;
                  },
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null) {
                      setState(() {
                        dobController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    }
                  },
                ),
                TextFormField(
                      controller: genderController,
                      decoration: InputDecoration(labelText: 'Gender'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your gender';
                        }
                        return null;
                      },
                    ),
                TextFormField(
                  controller: rescueDepartmentController,
                  decoration: InputDecoration(labelText: 'Rescue Department'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the rescue department';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (form.currentState!.validate()) {
                      _saveTeamMember();
                    }
                  },
                  child: Text('Save Team Member'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
