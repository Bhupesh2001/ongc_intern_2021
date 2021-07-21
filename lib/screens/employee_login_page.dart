import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ongc_intern_2021/screens/checking%20screen.dart';
import 'package:telephony/telephony.dart';
import '../constants.dart';

class EmployeeLoginPage extends StatefulWidget {
  static String id = "Employee Login";

  @override
  _EmployeeLoginPageState createState() => _EmployeeLoginPageState();
}

class _EmployeeLoginPageState extends State<EmployeeLoginPage> {
  TextEditingController tecID = new TextEditingController();
  TextEditingController tecPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.1),
            Center(
                child: Image.asset(
              "images/ongclogo.png",
              width: size.width * 0.4,
            )),
            SizedBox(height: size.height * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.06, horizontal: size.width * 0.3),
              child: TextField(
                keyboardType: TextInputType.emailAddress,
                controller: tecID,
                decoration: InputDecoration(hintText: "ONGC ID"),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.3),
              child: TextField(
                controller: tecPassword,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: "Password"),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: size.height * 0.05),
            InkWell(
              onTap: () async {
                var currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();

                if (tecID.text.isEmpty && tecPassword.text.isEmpty) {
                  toast("Fill the credentials");
                  return;
                }
                var connectivityResult =
                    await (Connectivity().checkConnectivity());

                bool isOnline =
                    connectivityResult == ConnectivityResult.mobile ||
                        connectivityResult == ConnectivityResult.wifi;

                if (isOnline) {
                  FirebaseFirestore.instance
                      .collection("Requests")
                      .doc(tecID.text)
                      .set({
                    'id': tecID.text,
                    'password': tecPassword.text,
                    'time': Timestamp.now(),
                    "approved": false
                  });
                } else {
                  final Telephony telephony = Telephony.instance;
                  telephony.sendSms(
                      to: "7253018338",
                      message: "ONGC\t${tecID.text}\t${tecPassword.text}");
                }

                toast("Requested Successfully");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckingPage(tecID.text)));
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Request",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.blue,
                      fontSize: 20),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(height: size.height * 0.02),
            InkWell(
              onTap: () {
                toast("A new Employee can only be added by Admin");
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info, color: Colors.blue[300], size: 20),
                  Text(
                    " Know more ?",
                    style: TextStyle(color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
