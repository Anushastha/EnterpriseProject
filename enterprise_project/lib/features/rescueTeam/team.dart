import 'package:flutter/material.dart';
import 'package:enterprise_project/custom/theme.dart';

import 'addTeam.dart';

class TeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left:40.0),
                      child: Text(
                        'Team',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: CustomTheme.blue,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_circle,
                    color: CustomTheme.blue,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddTeam()),
                    );
                  },
                ),
              ],
            ),            SizedBox(height: 20.0),
            CardItem(
              name: 'Mansoon Dangol',
              phoneNumber: '9817660885',
              image: 'https://hoopshype.com/wp-content/uploads/sites/92/2021/12/i_33_11_09_jayson-tatum.png?w=1000&h=600&crop=1',
            ),
            CardItem(
              name: 'Sarita Ban',
              phoneNumber: '9810775642',
              image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRnO6SJGlkh-LfnwKe-yTYUNKzyad9xnlhBYg&usqp=CAU',
            ),
            CardItem(
              name: 'Namrata Regmi',
              phoneNumber: '9841173085',
              image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2FAUBGiR6zhUqQClHm8mM0RpY7drYQB1qPYlsN0xXF6-M7kl0ON4XOpbuD_DfhvDNWNo&usqp=CAU',
            ),
            CardItem(
              name: 'Jason Rai',
              phoneNumber: '9841568095',
              image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSPEZReC1Pu5YrUBFjENhqQNFsI2crcnfBdIw&usqp=CAU',
            ),
            CardItem(
              name: 'Aakash Dhakal',
              phoneNumber: '9810887631',
              image: 'https://i.pinimg.com/736x/72/c5/4f/72c54f8683612516c7c71a29fae53a05.jpg',
            ),
            CardItem(
              name: 'Biswa Sharma',
              phoneNumber: '9841560935',
              image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZC_95EVYM_FcC4b-LJg6XHL4p1E673azPuTMH92vOjnVJE0-dIyTszYt6teIip0PPcQs&usqp=CAU',
            ),
          ],
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String image;

  const CardItem({
    Key? key,
    required this.name,
    required this.phoneNumber,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Team Member Details'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 50.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(image),
                    ),
                    SizedBox(height: 16.0),
                    Text('Name: $name'),
                    SizedBox(height: 8.0),
                    Text('Phone Number: $phoneNumber'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            },
          );
        },
        leading: CircleAvatar(
          radius: 25.0,
          backgroundColor: Colors.grey,
          backgroundImage: NetworkImage(image),
        ),
        title: Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          phoneNumber,
          style: TextStyle(
            color: CustomTheme.lightText,
          ),
        ),
      ),
    );
  }
}
