import 'package:enterprise_project/custom/icon/custom_icon.dart';
import 'package:enterprise_project/custom/list/health_list.dart';
import 'package:enterprise_project/features/dashboard/steps.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../custom/theme.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({super.key});

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {
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
          child: Text("Health Record",
              style: TextStyle(color: CustomTheme.textColor, fontSize: 20)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
              children: [
                CustomIcon(
                  icon: Icons.notifications_active,
                  iconColor: Colors.black,
                ),
              ],
            ),
          )
        ],
      ),
      body: Container(
          color: CustomTheme.backgroundColor,
          child: Row(
            children: [
              Container(
                child: Column(
                  children: [
                    StepsScreen(),
                    CustomListTile(
                        cardColor: CustomTheme.lightBlue,
                        iconBoxColor: CustomTheme.blue,
                        icon: Icons.bloodtype_outlined,
                        title: "120/80 mmHg",
                        titleColor: CustomTheme.blue,
                        subTitle: "Blood Pressure",
                        subTitleColor: CustomTheme.textColor,
                        date: "3/08/2023"),
                    CustomListTile(
                        cardColor: CustomTheme.lightRed,
                        iconBoxColor: CustomTheme.red,
                        icon: Icons.monitor_heart_outlined,
                        title: "98 Bpm",
                        titleColor: CustomTheme.red,
                        subTitle: "Heart Rate",
                        subTitleColor: CustomTheme.textColor,
                        date: "3/08/2023"),
                    CustomListTile(
                        cardColor: CustomTheme.lightGreen,
                        iconBoxColor: CustomTheme.green,
                        icon: Icons.health_and_safety,
                        title: "96 Spo2",
                        titleColor: CustomTheme.green,
                        subTitle: "Oxygen Level",
                        subTitleColor: CustomTheme.textColor,
                        date: "3/08/2023"),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
