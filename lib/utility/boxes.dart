
import 'package:hive/hive.dart';
import 'package:ongc_intern_2021/Model/transaction.dart';


class Boxes {
  static Box<TransAction> getTransactions() =>
      Hive.box<TransAction>('transactions');
}