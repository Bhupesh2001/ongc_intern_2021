import 'package:flutter/cupertino.dart';

class DataMod {
  final String id;
  final String anotherId;
  final String senderId;
  final String message;

  DataMod(
      {@required this.id,
      @required this.anotherId,
      @required this.senderId,
      @required this.message});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'anotherId': anotherId,
      'senderId': senderId,
      'message': message,
    };
  }

  display() {
    print(
        "id : $id\nanotherId : $anotherId\nsenderId : $senderId\nmessage : $message");
  }
}
