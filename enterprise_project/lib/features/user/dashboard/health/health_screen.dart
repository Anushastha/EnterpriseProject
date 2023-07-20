// import 'dart:ffi';

// import 'package:enterprise_project/custom/list/health_list.dart';
// import 'package:enterprise_project/features/user/dashboard/health/steps.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';

// import '../../../../custom/theme.dart';

// class healthScreen extends StatefulWidget {
//   const healthScreen({super.key});

//   @override
//   State<healthScreen> createState() => _healthScreenState();
// }

// class _healthScreenState extends State<healthScreen> {
//   final DatabaseReference _database = FirebaseDatabase.instance.reference();

//   bool _isButtonOn = false;
//   // String _buttonText = "Off";

//   void _toggleButtonState(bool value) {
//     setState(() {
//       _isButtonOn = value;
//       _database.child('BPM Sensor').set(_isButtonOn ? 1 : 0);
//       _database.child('DHT Sensor').set(_isButtonOn ? 1 : 0);
//     });
//   }

//   late final _sensorDatabase = FirebaseDatabase.instance.ref().onValue;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       appBar: AppBar(
//         backgroundColor: CustomTheme.backgroundColor,
//         elevation: 0,
//         leading: IconButton(
//             onPressed: () {
//               _scaffoldKey.currentState!.openDrawer();
//             },
//             icon: Icon(
//               Icons.menu,
//               size: 30,
//               color: Colors.black,
//             )),
//         title: Padding(
//           padding: const EdgeInsets.only(left: 60, top: 15),
//           child: Text(
//             "Health Record",
//             style: TextStyle(color: CustomTheme.textColor, fontSize: 20),
//           ),
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 14),
//             child: Row(
//               children: [
//                 FlutterSwitch(
//                   width: 50,
//                   height: 30,
//                   toggleSize: 20.0,
//                   value: _isButtonOn,
//                   borderRadius: 30.0,
//                   padding: 2.0,
//                   activeToggleColor: Colors.white,
//                   inactiveToggleColor: Colors.white,
//                   activeSwitchBorder:
//                       Border.all(color: CustomTheme.shadowColor, width: 2.0),
//                   inactiveSwitchBorder:
//                       Border.all(color: CustomTheme.shadowColor, width: 2.0),
//                   activeColor: CustomTheme.blue,
//                   inactiveColor: Color.fromARGB(255, 179, 176, 176),
//                   onToggle: _toggleButtonState,
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//       drawer: Drawer(
//           backgroundColor: CustomTheme.lightBlue,
//           child: Column(
//             children: [
//               Container(
//                   color: CustomTheme.blue,
//                   padding: EdgeInsets.only(
//                       top: MediaQuery.of(context).viewPadding.top + 20,
//                       bottom: 15,
//                       left: 15,
//                       right: 15),
//                   child: Row(children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(300.0),
//                       child: Container(
//                         color: CustomTheme.lightBlue,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           // child: Image.asset(
//                           //   "assets/images/logo.png",
//                           //   height: 20,
//                           //   width: 20,
//                           // ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       width: 40,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Sabina Tamang",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                           ),
//                         ),
//                         Text(
//                           "Nuwakot",
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 14,
//                           ),
//                         ),
//                       ],
//                     )
//                   ])),
//               ListTile(
//                 title: Text("Logout"),
//                 leading: Icon(Icons.exit_to_app),
//                 trailing: Icon(Icons.arrow_forward_ios_rounded),
//                 onTap: () {
//                   Navigator.of(context).pushNamed('/login');
//                 },
//               ),
//             ],
//           )),
//       body: Container(
//         color: CustomTheme.backgroundColor,
//         width: double.infinity,
//         child: Row(
//           children: [
//             Container(
//               child: Column(
//                 children: [
//                   StepsScreen(),
//                   Expanded(
//                     child: Container(
//                       child: SingleChildScrollView(
//                         child: StreamBuilder(
//                             stream: _sensorDatabase,
//                             builder: (context, snapshot) {
//                               if (snapshot.hasData) {
//                                 final data =
//                                     snapshot.data?.snapshot.value as Map?;
//                                 if (data == null) {
//                                   return Text('No Sensor data');
//                                 }
//                                 final BPM = data['BPM'];
//                                 final heartBeat = data['Heartbeat'];
//                                 final Temperature = data['Temperature'];
//                                 final SpO2 = data['SPO2'];
//                                 print("bpm : $BPM");
//                                 print("temperature : $Temperature");

