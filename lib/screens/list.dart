import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:option_chooser/models/list.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var list = context.watch<ListModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Options Screen'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.add_circle),
          //   onPressed: () => Navigator.pushNamed(context, '/add-edit'),
          // ),
          IconButton(
            // when pressed will add new entry
            icon: Icon(Icons.add_circle),
            onPressed: () {
              var listAdd = context.read<ListModel>();
              listAdd.add('test');
            },
          ),
          IconButton(
            icon: Icon(Icons.android),
            onPressed: () => Navigator.pushNamed(context, '/records'),
          ),
        ],
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: list.list.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 50,
                color: Colors.amber[50 * (index + 1)],
                child:
                    Center(child: Text('${list.list[index].title}${index}')));
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Random selection',
        child: Icon(Icons.add),
      ),
    );
  }
}
