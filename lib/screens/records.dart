import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:option_chooser/models/list.dart';
import 'package:option_chooser/models/dbControl.dart';
import 'package:option_chooser/models/item.dart';

class MyRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Records Screen')),
        body: FutureBuilder<List<Item>>(
            future:
                Provider.of<DbControl>(context, listen: true).retrieveRecords(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                        title: Text('${snapshot.data[index].title}'),
                        subtitle: Text(
                            'Complete on ${snapshot.data[index].finishedDate}'));
                  },
                );
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Oops!');
              }
              return Center(child: CircularProgressIndicator());
            }));
  }
}
