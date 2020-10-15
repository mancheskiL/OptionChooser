import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:option_chooser/models/list.dart';

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
              return _displayDialog(context);
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
                  return _MyListItem(
                      '${list.list[index].title}', list.list[index]);
                },
              )),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Random selection',
        child: Icon(Icons.add),
      ),
    );
  }

  _displayDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          elevation: 6,
          backgroundColor: Colors.transparent,
          child: _DialogWithTextField(context),
        );
      },
    );
  }

  Widget _DialogWithTextField(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    return Container(
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 24),
          Text(
            'Test Dialog!',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 15),
            child: TextField(
              maxLines: 1,
              autofocus: true,
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Enter Task Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              FlatButton(
                onPressed: () => Navigator.pop(context),
                child: Center(child: Text('Cancel')),
              ),
              FlatButton(
                onPressed: () {
                  var listAdd = context.read<ListModel>();
                  listAdd.add('${_controller.value.text}');
                  Navigator.pop(context);
                },
                child: Center(child: Text('Submit')),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final String title;
  final Item item;

  _MyListItem(this.title, this.item, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isComplete = context.select<ListModel, bool>(
      (list) => list.list.contains(item),
    );

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
              FlatButton(
                onPressed: () {
                  var itemObject = context.read<ListModel>();
                  // need to implement way of affecting the item in the listmodel
                  // currently we only have effectively a copy of the item, so changes
                  // made to it do not actually change the item in the listmodel
                  // and thus our icons do not register a change and so do not change
                },
                child: isComplete
                    ? Icon(Icons.check_box_outline_blank)
                    : Icon(Icons.check_box),
              )
            ])));
  }
}
