import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneymanagement/db/category/category_db.dart';
import 'package:moneymanagement/db/models/category/category_model.dart';

ValueNotifier<categorytype> selectedcategory =
    ValueNotifier(categorytype.income);

Future<void> showcategoryaddpopup(BuildContext context) async {
  final _nameeditingcontroller = TextEditingController();
  showDialog(
    context: context,
    builder: (ctx) {
      return SimpleDialog(
        title: const Text("add category"),
        children: [
          Padding(
            padding: EdgeInsets.all(0),
            child: TextFormField(
              controller: _nameeditingcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), hintText: "Category Name"),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(0),
            child: Row(
              children: [
                Radiobutton(title: "income", type: categorytype.income),
                Radiobutton(title: "expense", type: categorytype.expense)
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(0),
              child: ElevatedButton(
                  onPressed: () {
                    final _name = _nameeditingcontroller.text;
                    if (_name.isEmpty) {
                      return;
                    }
                    final _type = selectedcategory.value;
                    final _categorymodel = categorymodel(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        name: _name,
                        type: _type);
                    categorydb.instance.insertcategory(_categorymodel);
                    Navigator.of(ctx).pop();
                  },
                  child: Text("Add")))
        ],
      );
    },
  );
}

class Radiobutton extends StatelessWidget {
  final String title;
  final categorytype type;

  const Radiobutton({Key? key, required this.title, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ValueListenableBuilder(
          valueListenable: selectedcategory,
          builder: (BuildContext ctx, categorytype newcategory, Widget? _) {
            return Radio<categorytype>(
                value: type,
                groupValue: newcategory,
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  selectedcategory.value = value;
                  selectedcategory.notifyListeners();
                });
          }),
      Text(title)
    ]);
  }
}
