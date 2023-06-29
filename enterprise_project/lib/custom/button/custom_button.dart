import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function()? onPressed;

  const CustomButton({
    required this.title,
    this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
            height: 43,
            decoration: BoxDecoration(
              color: CustomTheme.green,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10), bottom: Radius.circular(10)),
            ),
            child: Center(
              child: Text(title,
                  style: TextStyle(
                    color: CustomTheme.whiteText,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  )),
            )),
      ),
    );
  }
}
