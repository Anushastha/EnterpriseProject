import 'package:enterprise_project/features/rescueTeam/rescueDash.dart';
import 'package:enterprise_project/features/user/dashboard/location/map.dart';
import 'package:flutter/material.dart';

import '../../../custom/theme.dart';
<<<<<<< HEAD
import '../screens/chat.dart';
=======
import 'find_device.dart';
>>>>>>> 0e237b4dd7e775ffb5377d2b5fa62bc59f90a7db
import 'health/health_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  int _currentIndex = 0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: CustomTheme.backgroundColor,
      drawerEnableOpenDragGesture: false,
      body: Container(
        padding: EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(height: 24.0),
            Expanded(
              child: IndexedStack(
                index: _currentIndex,
                children: [
                  // Screens for each menu option
                  healthScreen(),
                  MapScreen(),
<<<<<<< HEAD
                  Text("device"),
                  ChatPage(),
=======
                  FindDevice(),
                  EmergencyCallDialog(emergencyNumber: "9843579764"),
>>>>>>> 0e237b4dd7e775ffb5377d2b5fa62bc59f90a7db
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
            icon: Icon(Icons.favorite),
            label: 'Health',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'GPS',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch),
            label: 'Device',
          ),
          BottomNavigationBarItem(
<<<<<<< HEAD
            icon: Icon(Icons.message),
            label: 'Chats',
=======
            icon: Icon(Icons.call),
            label: 'Call',
>>>>>>> 0e237b4dd7e775ffb5377d2b5fa62bc59f90a7db
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(HomeScreen());
}
