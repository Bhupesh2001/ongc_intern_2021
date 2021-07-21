import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ongc_intern_2021/screens/messaging_screen.dart';
import 'package:ongc_intern_2021/utility/local_database.dart';

class ChatCard extends StatelessWidget {
  final doc;
  ChatCard(this.doc);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SharedPrefHelper.myUid() != doc['id']
        ? InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessageScreen(doc)));
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: size.width * (0.045 - 0.008),
                  vertical: size.width * 0.045),
              child: CardRow(
                name: " ",
                senderMe: doc['id'] == SharedPrefHelper.myUid(),
                messageTime: '',
                doc: doc,
              ),
            ),
          )
        : SizedBox.shrink();
  }
}

class CardRow extends StatelessWidget {
  const CardRow({
    Key key,
    @required this.name,
    @required this.senderMe,
    @required this.messageTime,
    @required this.doc,
  }) : super(key: key);

  final String name;
  final bool senderMe;
  final String messageTime;
  final DocumentSnapshot doc;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: size.width * (0.045 - 0.008)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: size.width * 0.012),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
