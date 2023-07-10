import 'package:control_style/decorated_input_border.dart';
import 'package:enterprise_project/custom/theme.dart';
import 'package:flutter/material.dart';

class CustomDateTime extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final void Function()? onPressed;

  const CustomDateTime(
      {super.key, this.controller, this.validator, this.onPressed});

  @override
  State<CustomDateTime> createState() => _CustomDateTimeState();
}

class _CustomDateTimeState extends State<CustomDateTime> {
  @override
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60,
        child: TextFormField(
          validator: widget.validator,
          controller: widget.controller, //editing controller of this TextField
          decoration: InputDecoration(
      suffixIcon: Icon(Icons.calendar_today), //icon of text field
              border: DecoratedInputBorder(
                child: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                shadow: [
                  BoxShadow(
                    color: CustomTheme.shadowColor,
                    blurRadius: 7,
                    spreadRadius: 2.2,
                  )
                ],
              ),
              disabledBorder: InputBorder.none,
              filled: true,
              fillColor: CustomTheme.whiteText,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 13,
              ),
              // hintText: "Enter dob",
              hintStyle: TextStyle(
                fontSize: 15,
                color: CustomTheme.lightText,
              )),

          readOnly: true,
          onTap: widget.onPressed,
        ));
  }
}
