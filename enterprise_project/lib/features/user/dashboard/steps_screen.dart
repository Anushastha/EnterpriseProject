import 'package:enterprise_project/custom/icon/custom_icon.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../custom/theme.dart';

class StepsScreen extends StatefulWidget {
  const StepsScreen({super.key});

  @override
  State<StepsScreen> createState() => _StepsScreenState();
}

class _StepsScreenState extends State<StepsScreen> {
  @override
  Widget build(BuildContext context) {
    return Row(
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
                        margin: EdgeInsets.only(top: 15, bottom: 15, left: 10),
                        // height: 32,
                        // width: 32,
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
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
                        padding: const EdgeInsets.only(left: 15, right: 30),
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
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CircularStepProgressIndicator(
                      totalSteps: 100,
                      currentStep: 80,
                      stepSize: 3,
                      selectedColor: CustomTheme.whiteText,
                      unselectedColor: const Color.fromARGB(255, 36, 175, 159),
                      padding: 0,
                      width: 100,
                      height: 100,
                      selectedStepSize: 3,
                      roundedCap: (_, __) => true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: 35),
        Column(
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
                            Icons.location_on,
                            color: CustomTheme.blue,
                          ),
                          Text(
                            "Distance",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 30),
                    Text(
                      "30 km",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
                            Icons.track_changes_sharp,
                            color: CustomTheme.red,
                          ),
                          Text(
                            "Target",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.normal),
                          )
                        ],
                      ),
                    ),
                    SizedBox(width: 50),
                    Text(
                      "90 %",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
            ),
          ],
        )
      ],
    );
  }
}
