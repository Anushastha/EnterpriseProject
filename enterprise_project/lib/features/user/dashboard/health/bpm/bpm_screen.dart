import 'package:enterprise_project/features/user/dashboard/health/bpm/daily_record.dart';
import 'package:flutter/material.dart';
import '../../../../../custom/theme.dart';

class BpmScreen extends StatefulWidget {
  const BpmScreen({super.key});

  @override
  State<BpmScreen> createState() => _BpmScreenState();
}

class _BpmScreenState extends State<BpmScreen> with TickerProviderStateMixin {
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
            padding: const EdgeInsets.only(left: 60, top: 15),
            child: Text("BPM Record",
                style: TextStyle(color: CustomTheme.textColor, fontSize: 20)),
          ),
          bottom: TabBar(controller: _tabController, tabs: [
            Text("Today", style: TextStyle(color: Colors.black)),
            Text("Week", style: TextStyle(color: Colors.black)),
          ]),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            DailyRecord(),
            Center(
              child: Text("It's rainy here"),
            ),
          ],
        ));
  }
}
