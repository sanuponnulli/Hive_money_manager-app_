import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive/hive.dart';
import 'package:moneymanagement/db/models/category/category_model.dart';
import 'package:moneymanagement/screens/category/income_categorylist.dart';

const CATEGORY_DB_NAME = "CATEGORY-DATABASE";

abstract class categorydbfunctions {
  Future<void> insertcategory(categorymodel value);
  Future<List<categorymodel>> getcategory();
  Future<void> refreshUi();
  Future<void> deletecategory(String categoryid);
}

class categorydb extends categorydbfunctions {
  ValueNotifier<List<categorymodel>> incomecategorylist = ValueNotifier([]);
  ValueNotifier<List<categorymodel>> expensecategorylist = ValueNotifier([]);
  categorydb._internal();
  static categorydb instance = categorydb._internal();
  factory categorydb() {
    return instance;
  }
  @override
  Future<void> insertcategory(categorymodel value) async {
    final _categorydb = await Hive.openBox<categorymodel>(CATEGORY_DB_NAME);
    await _categorydb.put(value.id, value);
    // await _categorydb.clear();
    refreshUi();
  }

  @override
  Future<List<categorymodel>> getcategory() async {
    final _categorydb = await Hive.openBox<categorymodel>(CATEGORY_DB_NAME);
    return _categorydb.values.toList();
  }

  @override
  Future<void> refreshUi() async {
    final _allcategories = await getcategory();
    incomecategorylist.value.clear();
    expensecategorylist.value.clear();
    Future.forEach(_allcategories, (categorymodel category) {
      if (category.type == categorytype.income) {
        incomecategorylist.value.add(category);
      } else {
        expensecategorylist.value.add(category);
      }
    });
    incomecategorylist.notifyListeners();
    expensecategorylist.notifyListeners();
  }

  @override
  Future<void> deletecategory(String categoryid) async {
    final _categorydb = await Hive.openBox<categorymodel>(CATEGORY_DB_NAME);
    await _categorydb.delete(categoryid);
    refreshUi();
  }
}
