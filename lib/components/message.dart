// import 'package:flutter/material.dart';
// import 'package:ongc_intern_2021/utility/local_database.dart';
//
// class Message extends StatelessWidget {
//   final doc;
//
//   const Message(this.doc);
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: isSender()
//           ? EdgeInsets.only(top: 10, right: 10)
//           : EdgeInsets.only(top: 10, left: 3),
//       child: Column(
//         children: [
//           Padding(
//             padding: isSender()
//                 ? EdgeInsets.only(right: 29, top: 1)
//                 : EdgeInsets.only(left: 45, top: 1),
//             child: Opacity(
//               opacity: 0.5,
//               child: Text(
//                 '',
//                 // timeInHourMinFormat(doc['sendTime']),
//                 // timeInAgoFormat(doc['sendTime']),
//                 style: TextStyle(fontSize: 10, wordSpacing: 2),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
