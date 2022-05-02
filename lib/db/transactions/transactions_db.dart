import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:moneymanagement/db/models/transaction/transaction_model.dart';

const DB_NAME = "TRANSACTION-DATABASE";

abstract class transactionsdbfunctions {
  Future<void> addtransactions(transacctionalmodel obj);
  Future<List<transacctionalmodel>> getalltransactions();
  Future<void> deletecategory(String id);
}

class transactionDb implements transactionsdbfunctions {
  transactionDb._internal();
  static transactionDb instance = transactionDb._internal();
  factory transactionDb() {
    return instance;
  }
  ValueNotifier<List<transacctionalmodel>> transactionlistener =
      ValueNotifier([]);
  @override
  Future<void> addtransactions(transacctionalmodel obj) async {
    final _db = await Hive.openBox<transacctionalmodel>(DB_NAME);
    await _db.put(obj.id, obj);
  }

  Future<void> refresh() async {
    final _result = await getalltransactions();
    _result.sort((f, s) => s.date.compareTo(f.date));
    transactionlistener.value.clear();
    transactionlistener.value.addAll(_result);
    transactionlistener.notifyListeners();
  }

  @override
  Future<List<transacctionalmodel>> getalltransactions() async {
    final _db = await Hive.openBox<transacctionalmodel>(DB_NAME);
    return _db.values.toList();
  }

  @override
  Future<void> deletecategory(String id) async {
    final _categorydb = await Hive.openBox<transacctionalmodel>(DB_NAME);
    await _categorydb.delete(id);
    refresh();
  }
}
