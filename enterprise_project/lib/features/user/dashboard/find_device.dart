import 'package:enterprise_project/custom/button/custom_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class FindDevice extends StatefulWidget {
  const FindDevice({super.key});

  @override
  State<FindDevice> createState() => _FindDeviceState();
}

class _FindDeviceState extends State<FindDevice> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  bool _isButtonOn = false;
  // String _buttonText = "Off";

  void _buttonState() {
    setState(() {
      _isButtonOn = !_isButtonOn;
      _database.child('Device').set(_isButtonOn ? 1 : 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            margin: EdgeInsets.symmetric(vertical: 100, horizontal: 18),
            child: Column(
              children: [
                Text(
                  "My Device",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 20),
                Text(
                    "If you lost your watch, you can click the button below to find",
                    style: TextStyle(
                      fontSize: 15,
                    )),
                SizedBox(
                  height: 50,
                ),
                CustomButton(
                  title: "Find My Watch",
                  onPressed: _buttonState,
                )
              ],
            )));
  }
}
