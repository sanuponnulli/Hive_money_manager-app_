import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/category/screencategory.dart';
import 'package:moneymanagement/screens/home/widgets/bottom_navigation.dart';
import 'package:moneymanagement/screens/transactions/screentransaction.dart';

class screenhome extends StatelessWidget {
  screenhome({Key? key}) : super(key: key);
  static ValueNotifier<int> selectedindexnotifier = ValueNotifier(0);
  final _pages = [
    const screencategory(),
    const screentransactions(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: moneymanagerbottomnavigation(),
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: selectedindexnotifier,
            builder: (BuildContext ctx, int index, Widget? _) {
              return _pages[index];
            }),
      ),
    );
  }
}
