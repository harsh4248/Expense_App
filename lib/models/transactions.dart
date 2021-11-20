import 'package:flutter/foundation.dart';

class Transaction {
  String id;
  String title;
  double amount;
  DateTime date;

  // Transaction({String id,String title,String amount,DateTime date}) {
  //   this.id = id;
  // }
  Transaction(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}
