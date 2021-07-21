// import 'package:flutter/material.dart';
//
// Widget inputPageBody() {
//   return SafeArea(
//     child: SingleChildScrollView(
//       child: Column(
//         children: [
//           header(),
//           DatePicker(
//             DateTime.now(),
//             initialSelectedDate: DateTime.now(),
//             selectionColor: Colors.black,
//             selectedTextColor: Colors.white,
//             daysCount: 50,
//             onDateChange: (date) {
//               setState(() {
//                 _selectedValue = date;
//               });
//             },
//           ),
//           SizedBox(height: 50),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 58.0),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: dataBody(),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