//                                 return Column(
//                                   children: [
//                                     CustomListTile(
//                                       cardColor: CustomTheme.lightRed,
//                                       iconBoxColor: CustomTheme.red,
//                                       icon: Icons.monitor_heart_outlined,
//                                       title: "$heartBeat BPM",
//                                       titleColor: CustomTheme.red,
//                                       subTitle: "Heartbeat",
//                                       subTitleColor: CustomTheme.textColor,
//                                       date: "3/08/2023",
//                                       onPressed: () {
//                                         Navigator.of(context).pushNamed("/bpm");
//                                       },
//                                     ),
//                                     CustomListTile(
//                                       cardColor: CustomTheme.lightBlue,
//                                       iconBoxColor: CustomTheme.blue,
//                                       icon: Icons.spa_outlined,
//                                       title: "$SpO2 SpO2",
//                                       titleColor: CustomTheme.blue,
//                                       subTitle: "Oxygen Level",
//                                       subTitleColor: CustomTheme.textColor,
//                                       date: "3/08/2023",
//                                       onPressed: () {
//                                         Navigator.of(context)
//                                             .pushNamed("/spO2");
//                                       },
//                                     ),
//                                     CustomListTile(
//                                       cardColor: CustomTheme.lightGreen,
//                                       iconBoxColor: CustomTheme.green,
//                                       icon: Icons.thermostat_auto_rounded,
//                                       title: "$Temperature C",
//                                       titleColor: CustomTheme.green,
//                                       subTitle: "Tempearature",
//                                       subTitleColor: CustomTheme.textColor,
//                                       date: "3/08/2023",
//                                       onPressed: () {
//                                         Navigator.of(context)
//                                             .pushNamed("/temperature");
//                                       },
//                                     ),
//                                     CustomListTile(
//                                       cardColor: CustomTheme.lightRed,
//                                       iconBoxColor: CustomTheme.red,
//                                       icon: Icons.bloodtype_outlined,
//                                       title: "$BPM BPM",
//                                       titleColor: CustomTheme.red,
//                                       subTitle: "BPM",
//                                       subTitleColor: CustomTheme.textColor,
//                                       date: "3/08/2023",
//                                     ),
//                                   ],
//                                 );
//                               }
//                               if (snapshot.hasError) {
//                                 print(snapshot.error.toString());
//                                 return Text(snapshot.error.toString());
//                               }

//                               return Text('....');
//                             }),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:dio/dio.dart';
import 'package:enterprise_project/custom/list/health_list.dart';
import 'package:enterprise_project/custom/utils/constants.dart';
import 'package:enterprise_project/features/user/dashboard/health/steps.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../custom/theme.dart';

class healthScreen extends StatefulWidget {
  const healthScreen({super.key});

  @override
  State<healthScreen> createState() => _healthScreenState();
}

