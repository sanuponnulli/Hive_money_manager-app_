import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/models/category/category_model.dart';
import 'package:moneymanagement/db/models/transaction/transaction_model.dart';
import 'package:moneymanagement/db/transactions/transactions_db.dart';

class Screenaddtransactions extends StatefulWidget {
  static const routeName = "add-transaction";
  const Screenaddtransactions({Key? key}) : super(key: key);

  @override
  State<Screenaddtransactions> createState() => _ScreenaddtransactionsState();
}

class _ScreenaddtransactionsState extends State<Screenaddtransactions> {
  DateTime? _selecteddate;
  categorytype? _selectedcategorytype;
  categorymodel? _selectedcategorymodel;
  String? _categoryID;

  final _amountcontroller = TextEditingController();
  final _purposecontroller = TextEditingController();
  @override
  void initState() {
    categorydb.instance.refreshUi();
    _selectedcategorytype = categorytype.income;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _purposecontroller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "purpose"),
            ),
            TextFormField(
              controller: _amountcontroller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "amount"),
            ),
            // if (_selecteddate == null)
            TextButton.icon(
                onPressed: () async {
                  final _selecteddatetemp = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now().subtract(Duration(days: 30)),
                      lastDate: DateTime.now());
                  if (_selecteddatetemp == null) {
                    return;
                  }
                  print(_selecteddatetemp.toString());
                  setState(() {
                    _selecteddate = _selecteddatetemp;
                  });
                },
                icon: const Icon(Icons.calendar_today),
                label: Text(_selecteddate == null
                    ? "select date"
                    : _selecteddate.toString()))
            // else
            //   Text(_selecteddate.toString()),
            ,
            Row(
              children: [
                Row(
                  children: [
                    Radio(
                        value: categorytype.income,
                        groupValue: _selectedcategorytype,
                        onChanged: (newvalue) {
                          setState(() {
                            _selectedcategorytype = categorytype.income;
                            _categoryID = null;
                          });
                        }),
                    Text("income"),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                        value: categorytype.expense,
                        groupValue: _selectedcategorytype,
                        onChanged: (newvalue) {
                          setState(() {
                            _selectedcategorytype = categorytype.expense;
                            _categoryID = null;
                          });
                        }),
                    const Text("expense"),
                  ],
                ),
              ],
            ),
            DropdownButton<String>(
                hint: Text("select category"),
                value: _categoryID,
                items: (_selectedcategorytype == categorytype.income
                        ? categorydb().incomecategorylist
                        : categorydb().expensecategorylist)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    child: Text(e.name),
                    value: e.id,
                    onTap: () {
                      _selectedcategorymodel = e;
                    },
                  );
                }).toList(),
                onChanged: (selectedvalue) {
                  // print("selected value");
                  setState(() {
                    _categoryID = selectedvalue;
                  });
                }),
            ElevatedButton(
                onPressed: () async {
                  await addtransactions();
                },
                child: Text("submit"))
          ],
        ),
      )),
    );
  }

  Future<void> addtransactions() async {
    final _purposetext = _purposecontroller.text;
    final _amounttext = _amountcontroller.text;

    if (_purposetext.isEmpty) {
      return print("object");
    }
    if (_amounttext.isEmpty) {
      return print("object");
    }
    if (_categoryID == null) {
      return print("object");
    }
    if (_selecteddate == null) {
      return print("object");
    }
    if (_selectedcategorymodel == null) {
      return print("object");
    }
    final _parseamount = double.tryParse(_amounttext);
    if (_parseamount == null) {
      return print("object");
    }

    final _obj = transacctionalmodel(
        purpose: _purposetext,
        amount: _parseamount,
        date: _selecteddate!,
        type: _selectedcategorytype!,
        model: _selectedcategorymodel!);
    await transactionDb().addtransactions(_obj);
    Navigator.of(context).pop();
    transactionDb.instance.refresh();
  }
}
