import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:ongc_intern_2021/Model/transaction.dart';
import 'package:ongc_intern_2021/constants.dart';
import 'package:ongc_intern_2021/screens/testing.dart';
import 'package:ongc_intern_2021/utility/boxes.dart';
import 'package:telephony/telephony.dart';

class InputScreen extends StatefulWidget {
  static String id = "InputScreen";
  const InputScreen({Key key}) : super(key: key);

  @override
  _InputScreenState createState() => _InputScreenState();
}

bool autoFilled = false;
bool isSent = false;
bool saved = false;
bool autoSaved = false;

class _InputScreenState extends State<InputScreen> {
  List<List<String>> a;
  ScrollController scrollController = ScrollController();
  List<TransAction> transactions = [];
  List data = List.filled(21, '');
  List m = List.filled(21, "");

  @override
  Widget build(BuildContext context) {
    DateTime _selectedValue = DateTime.now();
    return Scaffold(
      backgroundColor: Colors.grey[500],
      body: ValueListenableBuilder<Box<TransAction>>(
        valueListenable: Boxes.getTransactions().listenable(),
        builder: (BuildContext context, box, _) {
          transactions = box.values.toList().cast<TransAction>();
          if (transactions.isEmpty) {
            print("Empty");
            return SafeArea(
              child: SingleChildScrollView(
                child: Body(context, _selectedValue),
              ),
            );
          } else {
            data = transactions[0].message;
            print(data);
            return SafeArea(
              child: SingleChildScrollView(
                child: Body(context, _selectedValue),
              ),
            );
          }
        },
      ),
    );
  }

  Column Body(BuildContext context, DateTime _selectedValue) {
    return Column(
      children: [
        header(),
        DatePicker(
          DateTime.now(),
          initialSelectedDate: DateTime.now(),
          selectionColor: Colors.black,
          selectedTextColor: Colors.white,
          daysCount: 20,
          onDateChange: (date) {
            setState(() {
              _selectedValue = date;
            });
          },
        ),
        SizedBox(height: 50),
        Padding(
          padding: const EdgeInsets.only(bottom: 58.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: autoFilled
                ? MyTable.displayTable(context, data)
                : MyTable.displayTable(context, List.filled(21, '')),
          ),
        ),
        if (isSent)
          Text(
            "Project completed",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          )
      ],
    );
  }

  Widget header() {
    return Row(
      children: [
        SizedBox(height: 60, width: 100),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Opacity(
            opacity: saved || isSent ? 0.5 : 1,
            child: ElevatedButton(
                onPressed: () {
                  if (saved) {
                    toast("Already Saved");
                    return;
                  }
                  try {
                    editTransaction(
                        transactions[0], 'dummy', MyTable.getData(), false);
                  } catch (e) {
                    addTransaction("dummy", false, MyTable.getData());
                  }
                  setState(() {
                    saved = true;
                    autoFilled = true;
                  });
                  print(m);
                  print("Save");
                },
                child: Text("Save")),
          ),
        ),
        Opacity(
          opacity: isSent ? 0.5 : 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: ElevatedButton(
              onPressed: () {
                if (isSent) {
                  toast("Already Sent");
                  return;
                }
                reportSend(MyTable.getData());
                setState(() {
                  isSent = true;
                });
              },
              child: Text("Sent"),
            ),
          ),
        ),
        Opacity(
          opacity: autoFilled || isSent ? 0.5 : 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  autoFilled = !autoFilled;
                });
              },
              child: autoFilled ? Text("Clear") : Text("Auto Filled"),
            ),
          ),
        ),
      ],
    );
  }

  Future addTransaction(String name, bool isRead, List message) async {
    final transaction = TransAction()
      ..name = name
      ..createdDate = DateTime.now()
      ..isRead = isRead
      ..message = message;
    print("Hive called");
    final box = Boxes.getTransactions();
    box.add(transaction);
  }

  void editTransaction(
    TransAction transaction,
    String name,
    List message,
    bool isRead,
  ) {
    transaction.name = name;
    transaction.message = message;
    transaction.isRead = isRead;
    transaction.createdDate = DateTime.now();
    transaction.save();
  }
}

void reportSend(List<String> data) async {
  final Telephony telephony = Telephony.instance;
  await telephony.sendSms(
      to: "7906573815", message: "ONGC Report " + data.join(" "));
}
