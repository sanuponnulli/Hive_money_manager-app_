import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/screens/category/expense_categorylist.dart';
import 'package:moneymanagement/screens/category/income_categorylist.dart';

class screencategory extends StatefulWidget {
  const screencategory({Key? key}) : super(key: key);

  @override
  State<screencategory> createState() => _screencategoryState();
}

class _screencategoryState extends State<screencategory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    categorydb().refreshUi();
    // categorydb().getcategory().then((value) {
    //   print("get category");
    //   print(value.toString());
    // });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
            controller: _tabController,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.green,
            tabs: const [
              Tab(
                text: "income",
              ),
              Tab(
                text: "expense",
              )
            ]),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              incomecategorylist(),
              expensecategorylist(),
            ],
          ),
        ),
      ],
    );
  }
}
