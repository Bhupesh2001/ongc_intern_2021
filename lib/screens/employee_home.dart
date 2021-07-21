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
        child: Icon(Icons.refresh),
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
                TextEditingController tecCurrent = TextEditingController();
                TextEditingController tecNew = TextEditingController();
                TextEditingController tecConfirm = TextEditingController();
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Change password"),
                        actions: [
                          InkWell(
                            onTap: () async {
                              var path = FirebaseFirestore.instance
                                  .collection("Employee")
                                  .doc(SharedPrefHelper.myUid());
                              DocumentSnapshot doc = await path.get();
                              String currentPass = doc['password'].toString();
                              if (tecCurrent.text == currentPass) {
                                if (tecNew.text == tecConfirm.text &&
                                    tecConfirm.text.length > 2)
                                  path.update({"password": tecNew.text}).then(
                                      (value) {
                                    Navigator.pop(context);
                                    toast("Update Successful");
                                  });
                                else
                                  toast("Enter a valid password");
                              } else
                                toast("Incorrect password");
                            }, //Todo Update password
                            child: Text(
                              "Done",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                                decoration: InputDecoration(
                                    hintText: "Current Password"),
                                controller: tecCurrent),
                            TextField(
                                decoration:
                                    InputDecoration(hintText: "New Password"),
                                controller: tecNew),
                            TextField(
                                decoration: InputDecoration(
                                    hintText: "Confirm Password"),
                                controller: tecConfirm),
                          ],
                        ),
                      );
                    });
              },
              child: Icon(Icons.vpn_key),
            ),
          ),
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
