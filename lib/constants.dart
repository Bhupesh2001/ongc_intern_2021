import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ongc_intern_2021/utility/local_database.dart';

void toast(String text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[50],
      textColor: Colors.black,
      fontSize: 16.0);
}

String groupID(DocumentSnapshot doc) {
  String myID = SharedPrefHelper.myUid();
  String otherID = doc['id'];
  if (myID.compareTo(otherID) > 0)
    return '$myID - $otherID';
  else
    return '$otherID - $myID';
}
