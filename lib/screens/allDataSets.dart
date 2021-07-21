// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:ongc_intern_2021/Model/transaction.dart';
// import 'package:ongc_intern_2021/utility/boxes.dart';
//
// class TransactionPage extends StatefulWidget {
//   @override
//   _TransactionPageState createState() => _TransactionPageState();
// }
//
// class _TransactionPageState extends State<TransactionPage> {
//   @override
//   void dispose() {
//     Hive.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     appBar: AppBar(
//       title: Text('Hive Expense Tracker'),
//       centerTitle: true,
//     ),
//     body: ValueListenableBuilder<Box<TransAction>>(
//       valueListenable: Boxes.getTransactions().listenable(),
//       builder: (context, box, _) {
//         final transactions = box.values.toList().cast<TransAction>();
//
//         return buildContent(transactions);
//       },
//     ),
//   );
//
//   Widget buildContent(List<TransAction> transactions) {
//     if (transactions.isEmpty) {
//       return Center(
//         child: Text(
//           'No expenses yet!',
//           style: TextStyle(fontSize: 24),
//         ),
//       );
//     } else {
//       final netExpense = transactions.fold<double>(
//         0,
//             (previousValue, transaction) => transaction.isExpense
//             ? previousValue - transaction.message
//             : previousValue + transaction.amount,
//       );
//       final newExpenseString = '\$${netExpense.toStringAsFixed(2)}';
//       final color = netExpense > 0 ? Colors.green : Colors.red;
//
//       return Column(
//         children: [
//           SizedBox(height: 24),
//           Text(
//             'Net Expense: $newExpenseString',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//               color: color,
//             ),
//           ),
//           SizedBox(height: 24),
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(8),
//               itemCount: transactions.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final transaction = transactions[index];
//
//                 return buildTransaction(context, transaction);
//               },
//             ),
//           ),
//         ],
//       );
//     }
//   }
//
//   Widget buildTransaction(
//       BuildContext context,
//       TransAction transaction,
//       ) {
//     final color = transaction.isExpense ? Colors.red : Colors.green;
//     final date = DateFormat.yMMMd().format(transaction.createdDate);
//     final amount = '\$' + transaction.amount.toStringAsFixed(2);
//
//     return Card(
//       color: Colors.white,
//       child: ExpansionTile(
//         tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
//         title: Text(
//           transaction.name,
//           maxLines: 2,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//         ),
//         subtitle: Text(date),
//         trailing: Text(
//           amount,
//           style: TextStyle(
//               color: color, fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         children: [
//           buildButtons(context, transaction),
//         ],
//       ),
//     );
//   }
//
//   Widget buildButtons(BuildContext context, TransAction transaction) => Row(
//     children: [
//       Expanded(
//         child: TextButton.icon(
//           label: Text('Edit'),
//           icon: Icon(Icons.edit),
//           onPressed: () => Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) => TransactionDialog(
//                 transaction: transaction,
//                 onClickedDone: (name, amount, isExpense) =>
//                     editTransaction(transaction, name, amount, isExpense),
//               ),
//             ),
//           ),
//         ),
//       ),
//     ],
//   );
//
//   Future addTransaction(String name, bool isRead, List message) async {
//     final transaction = TransAction()
//       ..name = name
//       ..createdDate = DateTime.now()
//       ..isRead = isRead
//       ..message = message;
//     print("Hive called");
//     final box = Boxes.getTransactions();
//     box.add(transaction);
//     // final box = Boxes.getTransactions();
//
//     // String mykey = getRandomString(15);
//     // box.put(mykey, transaction);
//
//     // final mybox = Boxes.getTransactions();
//     // final myTransaction = mybox.get('key');
//     // mybox.values;
//     // mybox.keys;
//   }
//
//   void editTransaction(
//       TransAction transaction,
//       String name,
//       List message,
//       bool isRead,
//       ) {
//     transaction.name = name;
//     transaction.message = message;
//     transaction.isRead = isRead;
//     transaction.createdDate = DateTime.now();
//     // final box = Boxes.getTransactions();
//     // box.put(transaction.key, transaction);
//
//     transaction.save();
//   }
