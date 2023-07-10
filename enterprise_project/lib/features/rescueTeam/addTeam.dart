import 'package:flutter/material.dart';
import 'package:enterprise_project/custom/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 import 'package:enterprise_project/features/rescueTeam/team.dart';
 import 'package:intl/intl.dart';
//
 import '../../custom/textfield/custom_dateTime.dart';
//
// class AddTeam extends StatefulWidget {
//   final VoidCallback? onTeamMemberAdded;
//
//   const AddTeam({Key? key, this.onTeamMemberAdded}) : super(key: key);
//
//   @override
//   State<AddTeam> createState() => _AddTeamState();
// }
//
//
// class _AddTeamState extends State<AddTeam> {
//   final form = GlobalKey<FormState>();
//   TextEditingController firstNameController = TextEditingController();
//   TextEditingController middleNameController = TextEditingController();
//   TextEditingController lastNameController = TextEditingController();
//   TextEditingController contactNoController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController _dob = TextEditingController();
//   TextEditingController rescuedepartmentController = TextEditingController();
//   String? selectedGender;
//
//   @override
//   void initState() {
//     _dob.text = ""; //set the initial value of text field
//     super.initState();
//   }
//   Future<void> _saveTeamMember() async {
//     try {
//       // Get a reference to the Firestore collection
//       CollectionReference usersCollection =
//       FirebaseFirestore.instance.collection('users');
//
//       // Create a new user document with contactNo as the document ID
//       await usersCollection.doc(contactNoController.text).set({
//         'firstName': firstNameController.text,
//         'middleName': middleNameController.text,
//         'lastName': lastNameController.text,
//         'contactNo': contactNoController.text,
//         'address': addressController.text,
//         'dob': _dob.text,
//         'gender': selectedGender,
//         'role': 'Rescue',
//         'rescuedepartment': rescuedepartmentController.text,
//       });
//
//       // Show success dialog
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Success'),
//             content: Text('Team member added successfully'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () {
//                   // Call the callback function to update the team list
//                   widget.onTeamMemberAdded?.call();
//                   Navigator.of(context).pop();
//                   Navigator.pop(context); // Pop the AddTeam screen
//                 },
//               ),
//             ],
//           );
//         },
//       );
//     } catch (e) {
//       // Show error dialog
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Failed to add team member'),
//             actions: <Widget>[
//               TextButton(
//                 child: Text('OK'),
//                 onPressed: () => Navigator.of(context).pop(),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomTheme.backgroundColor,
//       appBar: AppBar(
//         elevation: 0.0,
//         centerTitle: true,
//         title: Text('Add Team Member'),
//         backgroundColor: CustomTheme.backgroundColor,
//         foregroundColor: CustomTheme.blue,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Form(
//                 key: form,
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       controller: firstNameController,
//                       decoration: InputDecoration(
//                         labelText: 'First Name',
//                         floatingLabelStyle: TextStyle(
//                           color: CustomTheme.blue,
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your first name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16.0),
//                     TextFormField(
//                       controller: middleNameController,
//                       decoration: InputDecoration(
//                         labelText: 'Middle Name',
//                         floatingLabelStyle: TextStyle(
//                           color: CustomTheme.blue,
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) {
//                         // Add validation logic for middle name if required
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16.0),
//                     TextFormField(
//                       controller: lastNameController,
//                       decoration: InputDecoration(
//                         labelText: 'Last Name',
//                         floatingLabelStyle: TextStyle(
//                           color: CustomTheme.blue,
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your last name';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16.0),
//                     TextFormField(
//                       controller: contactNoController,
//                       keyboardType: TextInputType.phone,
//                       maxLength: 10,
//                       decoration: InputDecoration(
//                         labelText: 'Contact No',
//                         floatingLabelStyle: TextStyle(
//                           color: CustomTheme.blue,
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your contact number';
//                         }
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16.0),
//                     TextFormField(
//                       controller: addressController,
//                       decoration: InputDecoration(
//                         labelText: 'Address',
//                         floatingLabelStyle: TextStyle(
//                           color: CustomTheme.blue,
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) {
//                         // Add validation logic for address if required
//                         return null;
//                       },
//                     ),
//                     SizedBox(height: 16.0),
//
//                     CustomDateTime(
//                       controller: _dob,
//                       onPressed: () async {
//                         DateTime? pickedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(
//                                 2000), //DateTime.now() - not to allow to choose before today.
//                             lastDate: DateTime(2028));
//                         DateFormat date = DateFormat(
//                             "yyyy-MM-dd'T'HH:mm:ss.SSSZ");
//                         FocusScope.of(context)
//                             .requestFocus(new FocusNode());
//                         validator:
//                             (value) {
//                           if (value == null || value.isEmpty) {
//                             return "Date is required";
//                           }
//                           return null;
//                         };
//                         if (pickedDate != null) {
//                           print(pickedDate);
//                           String formattedDate =
//                           DateFormat('yyyy-MM-dd')
//                               .format(pickedDate);
//                           print(formattedDate);
//                           setState(() {
//                             _dob.text = formattedDate;
//                           });
//                         } else {
//                           print("Date is not selected");
//                         }
//                       },
//                     ),
//                     SizedBox(height: 16.0),
//                     DropdownButtonFormField<String>(
//                       value: selectedGender,
//                       onChanged: (value) {
//                         setState(() {
//                           selectedGender = value;
//                         });
//                       },
//                       decoration: InputDecoration(
//                         labelText: 'Gender',
//                         floatingLabelStyle: TextStyle(
//                           color: CustomTheme.blue,
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       items: ['Male', 'Female', 'Other'].map((gender) {
//                         return DropdownMenuItem<String>(
//                           value: gender,
//                           child: Text(gender),
//                         );
//                       }).toList(),
//                     ),
//
//                     SizedBox(height: 16.0),
//                     TextFormField(
//                       controller: rescuedepartmentController,
//                       decoration: InputDecoration(
//                         labelText: 'Rescue Department',
//                         floatingLabelStyle: TextStyle(
//                           color: CustomTheme.blue,
//                         ),
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8.0),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter a rescue department.';
//                         }
//                         return null;
//                       },
//                     ),
//
//
//                     SizedBox(height: 16.0),
//                     ElevatedButton(
//                       onPressed: () {
//                         if (form.currentState!.validate()) {
//                           _saveTeamMember();
//                         }
//                       },
//                       child: Text('SaveTeam Member'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


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
  TextEditingController rescuedepartmentController = TextEditingController();
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
        'rescueDepartment': rescuedepartmentController.text,
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
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Form(
                key: form,
                child: Column(
                  children: [
                    TextFormField(
                      controller: firstNameController,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: middleNameController,
                      decoration: InputDecoration(
                        labelText: 'Middle Name',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        // Add validation logic for middle name if required
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: lastNameController,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: contactNoController,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        labelText: 'Contact No',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your contact number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: addressController,
                      decoration: InputDecoration(
                        labelText: 'Address',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        // Add validation logic for address if required
                        return null;
                      },
                    ),
                    SizedBox(height: 16.0),
                    CustomDateTime(
                      controller: _dob,
                      onPressed: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2028),
                        );
                        DateFormat date = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (pickedDate != null) {
                          print(pickedDate);
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);
                          setState(() {
                            _dob.text = formattedDate;
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                    SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: selectedGender,
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Gender',
                        filled: true,
                        fillColor: Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: ['Male', 'Female', 'Other'].map((gender) {
                        return DropdownMenuItem<String>(
                          value: gender,
                          child: Text(gender),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16.0),
                    TextFormField(
                      controller: rescuedepartmentController,
                      decoration: InputDecoration(
                        labelText: 'Rescue Department',
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

                    SizedBox(height: 16.0),
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
