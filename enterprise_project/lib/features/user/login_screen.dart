import 'package:enterprise_project/custom/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../custom/list/health_list.dart';
import '../../custom/theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomListTile(
      cardColor: CustomTheme.lightRed,
      iconBoxColor: CustomTheme.red,
      title: "100 bmp",
      titleColor: CustomTheme.red,
      subTitle: "Blood Pressure",
      subTitleColor: CustomTheme.textColor,
      date: "2000/3/09",
    ));
  }
}
