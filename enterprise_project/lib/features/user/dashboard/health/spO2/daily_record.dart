import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../custom/list/custom_recordCard.dart';
import '../../../../../custom/theme.dart';

class DailyRecord extends StatefulWidget {
  const DailyRecord({super.key});

  @override
  State<DailyRecord> createState() => _DailyRecordState();
}

class _DailyRecordState extends State<DailyRecord> {
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
                    min: "60",
                    avg: "90",
                    max: "130",
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
                          color: CustomTheme.blue.withOpacity(0.2),
                          borderColor: CustomTheme.blue,
                          borderWidth: 2,
                          // Bind data source
                          dataSource: <BpmData>[
                            BpmData('0', 80),
                            BpmData('3', 60),
                            BpmData('6', 70),
                            BpmData('9', 90),
                            BpmData('12', 55),
                            BpmData('15', 90),
                            BpmData('18', 70),
                            BpmData('21', 70),
                            BpmData('24', 70),
                          ],
                          xValueMapper: (BpmData sales, _) => sales.hour,
                          yValueMapper: (BpmData sales, _) => sales.bpm,
                        ),
                        SplineSeries<BpmData, String>(
                          color: CustomTheme.blue,
                          // Bind data source
                          dataSource: <BpmData>[
                            BpmData('0', 80),
                            BpmData('3', 60),
                            BpmData('6', 70),
                            BpmData('9', 90),
                            BpmData('12', 55),
                            BpmData('15', 90),
                            BpmData('18', 70),
                            BpmData('21', 70),
                            BpmData('24', 70)
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
