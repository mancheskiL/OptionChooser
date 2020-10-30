import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:option_chooser/models/dbControl.dart';
import 'package:option_chooser/models/item.dart';
import 'dart:math';

class MyList extends StatefulWidget {
  @override
  MyListState createState() => MyListState();
}

class MyListState extends State<MyList> {
  int highlightIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.access_alarm),
            onPressed: () {
              var clear = context.read<DbControl>();
              clear.clearAll();
            },
          ),
          IconButton(
            // when pressed will add new entry
            icon: Icon(Icons.add_circle),
            onPressed: () {
              return _displayDialog(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.android),
            onPressed: () => Navigator.pushNamed(context, '/records'),
          ),
        ],
      ),
      body: FutureBuilder<List<Item>>(
          future: Provider.of<DbControl>(context, listen: true).retrieve(),
          builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (highlightIndex != index) {
                    return Dismissible(
                      key: Key(snapshot.data[index].id.toString()),
                      onDismissed: (direction) {
                        var dbAcces = context.read<DbControl>();
                        dbAcces.delete(snapshot.data[index].id);
                        Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text(
                                '${snapshot.data[index].title} was dismissed')));
                      },
                      background: Container(color: Colors.red),
                      child: _MyListItem(snapshot.data[index]),
                    );
                  } else {
                    return Container(
                        margin: const EdgeInsets.symmetric(vertical: 2),
                        color: Colors.green,
                        child: Dismissible(
                          key: Key(snapshot.data[index].id.toString()),
                          onDismissed: (direction) {
                            var dbAcces = context.read<DbControl>();
                            dbAcces.delete(snapshot.data[index].id);
                            Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(
                                    '${snapshot.data[index].title} was dismissed')));
                          },
                          background: Container(color: Colors.red),
                          child: _MyListItem(snapshot.data[index]),
                        ));
                  }
                },
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Oops!');
            }
            return Center(child: CircularProgressIndicator());
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var dbAccess = context.read<DbControl>();
          List<Item> list = await dbAccess.retrieve();
          int count = list.length;
          setState(() {
            int selection = Random().nextInt(count);
            highlightIndex = selection;
          });
        },
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
                  var db = context.read<DbControl>();
                  db.saveToDB('${_controller.value.text}');
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

class _MyListItem extends StatefulWidget {
  final Item item;

  _MyListItem(this.item, {Key key}) : super(key: key);

  @override
  _MyListItemState createState() => _MyListItemState();
}

class _MyListItemState extends State<_MyListItem> {
  bool complete = false;

  @override
  Widget build(BuildContext context) {
    // my understanding currently is the selector always returns false,
    // until a change occurs, at which case it returns true
    // selector does not actually return the value of the watched element
    // merely the status of it that element has changed
    // var isComplete = context.select<ListModel, bool>(
    //   (list) => list.list[id].complete,
    // );
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
                child: Text(widget.item.title),
              ),
              SizedBox(width: 24),
              FlatButton(
                onPressed: () {
                  var dbAccess = context.read<DbControl>();
                  dbAccess.addToRecords(widget.item);
                  setState(() {
                    complete = !complete;
                  });
                },
                child: complete
                    ? Icon(Icons.check_box)
                    : Icon(Icons.check_box_outline_blank),
              )
            ])));
  }
}
