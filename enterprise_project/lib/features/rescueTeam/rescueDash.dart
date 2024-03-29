import 'package:enterprise_project/features/rescueTeam/team.dart';
import 'package:enterprise_project/features/user/screens/chat.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../custom/theme.dart';
import 'Rescueprofile.dart';
import 'alert.dart';
import 'chats.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late User user;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _makeEmergencyCall() async {
    const emergencyNumber =
        '9841588085'; // Replace with your country's emergency number
    final url = 'tel:$emergencyNumber';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Unable to Dial'),
            content: Text('Your device cannot make phone calls.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
      key: _scaffoldKey,
      backgroundColor: CustomTheme.backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: CustomTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.logout),
          color: Colors.black,
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Log Out'),
                  content:
                      Text('Are you sure you want to log out?'), //confirmation
                  actions: [
                    TextButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                    TextButton(
                      child: Text('Log Out'),
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.pushReplacementNamed(
                            context, '/login'); // Navigate to the login screen
                      },
                    ),
                  ],
                );
              },
            );

            child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24.0),
                Expanded(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: [
                      // Screens for each menu option
                      Profile(),
                      AlertScreen(),
                      TeamScreen(),
                      Chats(),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            color: Colors.black,
            onPressed: () {
              _makeEmergencyCall();
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24.0),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  // Screens for each menu option
                  Profile(),
                  AlertScreen(),
                  TeamScreen(),
                  ChatPage(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: CustomTheme.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Team',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Chats',
          ),
        ],
      ),
    );
  }
}

class EmergencyCallDialog extends StatelessWidget {
  final String emergencyNumber;

  const EmergencyCallDialog({Key? key, required this.emergencyNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Telephony telephony = Telephony.instance;

    return AlertDialog(
      title: Text('Emergency Call'),
      content: Text(
          'Are you sure you want to make an emergency call to $emergencyNumber?'),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Call'),
          onPressed: () async {
            await telephony.openDialer(emergencyNumber);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DashboardScreen(),
  ));
}
