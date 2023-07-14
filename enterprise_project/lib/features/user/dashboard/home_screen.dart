import 'package:enterprise_project/features/user/dashboard/location/map.dart';
import 'package:flutter/material.dart';

import '../../../custom/theme.dart';
import 'find_device.dart';
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
                  FindDevice(),
                  Text("profile"),
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
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(HomeScreen());
}
