import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../custom/list/custom_recordCard.dart';
import '../../../../../custom/theme.dart';

class WekklyRecord extends StatefulWidget {
  const WekklyRecord({super.key});

  @override
  State<WekklyRecord> createState() => _WekklyRecordState();
}

class _WekklyRecordState extends State<WekklyRecord> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: CustomTheme.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                  color: CustomTheme.backgroundColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                children: [
                  CustomRecordCard(
                    cardColor: Colors.white,
                    min: "55",
                    avg: "70",
                    max: "96",
                  ),
                  SizedBox(height: 10),
                  SfCartesianChart(
                      backgroundColor: CustomTheme.backgroundColor,
                      // Initialize category axis
                      primaryXAxis: CategoryAxis(),
                      primaryYAxis: NumericAxis(
                          minimum: 50,
                          maximum: 100,
                          // majorGridLines: MajorGridLines(width: 0),
                          interval: 10,
                          borderColor: Colors.transparent,
                          borderWidth: 0),
                      series: <ChartSeries>[
                        SplineAreaSeries<BpmData, String>(
                          color: CustomTheme.red.withOpacity(0.2),
                          borderColor: CustomTheme.red,
                          borderWidth: 2,
                          // Bind data source
                          dataSource: <BpmData>[
                            BpmData('Sun', 80),
                            BpmData('Mon', 60),
                            BpmData('Tue', 70),
                            BpmData('Wed', 90),
                            BpmData('Thu', 55),
                            BpmData('Fri', 90),
                            BpmData('Sat', 70),
                          ],
                          xValueMapper: (BpmData sales, _) => sales.hour,
                          yValueMapper: (BpmData sales, _) => sales.bpm,
                        ),
                        SplineSeries<BpmData, String>(
                          color: CustomTheme.red,
                          // Bind data source
                          dataSource: <BpmData>[
                            BpmData('Sun', 80),
                            BpmData('Mon', 60),
                            BpmData('Tue', 70),
                            BpmData('Wed', 90),
                            BpmData('Thu', 55),
                            BpmData('Fri', 90),
                            BpmData('Sat', 70),
                          ],
                          xValueMapper: (BpmData sales, _) => sales.hour,
                          yValueMapper: (BpmData sales, _) => sales.bpm,
                        )
                      ]),
                ],
              ),
            )
          ],
        ));
  }
}

class BpmData {
  BpmData(this.hour, this.bpm);
  final String hour;
  final double bpm;
}
