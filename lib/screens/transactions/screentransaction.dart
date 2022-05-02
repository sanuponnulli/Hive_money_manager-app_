import 'package:flutter/material.dart';

class screentransactions extends StatelessWidget {
  const screentransactions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (ctx, index) {
          return const Card(
              elevation: 0,
              child: ListTile(
                leading: CircleAvatar(
                    radius: 50,
                    child: Text(
                      "9 may",
                      textAlign: TextAlign.center,
                    )),
                title: Text("100000"),
                subtitle: Text(
                  "category",
                ),
              ));
        },
        separatorBuilder: (ctx, index) {
          return const SizedBox(
            height: 10,
          );
        },
        itemCount: 30);
  }
}
