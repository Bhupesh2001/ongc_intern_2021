import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_string_encryption/flutter_string_encryption.dart';
import 'package:ongc_intern_2021/components/message_input.dart';
import 'package:ongc_intern_2021/constants.dart';

class MessageScreen extends StatefulWidget {
  static String id = "message screen";
  final DocumentSnapshot docs;
  const MessageScreen(this.docs);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  ScrollController scrollController = ScrollController();

  Future<String> encryptMessage(DocumentSnapshot docs) {
    final cryptor = new PlatformStringCryptor();
    final decrypted = cryptor.decrypt(docs["encrypted"], docs["key"]);
    return decrypted;
  }

  @override
  Widget build(BuildContext context) {
    String groupChatId = groupID(widget.docs);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Groups')
            .doc(groupChatId)
            .collection(groupChatId)
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemBuilder: (listContext, index) => Container(
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      color: Colors.blue,
                      child: FutureBuilder(
                          future: encryptMessage(snapshot.data.docs[index]),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData && snapshot.data != null)
                              return Text(snapshot.data);
                            else
                              return SizedBox.shrink();
                          }),
                    ),
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                  ),
                ),
                ChatInputField(widget.docs),
              ],
            );
          } else {
            return Center(
              child: SizedBox(
                height: 36,
                width: 36,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
