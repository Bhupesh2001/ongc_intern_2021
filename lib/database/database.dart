import 'package:ongc_intern_2021/Model/dataMod.dart';
import 'package:sqflite/sqflite.dart';

class LocalDB {
  static var database;

  Future<void> insertInfo(DataMod data) async {
    final db = await database;
    await db.insert(
      'message',
      data.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<DataMod>> getInfo() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('message');
    return List.generate(maps.length, (i) {
      return DataMod(
          id: maps[i]['id'],
          anotherId: maps[i]['anotherId'],
          message: maps[i]['message'],
          senderId: maps[i]['isSenderMe']);
    });
  }
}
