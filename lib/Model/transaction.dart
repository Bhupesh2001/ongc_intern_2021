import 'package:hive/hive.dart';

part 'transaction.g.dart';

@HiveType(typeId: 0)
class TransAction extends HiveObject {
  @HiveField(0)
   String name;

  @HiveField(1)
   DateTime createdDate;

  @HiveField(2)
   bool isRead = false;

  @HiveField(3)
   List message;

   
}
