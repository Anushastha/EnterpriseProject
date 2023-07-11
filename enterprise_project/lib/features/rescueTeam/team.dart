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
  late User _currentUser; //late = will be initialized later
  List<UserData> _registeredUsers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getCurrentUser();
      _fetchRegisteredUsers();
    });
  }


  Future<void> _getCurrentUser() async {
<<<<<<< HEAD
    if(FirebaseAuth.instance.currentUser!=null)
    _currentUser = FirebaseAuth.instance.currentUser!;
=======
    if (FirebaseAuth.instance.currentUser != null)
      _currentUser = FirebaseAuth.instance.currentUser!;
>>>>>>> 0076b3d1238a86a7dd63790f3458b99cee64442e
  }

  Future<void> _fetchRegisteredUsers() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'Rescue')
        .get();

    final List<UserData> users = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      final String firstName = data['firstName'] as String;
      final String middleName = data['middleName'] as String;
      final String lastName = data['lastName'] as String;
      final String contactNo = doc.id; // Using document ID as contactNo
      final String name =
          '$firstName ${middleName.isNotEmpty ? '$middleName ' : ''}$lastName';
      final String? rescueDepartment = data['rescueDepartment'] as String?;
      return UserData(
        name: name,
        contactNo: contactNo,
        rescueDepartment: rescueDepartment,
      );
    }).toList();

    setState(() {
      _registeredUsers = users;
    });
  }

  Future<void> _deleteMember(String contactNo) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Member'),
          content: Text('Are you sure you want to delete this member?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(contactNo) // Use contactNo as the document ID
                      .delete();

                  setState(() {
                    _registeredUsers
                        .removeWhere((user) => user.contactNo == contactNo);
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Member deleted successfully'),
                    ),
                  );
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete member'),
                    ),
                  );
                }
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
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
                      MaterialPageRoute(
                        builder: (context) => AddTeam(
                          onTeamMemberAdded: _fetchRegisteredUsers,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _registeredUsers.length,
                itemBuilder: (context, index) {
                  final user = _registeredUsers[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          tileColor: Colors.transparent, // Remove tileColor from ListTile
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
                            user.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4.0),
                              Text(
                                user.contactNo,
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14.0,
                                ),
                              ),
                              if (user.rescueDepartment != null)
                                SizedBox(height: 4.0),
                              if (user.rescueDepartment != null)
                                Text(
                                  'Department: ${user.rescueDepartment!}',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 14.0,
                                  ),
                                ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              await _deleteMember(user.contactNo);
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 8.0),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UserData {
  final String name;
  final String contactNo;
  final String? rescueDepartment;

  UserData({
    required this.name,
    required this.contactNo,
    this.rescueDepartment,
  });
}
