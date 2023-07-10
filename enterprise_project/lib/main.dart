import 'package:enterprise_project/features/user/dashboard/health/health_screen.dart';
import 'package:enterprise_project/features/rescueTeam/addTeam.dart';
import 'package:enterprise_project/features/rescueTeam/editProfile.dart';
import 'package:enterprise_project/features/user/dashboard/home_screen.dart';
import 'package:enterprise_project/features/user/screens/forgotpassword.dart';
import 'package:enterprise_project/features/user/screens/login.dart';
import 'package:enterprise_project/features/user/screens/register.dart';
import 'package:flutter/material.dart';

import 'custom/button/custom_button.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'features/rescueTeam/rescueDash.dart';
import 'features/user/dashboard/health/bpm/bpm_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: {
        "/login": (BuildContext context) => LoginScreen(),
        "/register": (BuildContext context) => RegisterWidget(),
        "/forgotpassword": (BuildContext context) => ForgotPassword(),
        "/userDashboard": (BuildContext context) => HomeScreen(),
        "/addteam": (BuildContext context) => AddTeam(),
        "/rescueDashboard": (BuildContext context) => DashboardScreen(),
        "/bpm": (BuildContext context) => BpmScreen(),
      },
    );
  }
}
