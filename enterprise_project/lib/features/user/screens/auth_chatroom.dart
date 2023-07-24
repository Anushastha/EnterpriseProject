import 'package:cloud_firestore/cloud_firestore.dart';

class UserAuths {
  static final UserAuths _instance = UserAuths._internal();

  String fname = "";
  String lname = "";
  String contactNo = "";
  List chatIds = [];
  List sentBy = [];

  factory UserAuths() {
    return _instance;
  }

  UserAuths._internal();

  // Add your singleton methods and properties here
  void doSomething() {
    print('Doing something...');
  }

  List<T> removeAlternateItems<T>(List<T> originalList, bool keepEvenIndices) {
    List<T> resultList = [];
    for (int i = 0; i < originalList.length; i++) {
      if (keepEvenIndices && i % 2 == 0) {
        resultList.add(originalList[i]);
      } else if (!keepEvenIndices && i % 2 != 0) {
        resultList.add(originalList[i]);
      }
    }
    return resultList;
  }

  Future<List<String>> fetchDocumentIdsFromCollection() async {
    List<String> documentIds = [];
    UserAuths thisUser = new UserAuths();

    try {
      QuerySnapshot snapshot =
      await FirebaseFirestore.instance.collection("allchats").get();
      if (snapshot != null) {
        snapshot.docs.forEach((document) {
          if (document.id.contains(thisUser.contactNo)) {
            chatIds.add(document.id);
            print(document.id.toString() + " Here Here");
          }
          print("loop");
        });
      }
    } catch (e) {
      // Handle any potential errors here
      print('Error fetching document IDs: $e');
    }

    List<dynamic> evenIndicesList = removeAlternateItems(chatIds, true);

    chatIds = evenIndicesList;

    print(chatIds.toString());

    await getSentData();

    return documentIds;
  }

  Future getSentData() async {
    for (var i = 0; i < chatIds.length; i++) {
      final data = await FirebaseFirestore.instance //here
          .collection("allchats")
          .doc(chatIds[i])
          .get();

      final val = data.data()?["sendby"].toString();
      // print(val.toString() + i.toString());
      sentBy.add(val);
    }
    print(sentBy.toString());
    print(chatIds.toString());

    // print(sentBy.toString() + " from hereeee");
    // print(chatIds.length);
  }
}