class _healthScreenState extends State<healthScreen> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isButtonOn = false;
  // String _buttonText = "Off";

  void _toggleButtonState(bool value) {
    setState(() {
      _isButtonOn = value;
      _database.child('BPM Sensor').set(_isButtonOn ? 1 : 0);
      _database.child('DHT Sensor').set(_isButtonOn ? 1 : 0);
    });
  }

  Future<Map<String, dynamic>> fetchData() async {
    try {
      final dio = Dio();

      dio.options.headers['content-Type'] = 'application/json';
      dio.options.headers["Cookie"] =
          "JSESSIONID=61492F887AA831EE921BC97648CBE6CD";
      // dio.options.headers["Cookie"] =
      //     "JSESSIONID=74030D5BD5E8B9E2B4843FA7C669CF3C";
      final response = await dio.get(
        Constants.sensor,
      );
      print(response.statusCode); //
      print(response.data);
      if (response.statusCode! >= 200 && response.statusCode! <= 300) {
        final data = response.data as Map<String, dynamic>;
        return data;
      } else {
        throw Exception(
            'Failed to fetch sensor data. Status code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('DioError Response: ${e.response!.data}');
        print('DioError Status: ${e.response!.statusCode}');
        print('DioError Headers: ${e.response!.headers}');
        throw Exception('DioError: ${e.response!.data}');
      } else {
        throw Exception('DioError: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: CustomTheme.backgroundColor,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openDrawer();
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
      drawer: Drawer(
          backgroundColor: CustomTheme.lightBlue,
          child: Column(
            children: [
              Container(
                  color: CustomTheme.blue,
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).viewPadding.top + 20,
                      bottom: 15,
                      left: 15,
                      right: 15),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(300.0),
                      child: Container(
                        color: CustomTheme.lightBlue,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          // child: Image.asset(
                          //   "assets/images/logo.png",
                          //   height: 20,
                          //   width: 20,
                          // ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Simran",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "Kathmandu",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  ])),
              ListTile(
                title: Text("Logout"),
                leading: Icon(Icons.exit_to_app),
                trailing: Icon(Icons.arrow_forward_ios_rounded),
                onTap: () {
                  Navigator.of(context).pushNamed('/login');
                },
              ),
            ],
          )),
      body: Container(
        color: CustomTheme.backgroundColor,
        width: double.infinity,
        child: Row(
          children: [
            Container(
              child: Column(
                children: [
                  // StepsScreen(),

                  Expanded(
                    child: Container(
                      child: SingleChildScrollView(
                        child: FutureBuilder<Map<String, dynamic>>(
                            future: fetchData(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  heightFactor: 15,
                                  widthFactor: 10,
                                  child: CircularProgressIndicator(),
                                );
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData &&
                                  snapshot.data != null) {
                                final sensorData = snapshot.data!;
                                final steps = sensorData['Steps'];
                                final bpmSensor = sensorData['BPM Sensor'];
                                final temperature = sensorData['Temperature'];
                                final device = sensorData['Device'];
                                final spO2 = sensorData['SPO2'];
                                final latitude = sensorData['Latitude'];
                                final hrv = sensorData['HRV'];
                                final longitude = sensorData['Longitude'];
                                final stress =
                                    sensorData['Stress'].toStringAsFixed(1);
                                final battery = sensorData['Battery'];
                                final heartBeat = sensorData['Heartbeat'];
                                final humidity =
                                    sensorData['Humidity'].toStringAsFixed(1);
                                final dhtSensor = sensorData['DHTmSensor'];
                                final bpm = sensorData['BPM'];
                                final altitude = sensorData['Altitude'];
                                print("bpm : $bpm");
                                print("temperature : $temperature");
                                print("stress : $stress");

                                return Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 20),
                                            decoration: BoxDecoration(
                                                color: CustomTheme.green,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Container(
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 20.0),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 15,
                                                                  bottom: 15,
                                                                  left: 10),
                                                          // height: 32,
                                                          // width: 32,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  shape: BoxShape
                                                                      .circle),
                                                          child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      12,
                                                                  vertical: 12),
                                                              child: Icon(
                                                                Icons
                                                                    .settings_input_antenna,
                                                                color:
                                                                    CustomTheme
                                                                        .blue,
                                                                size: 15,
                                                              )),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 15,
                                                                  right: 30),
                                                          child: Text(
                                                            "Steps",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 30),
                                                      child:
                                                          CircularStepProgressIndicator(
                                                        totalSteps: 1500,
                                                        currentStep:
                                                            steps.toInt(),
                                                        stepSize: 3,
                                                        selectedColor:
                                                            CustomTheme
                                                                .whiteText,
                                                        unselectedColor:
                                                            Color.fromARGB(255,
                                                                46, 177, 162),
                                                        padding: 0,
                                                        width: 100,
                                                        height: 100,
                                                        selectedStepSize: 3,
                                                        roundedCap: (_, __) =>
                                                            true,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      22.0,
                                                                  vertical:
                                                                      35.0),
                                                          child: Text(
                                                            "$steps",
                                                            style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 35),
                                          Container(
                                              child: Column(
                                            children: [
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Column(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .water_drop_sharp,
                                                              color: CustomTheme
                                                                  .blue,
                                                            ),
                                                            Text(
                                                              "Humidity",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 30),
                                                      Text(
                                                        "$humidity %",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: Column(
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .sentiment_very_dissatisfied_rounded,
                                                              color: CustomTheme
                                                                  .red,
                                                            ),
                                                            Text(
                                                              "Stress",
                                                              style: TextStyle(
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(width: 50),
                                                      Text(
                                                        "$stress %",
                                                        style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                              ),
                                            ],
                                          ))
                                        ],
                                      ),
                                    ),
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
                                      title: "$spO2 SpO2",
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
                                      title: "$temperature C",
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
                                      title: "$bpm BPM",
                                      titleColor: CustomTheme.red,
                                      subTitle: "BPM",
                                      subTitleColor: CustomTheme.textColor,
                                      date: "3/08/2023",
                                    ),
                                  ],
                                );
                              } else {
                                return Text('No data available');
                              }
                              // return Text('....');
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
