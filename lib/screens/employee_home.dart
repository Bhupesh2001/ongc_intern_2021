import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ongc_intern_2021/components/Chat_Card.dart';
import 'package:ongc_intern_2021/constants.dart';
import 'package:ongc_intern_2021/screens/employee_login_page.dart';
import 'package:ongc_intern_2021/utility/local_database.dart';

import 'drawer.dart';

class EmployeeHome extends StatelessWidget {
  static String id = "Employee Name";
  static String javaName;
  static const platform = const MethodChannel("com.flutter.epic/epic");
  void refresh() async {
    List value;
    try {
      value = await platform.invokeListMethod("refresh");
    } catch (e) {
      print(e);
    }
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.file_upload),
        onPressed: refresh,
      ),
      drawer: MyDrawer(),
      appBar: AppBar(
        title: Text("ONGC's Employee"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                SharedPrefHelper.pref.setBool("isLoggedIn", false);
                Navigator.pushNamedAndRemoveUntil(
                    context, EmployeeLoginPage.id, (route) => false);
              },
              child: Icon(Icons.exit_to_app),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.indigo[400],
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("Employee").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null)
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (listContext, index) {
                  if (snapshot.data.docs.length > 0)
                    return ChatCard(snapshot.data.docs[index]);
                  else
                    return Expanded(
                        child: Text("Seems you have not added any chats"));
                });
          else
            return Text("Loading");
        },
      ),
    );
  }
}
