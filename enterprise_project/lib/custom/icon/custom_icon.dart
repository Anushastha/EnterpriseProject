import 'package:flutter/material.dart';

import '../theme.dart';

class CustomIcon extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final double? iconSize;

  const CustomIcon(
      {super.key, required this.icon, this.iconColor, this.iconSize});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    ));
  }
}
