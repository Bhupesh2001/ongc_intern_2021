import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ongc_intern_2021/screens/employee_home.dart';
import 'package:ongc_intern_2021/screens/input_screen.dart';
import 'package:ongc_intern_2021/screens/smsIndox.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(fontSize: 28);
    Size size = MediaQuery.of(context).size;
    return Container(
      color: Colors.blue[100],
      width: size.width * 0.7,
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.05),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, EmployeeHome.id, (route) => false);
                },
                child: Text("Home", style: textStyle)),
            SizedBox(height: size.height * 0.05),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, InputScreen.id);
                },
                child: Text("Input", style: textStyle)),
            ElevatedButton(onPressed: (){Navigator.pop(context);
                  Navigator.pushNamed(context, SmsIndox.id);},
                   child: Text('SMS Indox'))    
          ],
        ),
      ),
    );
  }
}
