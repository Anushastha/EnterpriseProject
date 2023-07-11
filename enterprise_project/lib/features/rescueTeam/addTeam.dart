import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:enterprise_project/custom/theme.dart';
import 'package:intl/intl.dart';

import '../../custom/button/custom_dropdown.dart';
import '../../custom/textfield/custom_dateTime.dart';
import '../../custom/textfield/custom_textfield.dart';

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
  TextEditingController _dob = TextEditingController();
  String? selectedDepartment;
  String? selectedGender;

  @override
  void initState() {
    _dob.text = ""; // Set the initial value of the text field
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
        'dob': _dob.text,
        'gender': selectedGender,
        'role': 'Rescue',
        'rescueDepartment': selectedDepartment,
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
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('Add Team Member'),
        backgroundColor: CustomTheme.backgroundColor,
        foregroundColor: CustomTheme.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: form,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: firstNameController,
                      lableText: 'First Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: middleNameController,
                      lableText: 'Middle Name',
                      // Add validation logic for middle name if required
                    ),
                    CustomTextField(
                      controller: lastNameController,
                      lableText: 'Last Name',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: contactNoController,
                      lableText: 'Contact No',
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact number';
                        }
                        return null;
                      },
                    ),
                    CustomTextField(
                      controller: addressController,
                      lableText: 'Address',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    CustomDateTime(
                      controller: _dob,
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2028));
                        DateFormat date = DateFormat(
                            "yyyy-MM-dd");
                        FocusScope.of(context)
                            .requestFocus(new FocusNode());
                        validator:
                            (value) {
                          if (value == null || value.isEmpty) {
                            return "Date is required";
                          }
                          return null;
                        };
                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate =
                          DateFormat('yyyy-MM-dd')
                              .format(pickedDate);
                          print(formattedDate);
                          setState(() {
                            _dob.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }

                      },
                    ),
                    SizedBox(height: 20.0),
                    // CustomDropDown(
                    //     lableText: "Gender",
                    //     hint: "Select Gender",
                    //     dropdownItems: ['Male', 'Female', 'Others'],
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return "Gender is required";
                    //       }
                    //       return null;
                    //     },
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedGender = value;
                    //       });
                    //     }),
                    SizedBox(height: 30.0),
                    // CustomDropDown(
                    //     lableText: "Rescue Department",
                    //     hint: "Select department",
                    //     dropdownItems: [
                    //       'Mountain Rescue',
                    //       'Research',
                    //       'Water Rescue',
                    //       'Control Team',
                    //       'First Aid',
                    //     ],
                    //     validator: (value) {
                    //       if (value == null || value.isEmpty) {
                    //         return "Department is required";
                    //       }
                    //       return null;
                    //     },
                    //     onChanged: (value) {
                    //       setState(() {
                    //         selectedDepartment = value;
                    //       });
                    //     }),
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
            ],
          ),
        ),
      ),
    );
  }
}