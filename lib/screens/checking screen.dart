import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ongc_intern_2021/screens/employee_home.dart';
import 'package:ongc_intern_2021/screens/employee_login_page.dart';
import 'package:ongc_intern_2021/utility/local_database.dart';
import 'package:telephony/telephony.dart';

class CheckingPage extends StatefulWidget {
  static String checkingPage;
  final String id;
  CheckingPage(this.id);

  @override
  _CheckingPageState createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> {
  String _message = "";
  final telephony = Telephony.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Requests")
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          try {
            if (SharedPrefHelper.pref.getBool("isLoggedIn") ?? false)
              return EmployeeHome();
            else {
              if (snapshot.hasData && snapshot.data['approved']) {
                print(5);
                FirebaseFirestore.instance
                    .collection("Requests")
                    .doc(widget.id)
                    .delete();
                SharedPrefHelper.pref.setBool("isLoggedIn", true);
                return EmployeeHome();
              } else {
                print(6);
                return Center(child: CircularProgressIndicator());
              }
            }
          } catch (e) {
            return Center(
              child: Text(
                'You are not verified',
                style: TextStyle(fontSize: 30),
              ),
            );
          }
        },
      ),
    );
  }
}
