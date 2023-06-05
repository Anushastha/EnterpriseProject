import 'package:flutter/material.dart';

import '../theme.dart';

class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextInputType? textInputType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  CustomTextField({
    this.hintText,
    this.textInputType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.validator,
    this.controller,
  });
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
            height: 70,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 43),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                obscureText: widget.obscureText,
                controller: widget.controller,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(
                      color: CustomTheme.textColor,
                      width: 0.5,
                    )),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: new BorderSide(
                      color: CustomTheme.textColor,
                      width: 0.5,
                    )),
                    labelText: 'Email address',
                    labelStyle: TextStyle(
                      color: CustomTheme.textColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                    floatingLabelStyle: TextStyle(color: CustomTheme.textColor),
                    floatingLabelBehavior: FloatingLabelBehavior.always),
              ),
            ),
            // validator: widget.validator,
          ),
        ],
      ),
    );
  }
}
