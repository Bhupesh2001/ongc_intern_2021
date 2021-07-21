import 'package:flutter/material.dart';
import 'package:telephony/telephony.dart';
import 'package:ongc_intern_2021/SMS/sms.dart';

class SmsIndox extends StatefulWidget {
  static String id = "SMS Indox";
  @override
  _SmsIndoxState createState() => _SmsIndoxState();
}

bool back = false;

class _SmsIndoxState extends State<SmsIndox> {
  final telephony = Telephony.instance;
  List list = [];

  @override
  Widget build(BuildContext context) {
    bool reloading = false;
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.play_arrow),
            onPressed: () async {
              reloading = true;

              while (reloading) {
                print("reading.....");
                await SMS().readMessages();
                setState(() {});
                Future.delayed(Duration(seconds: 5));
              }
            }),
        appBar: AppBar(title: Text('Plugin example app')),
        body: ListView.builder(
            itemCount: SMS.inboxMessages.length,
            itemBuilder: (BuildContext context, int index) {
              SmsMessage sms = SMS.inboxMessages[index];
              return Column(
                children: [Text('${sms.body}\n\n\n'), Text("back : = $back\n")],
              );
            }),
      ),
    );
  }
}
