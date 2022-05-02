import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/models/category/category_model.dart';
import 'package:moneymanagement/db/transactions/transactions_db.dart';

import '../../db/models/transaction/transaction_model.dart';

class screentransactions extends StatelessWidget {
  const screentransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    transactionDb().refresh();
    categorydb().refreshUi();
    return ValueListenableBuilder(
        valueListenable: transactionDb.instance.transactionlistener,
        builder:
            (BuildContext ctx, List<transacctionalmodel> newlist, Widget? _) {
          return ListView.separated(
              itemBuilder: (ctx, index) {
                final _item = newlist[index];
                return Card(
                    elevation: 0,
                    child: ListTile(
                      leading: CircleAvatar(
                          backgroundColor: _item.type == categorytype.expense
                              ? Colors.red
                              : Colors.green,
                          radius: 50,
                          child: Text(
                            parsedate(_item.date),
                            textAlign: TextAlign.center,
                          )),
                      title: Text("Rs${_item.amount}"),
                      subtitle: Text(
                        _item.type.name,
                      ),
                      trailing: IconButton(
                          onPressed: () {
                            // transactionDb.instance.deletecategory(_item.id!);
                          },
                          icon: const Icon(Icons.delete)),
                    ));
              },
              separatorBuilder: (ctx, index) {
                return const SizedBox(
                  height: 10,
                );
              },
              itemCount: newlist.length);
        });
  }

  String parsedate(DateTime date) {
    final _date = DateFormat.MMMd().format(date);
    final _sdate = _date.split(" ");
    return "${_sdate.last}\n${_sdate.first}";

    //return '${date.day}/n${date.month}';
  }
}
