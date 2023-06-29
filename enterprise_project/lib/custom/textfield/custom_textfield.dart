import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final String lableText;
  final TextInputType? textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function()? onPressed;
  final TextInputType? keyboardType;

  CustomTextField(
      {this.hintText,
      required this.lableText,
      this.textInputType,
      this.prefixIcon,
      this.suffixIcon,
      this.obscureText = false,
      this.validator,
      this.controller,
      this.onPressed,
      this.keyboardType});
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            height: 60,
            // width: 320,
            child: TextFormField(
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              controller: widget.controller,
              decoration: InputDecoration(
                  label: Text(
                    widget.lableText,
                    style:
                        TextStyle(fontSize: 15, color: CustomTheme.lightText),
                  ),
                  prefixIcon: widget.prefixIcon,
                  suffixIcon: widget.suffixIcon,
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
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontSize: 15,
                    color: CustomTheme.lightText,
                  )),
              validator: widget.validator,
            ),
          ),
        ],
      ),
    );
  }
}
