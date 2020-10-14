import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:option_chooser/models/list.dart';
import 'package:option_chooser/screens/dialog.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options Screen'),
        actions: [
          IconButton(
            // when pressed will add new entry
            icon: Icon(Icons.add_circle),
            onPressed: () {
              // var listAdd = context.read<ListModel>();
              // listAdd.add('test');
              // return showDialog(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return Dialog(
              //         shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(50),
              //         ),
              //         elevation: 6,
              //         backgroundColor: Colors.blue[100],
              //         child: Text('Testing Dialog'),
              //       );
              //     });
              return DialogWithTextField();
            },
          ),
          IconButton(
            icon: Icon(Icons.android),
            onPressed: () => Navigator.pushNamed(context, '/records'),
          ),
        ],
      ),
      body: Consumer<ListModel>(
          builder: (context, list, child) => ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: list.list.length,
                itemBuilder: (BuildContext context, int index) {
                  return _MyListItem('${list.list[index].title}${index}');
                },
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Random selection',
        child: Icon(Icons.add),
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final String title;

  _MyListItem(this.title, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: LimitedBox(
            maxHeight: 48,
            child: Row(children: [
              AspectRatio(
                aspectRatio: 1,
                child: Container(color: Colors.amber),
              ),
              SizedBox(width: 24),
              Expanded(
                child: Text(title),
              ),
              SizedBox(width: 24),
              FlatButton(onPressed: null, child: Icon(Icons.check_box))
            ])));
  }
}
