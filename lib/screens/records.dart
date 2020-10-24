import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:option_chooser/models/list.dart';

class MyRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Records Screen')),
      body: Consumer<ListModel>(
        builder: (context, list, child) => ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: list.records.list.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text('${list.records.list[index].title}'),
                subtitle: Text(
                    'Completed on ${list.records.list[index].finishedDate}'),
              );
            }),
      ),
    );
  }
}
