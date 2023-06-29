// import 'package:flutter/material.dart';
// import '../../custom/theme.dart';
// import 'editProfile.dart';
//
// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Center(
//             child: Text(
//               'Rescue Team Dashboard',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//                 color: CustomTheme.blue,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Align(
//               alignment: Alignment.topRight,
//               child: IconButton(
//                 icon: Icon(
//                   Icons.edit,
//                   color: CustomTheme.blue,
//                 ),
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => EditProfileScreen()),
//                   );
//                 },
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(8.0),
//             child: CircleAvatar(
//               radius: 50.0,
//               backgroundColor: Colors.grey,
//               backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPEZReC1Pu5YrUBFjENhqQNFsI2crcnfBdIw&usqp=CAU'),
//             ),
//           ),
//           Card(
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     'Name',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                       'Jason Rai',
//                     style: TextStyle(
//                       color: CustomTheme.lightText,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Card(
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     'Email',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                     'jason.rai@example.com',
//                     style: TextStyle(
//                       color: CustomTheme.lightText,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Card(
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     'Phone',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                       '9841568095',
//                     style: TextStyle(
//                       color: CustomTheme.lightText,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Card(
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     'Gender',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text('Male'),
//                 ),
//               ],
//             ),
//           ),
//           Card(
//             child: Column(
//               children: [
//                 ListTile(
//                   title: Text(
//                     'Rescue Department',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Text(
//                       'Search and Rescue Team',
//                     style: TextStyle(
//                       color: CustomTheme.lightText,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../custom/theme.dart';
// import 'editProfile.dart';

class ProfileScreen extends StatelessWidget {
  @override
  //when logged in, this screen comes first
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Rescue Team ID',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: CustomTheme.blue,
                ),
              ),
              SizedBox(height: 50.0),
              Center(
                child: Container(
                  width: 150.0,
                  height: 150.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                      image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPEZReC1Pu5YrUBFjENhqQNFsI2crcnfBdIw&usqp=CAU'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.0),
              Center(
                child: Text(
                  'Jason Rai',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: CustomTheme.textColor,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Center(
                child: Text(
                  'jason.rai@example.com',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Center(
                child: Text(
                  '9841568095',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Baneshwor, Kathmandu, Nepal',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Center(
                child: Text(
                  'Joined: August, 2022',
                  style: TextStyle(
                    color: CustomTheme.textColor,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Spacer(), // Adds spacer widget to push the text to the bottom
              Center(
                child: Text(
                  'Search and Rescue Department',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: CustomTheme.textColor,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
