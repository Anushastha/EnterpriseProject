import 'dart:js';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:telephony/telephony.dart';

Future<void> _makeEmergencyCall(BuildContext context) async {
  const emergencyNumber = '9843797952';
  final url = 'tel:$emergencyNumber';

  if (await canLaunch(url)) {
    final shouldCall = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return EmergencyCallDialog(emergencyNumber: emergencyNumber);
      },
    );

    if (shouldCall == true) {
      await launch(url);
    }
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          // when trying to make call from emulator
          title: Text('Unable to Dial'),
          content: Text('Your device cannot make phone calls.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

// IconButton(
//             icon: Icon(Icons.call),
//             color: Colors.black,
//             onPressed: () {
//               _makeEmergencyCall(context);
//             },
//           ),

class EmergencyCallDialog extends StatelessWidget {
  final String emergencyNumber;

  const EmergencyCallDialog({Key? key, required this.emergencyNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Telephony telephony = Telephony.instance;

    return AlertDialog(
      title: Text('Emergency Call'),
      content: Text('Are you sure you want to make an emergency call?'),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(false); // Return false to indicate cancel
          },
        ),
        TextButton(
          child: Text('Call'),
          onPressed: () {
            Navigator.of(context).pop(true); // Return true to indicate call
          },
        ),
      ],
    );
  }
}
