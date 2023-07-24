// import 'package:chat_app/Authenticate/Methods.dart';
// import 'package:chat_app/Screens/ChatRoom.dart';
// import 'package:chat_app/group_chats/group_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enterprise_project/features/user/dashboard/home_screen.dart';
import 'package:enterprise_project/features/user/screens/auth_chatroom.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chatroom.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with WidgetsBindingObserver {
  Map<String, dynamic>? userMap;
  String firstName = "";
  String lastName = "";
  String contactNumber = "";
  List chatIds = [];
  bool isLoading = false;
  final TextEditingController _search = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    // setStatus("Online");
  }

  // void setStatus(String status) async {
  //   await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
  //     "status": status,
  //   });
  // }

  @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.resumed) {
  //     // online
  //     setStatus("Online");
  //   } else {
  //     // offline
  //     setStatus("Offline");
  //   }
  // }

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  void onSearch() async {
    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection('users')
        .where("firstName", isEqualTo: _search.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
        firstName = userMap!["firstName"];
        lastName = userMap!["lastName"];
        contactNumber = userMap!["contactNo"].toString();
        isLoading = false;
      });
      print(userMap!["contactNo"].toString() + " is the first name");
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    UserAuths thisUser = new UserAuths();
    thisUser..fetchDocumentIdsFromCollection();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Home Screen"),
      //   actions: [
      //     // IconButton(icon: Icon(Icons.logout), onPressed: () => logOut(context))
      //   ],
      // ),
      body: isLoading
          ? Center(
        child: Container(
          height: size.height / 20,
          width: size.height / 20,
          child: CircularProgressIndicator(),
        ),
      )
          : Column(
        children: [
          SizedBox(
            height: size.height / 20,
          ),
          Container(
            height: size.height / 14,
            width: size.width,
            alignment: Alignment.center,
            child: Container(
              height: size.height / 14,
              width: size.width / 1.15,
              child: TextField(
                controller: _search,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height / 50,
          ),
          ElevatedButton(
            onPressed: onSearch,
            child: Text("Search"),
          ),
          SizedBox(
            height: size.height / 30,
          ),
          userMap != null
              ? ListTile(
            onTap: () {
              UserAuths thisUser = new UserAuths();
              print(thisUser.fname);

              String roomId =
              chatRoomId(thisUser.contactNo, contactNumber);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatRoom(
                    chatRoomId: roomId,
                    userMap: userMap!,
                  ),
                ),
              );
            },
            leading: Icon(Icons.account_box, color: Colors.black),
            title: Text(
              firstName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            subtitle: Text(lastName),
            trailing: Icon(Icons.chat, color: Colors.black),
          )
              : Container(),
          Container(
            height: 250,
            color: Color.fromARGB(0, 244, 67, 54),
            child: ListView.builder(
                itemCount: thisUser.chatIds.length,
                itemBuilder: (BuildContext context, int index) {
                  print(thisUser.chatIds.length.toString() + "length");
                  return ListTile(
                    onTap: () {
                      print(thisUser.chatIds.length.toString() +
                          " is the length");

                      String roomId = thisUser.chatIds[index];

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatRoom(
                            chatRoomId: roomId,
                            userMap: {"Hi": "Hello"},
                          ),
                        ),
                      );
                    },
                    leading: Icon(Icons.account_box, color: Colors.black),
                    title: Text(
                      thisUser.sentBy[index].toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: Icon(Icons.chat, color: Colors.black),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton:
      FloatingActionButton(child: Icon(Icons.group), onPressed: () => {}
        //     Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (_) => GroupChatHomeScreen(),
        //   ),
        // ),
      ),
    );
  }
}
