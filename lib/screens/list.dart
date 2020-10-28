import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:option_chooser/models/list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:option_chooser/models/dbControl.dart';
import 'package:option_chooser/models/item.dart';

class MyList extends StatelessWidget {
  // trying to save date semi-permanently
  _saveLaunchDate(BuildContext context) async {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyy-MM-dd');
    String formatted = formatter.format(now);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var date = prefs.getString('date');
    if (date == null) {
      await prefs.setString('date', formatted);
      print('No previous date, new date saved');
    } else {
      // just comparing date as int (i.e. 23 vs 24)
      // this technically could fail if the app isn't reopened until a month later
      // when the day date doesn't change, but it works for now
      DateTime beforeParsed = DateTime.parse(date);
      print('Before ${beforeParsed.day}');
      print('Now ${now.day}');
      if (beforeParsed.day != now.day) {
        print('Current date different than saved, resetting list');
        // reset list boxes
        // var listController = context.read<ListModel>();
        // listController.resetItems();

        await prefs.setString('date', formatted);
      }
    }
  }

  // MyList(BuildContext context) {
  //   _saveLaunchDate(context);
  // }

  @override
  Widget build(BuildContext context) {
    // _saveLaunchDate();
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
          //context.read<DbControl>().retrieve(),
          future: Provider.of<DbControl>(context, listen: true).retrieve(),
          builder: (BuildContext context, AsyncSnapshot<List<Item>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  // return _MyListItem(
                  //   snapshot.data[index].title,
                  //   snapshot.data[index].id,
                  // );
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
                    child: _MyListItem(
                      snapshot.data[index].title,
                      snapshot.data[index].id,
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Text('Oops!');
            }
            return Center(child: CircularProgressIndicator());
          }),
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

class _MyListItem extends StatelessWidget {
  final String title;
  final int id;

  _MyListItem(this.title, this.id, {Key key}) : super(key: key);

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
                child: Text(title),
              ),
              SizedBox(width: 24),
              FlatButton(
                  onPressed: null, //() {
                  //     var listObject = context.read<ListModel>();
                  //     listObject.setFinished(item.id);
                  //   },
                  child: Icon(Icons.check_box) //isComplete
                  //       ? Icon(Icons.check_box)
                  //       : Icon(Icons.check_box_outline_blank),
                  )
            ])));
  }
}
