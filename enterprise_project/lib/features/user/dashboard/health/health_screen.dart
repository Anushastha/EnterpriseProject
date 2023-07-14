import 'dart:ffi';

import 'package:enterprise_project/custom/list/health_list.dart';
import 'package:enterprise_project/features/user/dashboard/health/steps.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../../../../custom/theme.dart';

class healthScreen extends StatefulWidget {
  const healthScreen({super.key});

  @override
  State<healthScreen> createState() => _healthScreenState();
}

class _healthScreenState extends State<healthScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  bool _isButtonOn = false;
  // String _buttonText = "Off";

  void _toggleButtonState(bool value) {
    setState(() {
      _isButtonOn = value;
      _database.child('BPM Sensor').set(_isButtonOn ? 1 : 0);
      _database.child('DHT Sensor').set(_isButtonOn ? 1 : 0);
    });
  }

  late final _sensorDatabase = FirebaseDatabase.instance.ref().onValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              print("hello");
            },
            icon: Icon(
              Icons.menu,
              size: 30,
              color: Colors.black,
            )),
        title: Padding(
          padding: const EdgeInsets.only(left: 60, top: 15),
          child: Text(
            "Health Record",
            style: TextStyle(color: CustomTheme.textColor, fontSize: 20),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                FlutterSwitch(
                  width: 50,
                  height: 30,
                  toggleSize: 20.0,
                  value: _isButtonOn,
                  borderRadius: 30.0,
                  padding: 2.0,
                  activeToggleColor: Colors.white,
                  inactiveToggleColor: Colors.white,
                  activeSwitchBorder:
                      Border.all(color: CustomTheme.shadowColor, width: 2.0),
                  inactiveSwitchBorder:
                      Border.all(color: CustomTheme.shadowColor, width: 2.0),
                  activeColor: CustomTheme.blue,
                  inactiveColor: Color.fromARGB(255, 179, 176, 176),
                  onToggle: _toggleButtonState,
                ),
              ],
            ),
          )
        ],
      ),
      body: Container(
        color: CustomTheme.backgroundColor,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              child: Column(
                children: [
                  StepsScreen(),
                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        child: StreamBuilder(
                            stream: _sensorDatabase,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data =
                                    snapshot.data?.snapshot.value as Map?;
                                if (data == null) {
                                  return Text('No Sensor data');
                                }
                                final BPM = data['BPM'];
                                final heartBeat = data['Heartbeat'];
                                final Temperature = data['Temperature'];
                                final SpO2 = data['SPO2'];
                                print("bpm : $BPM");
                                print("temperature : $Temperature");

                                return Column(
                                  children: [
                                    CustomListTile(
                                      cardColor: CustomTheme.lightRed,
                                      iconBoxColor: CustomTheme.red,
                                      icon: Icons.monitor_heart_outlined,
                                      title: "$heartBeat BPM",
                                      titleColor: CustomTheme.red,
                                      subTitle: "Heartbeat",
                                      subTitleColor: CustomTheme.textColor,
                                      date: "3/08/2023",
                                      onPressed: () {
                                        Navigator.of(context).pushNamed("/bpm");
                                      },
                                    ),
                                    CustomListTile(
                                      cardColor: CustomTheme.lightBlue,
                                      iconBoxColor: CustomTheme.blue,
                                      icon: Icons.spa_outlined,
                                      title: "$SpO2 SpO2",
                                      titleColor: CustomTheme.blue,
                                      subTitle: "Oxygen Level",
                                      subTitleColor: CustomTheme.textColor,
                                      date: "3/08/2023",
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed("/spO2");
                                      },
                                    ),
                                    CustomListTile(
                                      cardColor: CustomTheme.lightGreen,
                                      iconBoxColor: CustomTheme.green,
                                      icon: Icons.thermostat_auto_rounded,
                                      title: "$Temperature C",
                                      titleColor: CustomTheme.green,
                                      subTitle: "Tempearature",
                                      subTitleColor: CustomTheme.textColor,
                                      date: "3/08/2023",
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamed("/temperature");
                                      },
                                    ),
                                    CustomListTile(
                                      cardColor: CustomTheme.lightRed,
                                      iconBoxColor: CustomTheme.red,
                                      icon: Icons.bloodtype_outlined,
                                      title: "$BPM BPM",
                                      titleColor: CustomTheme.red,
                                      subTitle: "BPM",
                                      subTitleColor: CustomTheme.textColor,
                                      date: "3/08/2023",
                                    ),
                                  ],
                                );
                              }
                              if (snapshot.hasError) {
                                print(snapshot.error.toString());
                                return Text(snapshot.error.toString());
                              }

                              return Text('....');
                            }),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
