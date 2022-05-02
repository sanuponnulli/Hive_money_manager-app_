import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement/db/models/category/category_model.dart';
part 'transaction_model.g.dart';

@HiveType(typeId: 3)
class transacctionalmodel {
  @HiveField(0)
  final String purpose;
  @HiveField(1)
  final double amount;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final categorytype type;
  @HiveField(4)
  final categorymodel model;
  @HiveField(5)
  String? id;

  transacctionalmodel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.model,
  }) {
    id = DateTime.now().millisecondsSinceEpoch.toString();
  }
}
