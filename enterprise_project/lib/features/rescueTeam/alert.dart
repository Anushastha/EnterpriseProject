import 'package:flutter/material.dart';

import '../../custom/theme.dart';

class AlertScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Rescue Alerts',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: CustomTheme.blue,
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_off,
                    size: 80.0,
                    color: CustomTheme.red,
                  ),
                  Text(
                    'No alerts',
                    style: TextStyle(
                      fontSize: 25.0,
                      color: CustomTheme.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
