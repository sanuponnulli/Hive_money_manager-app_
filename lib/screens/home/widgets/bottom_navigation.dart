import 'package:flutter/material.dart';
import 'package:moneymanagement/screens/home/screenhome.dart';

class moneymanagerbottomnavigation extends StatelessWidget {
  const moneymanagerbottomnavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: screenhome.selectedindexnotifier,
      builder: (BuildContext ctx, int updatedindexindex, Widget? _) {
        return BottomNavigationBar(
            currentIndex: updatedindexindex,
            onTap: (newindex) {
              screenhome.selectedindexnotifier.value = newindex;
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "transactions"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.category), label: "category")
            ]);
      },
    );
  }
}
