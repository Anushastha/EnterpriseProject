import 'package:enterprise_project/custom/theme.dart';
import 'package:flutter/material.dart';

import '../icon/custom_icon.dart';

class CustomListTile extends StatefulWidget {
  final Color cardColor;
  final Color iconBoxColor;
  final String title;
  final Color titleColor;
  final String subTitle;
  final Color subTitleColor;
  final String date;
  final IconData icon;

  const CustomListTile({
    super.key,
    required this.cardColor,
    required this.iconBoxColor,
    required this.title,
    required this.titleColor,
    required this.subTitle,
    required this.subTitleColor,
    required this.date,
    required this.icon,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      width: 340,
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 15),
      decoration: BoxDecoration(
          // color: CustomTheme.lightBlue,
          color: widget.cardColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 15),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  // color: CustomTheme.blue,
                  color: widget.iconBoxColor,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  child: CustomIcon(
                    icon: Icons.bloodtype_outlined,
                    iconColor: Colors.white,
                    iconSize: 30,
                  )),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(widget.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: widget.titleColor,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26.0),
                  child: Text(widget.subTitle,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: widget.subTitleColor,
                      )),
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.date,
              style: TextStyle(color: CustomTheme.lightText),
            ),
            Icon(Icons.arrow_forward_ios, size: 20),
          ],
        ),
      ),
    );
  }
}
