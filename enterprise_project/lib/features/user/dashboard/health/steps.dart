import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../custom/theme.dart';

class StepsScreen extends StatefulWidget {
  const StepsScreen({super.key});

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  late final _database = FirebaseDatabase.instance.ref().onValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _database,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data?.snapshot.value as Map?;
            if (data == null) {
              return Text("No steps");
            }
            final steps = data['Steps'] ?? 0.0;
            ;
            final humidity = data['Humidity'] ?? 0.0;
            ;
            final formattedHumidity = data['Humidity'] ?? 0.0;
            ;
            final stress = data['Stress'];
            String formattedStress = stress.toStringAsFixed(1);
            print("Steps : $steps");
            return Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                        color: CustomTheme.green,
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: 15, bottom: 15, left: 10),
                                  // height: 32,
                                  // width: 32,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                      child: Icon(
                                        Icons.settings_input_antenna,
                                        color: CustomTheme.blue,
                                        size: 15,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 30),
                                  child: Text(
                                    "Steps",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: CircularStepProgressIndicator(
                                totalSteps: 100,
                                currentStep: steps,
                                stepSize: 3,
                                selectedColor: CustomTheme.whiteText,
                                unselectedColor:
                                    Color.fromARGB(255, 46, 177, 162),
                                padding: 0,
                                width: 100,
                                height: 100,
                                selectedStepSize: 3,
                                roundedCap: (_, __) => true,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 22.0, vertical: 35.0),
                                  child: Text(
                                    "$steps",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
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
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.water_drop_sharp,
                                      color: CustomTheme.blue,
                                    ),
                                    Text(
                                      "Humidity",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 30),
                              Text(
                                "$formattedHumidity %",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.sentiment_very_dissatisfied_rounded,
                                      color: CustomTheme.red,
                                    ),
                                    Text(
                                      "Stress",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(width: 50),
                              Text(
                                "$formattedStress %",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ))
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Text(snapshot.error.toString());
          }
          return Text('....');
        });
  }
}
