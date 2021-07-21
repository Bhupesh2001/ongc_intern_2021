import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:ongc_intern_2021/Model/dataMod.dart';
import 'package:ongc_intern_2021/constants.dart';
import 'package:ongc_intern_2021/database/database.dart';
import 'package:ongc_intern_2021/utility/local_database.dart';

class ChatInputField extends StatefulWidget {
  final DocumentSnapshot doc;
  ChatInputField(this.doc);

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController tecMessage = new TextEditingController();

  sendMessage(String message) async {
    final cryptor = new PlatformStringCryptor();
    final key = await cryptor.generateRandomKey();
    final encrypted = await cryptor.encrypt(message, key);
    String groupId = groupID(widget.doc);
    DocumentReference doc = await FirebaseFirestore.instance
        .collection("Groups")
        .doc(groupId)
        .collection(groupId)
        .add({"encrypted": encrypted, "key": key, "time": Timestamp.now()});

    tecMessage.text = "";

    LocalDB().insertInfo(DataMod(
        id: doc.id,
        anotherId: widget.doc['id'],
        senderId: SharedPrefHelper.myUid(),
        message: encrypted));
    List myData = await LocalDB().getInfo();
    // print(myData);
    for (int i = 0; i < myData.length; i++) {
      DataMod data = myData[i];
      data.display();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 32)],
          color: Colors.blue.shade100),
      child: Row(
        children: [
          SizedBox(width: 5),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20 * 0.75),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
              ),
              child: Row(
                children: [
                  SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: tecMessage,
                      minLines: 1,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "Type message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            onTap: () {
              var currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
              sendMessage(tecMessage.text);
              tecMessage.text = "";
            },
            child: Icon(
              Icons.send,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
