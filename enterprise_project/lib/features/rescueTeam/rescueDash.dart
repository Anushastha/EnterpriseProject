import 'package:enterprise_project/features/rescueTeam/editProfile.dart';
import 'package:enterprise_project/features/rescueTeam/team.dart';
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

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
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
          icon: Icon(Icons.menu),
          color: Colors.black,
          onPressed: _openDrawer,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.sos),
            color: Colors.black,
            onPressed: () {
              // Handle Location button pressed
            },
          ),
          IconButton(
            icon: Icon(Icons.location_on),
            color: Colors.black,
            onPressed: () {
              // Handle Location button pressed
            },
          ),
        ],
      ),
      drawerEnableOpenDragGesture: false,
      drawer: Drawer(
        surfaceTintColor: CustomTheme.blue,
        // Drawer content
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: CustomTheme.blue,
              ),
              child: Text(
                'Signed in as: ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Edit Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfileScreen()),
                );              },
            ),
            ListTile(
              title: Text('Log Out'),
              onTap: () {
                // Handle option 2 selected
              },
            ),
          ],
        ),
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
                  ProfileScreen(),
                  AlertScreen(),
                  TeamScreen(),
                  Chats(),
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

void main() {
  runApp(DashboardScreen());
}
