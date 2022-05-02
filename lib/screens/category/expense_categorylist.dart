import 'package:flutter/material.dart';

import '../../db/category/category_db.dart';
import '../../db/models/category/category_model.dart';

class expensecategorylist extends StatelessWidget {
  const expensecategorylist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: categorydb().expensecategorylist,
        builder: (BuildContext ctx, List<categorymodel> newlist, Widget? _) {
          return Card(
            child: ListView.separated(
                itemBuilder: (ctx, index) {
                  final _category = newlist[index];
                  return Card(
                    child: ListTile(
                      leading: Text(_category.name),
                      trailing: IconButton(
                          onPressed: () {
                            categorydb.instance.deletecategory(_category.id);
                          },
                          icon: Icon(Icons.delete)),
                    ),
                  );
                },
                separatorBuilder: (ctx, index) {
                  return const SizedBox(
                    height: 10,
                  );
                },
                itemCount: newlist.length),
          );
        });
  }
}
