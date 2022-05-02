import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/models/category/category_model.dart';
import 'package:moneymanagement/db/transactions/transactions_db.dart';
import 'package:moneymanagement/screens/add_transactions/screen_add_transaction.dart';
import 'package:moneymanagement/screens/category/categoryaddpopup.dart';
import 'package:moneymanagement/screens/category/screencategory.dart';
import 'package:moneymanagement/screens/home/widgets/bottom_navigation.dart';
import 'package:moneymanagement/screens/transactions/screentransaction.dart';

class screenhome extends StatelessWidget {
  screenhome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedindexnotifier = ValueNotifier(0);
  final _pages = [
    const screentransactions(),
    const screencategory(),
  ];
  @override
  Widget build(BuildContext context) {
    categorydb.instance.refreshUi();
    transactionDb.instance.refresh();
    return Scaffold(
        appBar: AppBar(
          title: Text("MONEY MANAGER"),
        ),
        bottomNavigationBar: moneymanagerbottomnavigation(),
        body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: selectedindexnotifier,
              builder: (BuildContext ctx, int index, Widget? _) {
                return _pages[index];
              }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (selectedindexnotifier.value == 0) {
              print("add transaction");
              Navigator.of(context).pushNamed(Screenaddtransactions.routeName);
            } else {
              print("add category");
              showcategoryaddpopup(context);
              // final _sample = categorymodel(
              //     id: DateTime.now().millisecondsSinceEpoch.toString(),
              //     name: "travel",
              //     type: categorytype.expense);
              // categorydb().insertcategory(_sample);
            }
          },
          child: Icon(Icons.add),
        ));
  }
}
