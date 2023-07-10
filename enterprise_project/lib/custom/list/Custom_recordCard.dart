import 'package:flutter/material.dart';


class CustomRecordCard extends StatefulWidget {
  final Color? cardColor;
  final String min;
  final String avg;
  final String max;

  const CustomRecordCard(
      {super.key,
      this.cardColor,
      required this.min,
      required this.avg,
      required this.max});

  @override
  State<CustomRecordCard> createState() => _CustomRecordCardState();
}

class _CustomRecordCardState extends State<CustomRecordCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 340,
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
          // color: CustomTheme.whiteText,
          color: widget.cardColor,
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: Column(
              children: [
                Text(widget.min,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                SizedBox(
                  height: 6,
                ),
                Text("Min",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(137, 5, 5, 5))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            child: Column(
              children: [
                Text(widget.avg,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                SizedBox(
                  height: 6,
                ),
                Text("Avg",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(137, 5, 5, 5))),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Text(widget.max,
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                SizedBox(
                  height: 6,
                ),
                Text("Max",
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(137, 5, 5, 5))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
