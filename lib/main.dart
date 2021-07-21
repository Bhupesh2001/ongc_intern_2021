import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:ongc_intern_2021/database/database.dart';
import 'package:ongc_intern_2021/screens/checking%20screen.dart';
import 'package:ongc_intern_2021/screens/employee_home.dart';
import 'package:ongc_intern_2021/screens/input_screen.dart';
import 'package:ongc_intern_2021/screens/messaging_screen.dart';
import 'package:ongc_intern_2021/screens/smsIndox.dart';
import 'package:ongc_intern_2021/utility/local_database.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'Model/transaction.dart';
import 'screens/employee_login_page.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(TransActionAdapter());
  await Hive.openBox<TransAction>('transactions');

  SharedPrefHelper.pref = await SharedPreferences.getInstance();
  LocalDB.database = openDatabase(
    join(await getDatabasesPath(), 'message_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE message(id STRING PRIMARY KEY, anotherId TEXT NOT NULL, senderId TEXT NOT NULL, message TEXT NOT NULL)',
      );
    },
    version: 1,
  );
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ONGC',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SharedPrefHelper.pref.getBool("isLoggedIn") ?? false
          ? EmployeeHome()
          : EmployeeLoginPage(),
      // home: EmployeeHome(),
      routes: {
        EmployeeLoginPage.id: (context) => EmployeeLoginPage(),
        EmployeeHome.id: (context) => EmployeeHome(),
        MessageScreen.id: (context) => MessageScreen(null),
        CheckingPage.checkingPage: (context) => CheckingPage(null),
        InputScreen.id: (context) => InputScreen(),
        SmsIndox.id: (context) => SmsIndox()
      },
    );
  }
}
