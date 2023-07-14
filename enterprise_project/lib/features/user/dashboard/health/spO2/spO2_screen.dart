
import 'package:enterprise_project/features/user/dashboard/health/spO2/daily_record.dart';
import 'package:enterprise_project/features/user/dashboard/health/spO2/weekly_record.dart';
import 'package:flutter/material.dart';
import '../../../../../custom/theme.dart';

class SpO2Screen extends StatefulWidget {
  const SpO2Screen({super.key});

  @override
  State<SpO2Screen> createState() => _SpO2ScreenState();
}

class _SpO2ScreenState extends State<SpO2Screen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomTheme.backgroundColor,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/userDashboard");
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Colors.black,
                )),
          ),
          title: Padding(
            padding: const EdgeInsets.only(
              left: 60,
              top: 15,
            ),
            child: Text("SPO2 Record",
                style: TextStyle(color: CustomTheme.textColor, fontSize: 20)),
          ),
          bottom: TabBar(
              controller: _tabController,
              padding: EdgeInsets.symmetric(horizontal: 40),
              tabs: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Today", style: TextStyle(color: Colors.black)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Week", style: TextStyle(color: Colors.black)),
                ),
              ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            DailyRecord(),
            WekklyRecord(),
          ],
        ));
  }
}
