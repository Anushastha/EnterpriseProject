// import 'dart:ffi';

// import 'package:dio/dio.dart';
// import 'package:enterprise_project/custom/list/health_list.dart';
// import 'package:enterprise_project/custom/utils/constants.dart';
// import 'package:enterprise_project/features/user/dashboard/health/steps.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';

// import '../../../../custom/theme.dart';
// import '../../../../model/sensor_model.dart';

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



//   Future<List<Sensor>> fetchSensorData() async {
//     try {
//       final _dio = Dio();
//       final _res = await _dio.get(Constants.sensor);
//       final _temp = List.from(_res.data["data"]);
//       print(_res.data);
//       final _formatedData = _temp
//           .map((e) => Sensor(
//                 steps: e["Steps"],
//                 bpmSensor: e["BPM Sensor"],
//                 temperature: e["Temperature"],
//                 device: e["Device"],
//                 spo2: e["SPO2"],
//                 latitude: e["Latitude"],
//                 hrv: e["HRV"],
//                 longitude: e["Longitude"],
//                 stress: e["Stress"],
//                 battery: e["Battery"],
//                 heartbeat: e["Heartbeat"],
//                 humidity: e["Humidity"],
//                 dhtSensor: e["DHT Sensor"],
//                 bpm: e["BPM"],
//                 altitude: e["Altitude"],
//               ))
//           .toList();
//       // print(_res.data);
//       return _formatedData;
//     } on DioError catch (e) {
//       rethrow;
//     } catch (e) {
//       rethrow;
//     }
//   }
// //   Future<List<Sensor>> fetchSensorData() async {
// //     try {
// //       final _dio = Dio();
// //       final _res = await _dio.get(Constants.sensor);
// //       final _temp = Map<String, dynamic>.from(_res.data);
// //       // final _temp = List.from(_res.data);
// //       // print(_res.data);
// //       //  final _formatedData=_temp.map((e)=>Todos(userId: e["userId"], id: e["id"], title: e["title"], completed: e["completed"])).toList();
// //       // final _formatedData = _temp.map((e) => Sensor.fromJson(e)).toList();
// //       final _formatedData = Sensor.fromJson(_temp);
// //       //  print(_res.data);
// //       return [_formatedData];
// //     } on DioError catch (e) {
// // //       // Catch DioError and print the response for debugging
// //       if (e.response != null) {
// //         print('DioError Response: ${e.response!.data}');
// //         print('DioError Status: ${e.response!.statusCode}');
// //         print('DioError Headers: ${e.response!.headers}');
// //       }
// //       throw Exception('DioError: ${e.message}');
// //     } catch (e) {
// //       throw Exception('Error: $e');
// //     }
// //   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: CustomTheme.backgroundColor,
//           elevation: 0,
//           leading: IconButton(
//               onPressed: () {
//                 print("hello");
//               },
//               icon: Icon(
//                 Icons.menu,
//                 size: 30,
//                 color: Colors.black,
//               )),
//           title: Padding(
//             padding: const EdgeInsets.only(left: 60, top: 15),
//             child: Text(
//               "Health Record",
//               style: TextStyle(color: CustomTheme.textColor, fontSize: 20),
//             ),
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 14),
//               child: Row(
//                 children: [
//                   FlutterSwitch(
//                     width: 50,
//                     height: 30,
//                     toggleSize: 20.0,
//                     value: _isButtonOn,
//                     borderRadius: 30.0,
//                     padding: 2.0,
//                     activeToggleColor: Colors.white,
//                     inactiveToggleColor: Colors.white,
//                     activeSwitchBorder:
//                         Border.all(color: CustomTheme.shadowColor, width: 2.0),
//                     inactiveSwitchBorder:
//                         Border.all(color: CustomTheme.shadowColor, width: 2.0),
//                     activeColor: CustomTheme.blue,
//                     inactiveColor: Color.fromARGB(255, 179, 176, 176),
//                     onToggle: _toggleButtonState,
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//         body: Container(
//             color: CustomTheme.backgroundColor,
//             width: double.infinity,
//             child: Row(
//               children: [
//                 Container(
//                   child: Column(
//                     children: [
//                       StepsScreen(),
//                       Expanded(
//                         child: FutureBuilder<List<Sensor>>(
//                             future: fetchSensorData(),
//                             builder: (context, snapshot) {
//                               if (snapshot.connectionState ==
//                                       ConnectionState.waiting ||
//                                   snapshot.connectionState ==
//                                       ConnectionState.none) {
//                                 return Center(
//                                     child: CupertinoActivityIndicator());
//                               } else if (snapshot.connectionState ==
//                                       ConnectionState.active ||
//                                   snapshot.connectionState ==
//                                       ConnectionState.done) {
//                                 if (snapshot.hasData && snapshot.data != null) {
//                                   return ListView.builder(
//                                     itemBuilder: (context, index) {
//                                       child:
//                                       Column(
//                                         children: [
//                                           CustomListTile(
//                                             cardColor: CustomTheme.lightRed,
//                                             iconBoxColor: CustomTheme.red,
//                                             icon: Icons.monitor_heart_outlined,
//                                             title: snapshot.data![index].stress
//                                                 .toString(),
//                                             titleColor: CustomTheme.red,
//                                             subTitle: "Heart Rate",
//                                             subTitleColor:
//                                                 CustomTheme.textColor,
//                                             date: "3/08/2023",
//                                             onPressed: () {
//                                               Navigator.of(context)
//                                                   .pushNamed("/bpm");
//                                             },
//                                           ),
//                                           CustomListTile(
//                                               cardColor: CustomTheme.lightBlue,
//                                               iconBoxColor: CustomTheme.blue,
//                                               icon: Icons.thermostat_outlined,
//                                               title: "90 C",
//                                               titleColor: CustomTheme.green,
//                                               subTitle: "Tempearature",
//                                               subTitleColor:
//                                                   CustomTheme.textColor,
//                                               date: "3/08/2023"),
//                                         ],
//                                       );
//                                     },
//                                     itemCount: snapshot.data!.length,
//                                   );
//                                 } else {
//                                   return Center(
//                                     child: Text(snapshot.error?.toString() ??
//                                         "Error occured"),
//                                   );
//                                 }
//                               } else {
//                                 return Container();
//                               }
//                             }),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             )));
//   }
// }
