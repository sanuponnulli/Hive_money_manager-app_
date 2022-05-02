import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/models/category/category_model.dart';

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
  String? categoryID;
  @override
  void initState() {
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
              keyboardType: TextInputType.text,
              decoration: InputDecoration(hintText: "purpose"),
            ),
            TextFormField(
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
                icon: Icon(Icons.calendar_today),
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
                            categoryID = null;
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
                            categoryID = null;
                          });
                        }),
                    Text("expense"),
                  ],
                ),
              ],
            ),
            DropdownButton<String>(
                hint: Text("select category"),
                value: categoryID,
                items: (_selectedcategorytype == categorytype.income
                        ? categorydb().incomecategorylist
                        : categorydb().expensecategorylist)
                    .value
                    .map((e) {
                  return DropdownMenuItem(
                    child: Text(e.name),
                    value: e.id,
                  );
                }).toList(),
                onChanged: (selectedvalue) {
                  print("selected value");
                  setState(() {
                    categoryID = selectedvalue;
                  });
                }),
            ElevatedButton(onPressed: () {}, child: Text("submit"))
          ],
        ),
      )),
    );
  }
}
