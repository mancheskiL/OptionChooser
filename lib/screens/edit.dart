import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyEdit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Screen'),
      ),
      body: ListView(padding: EdgeInsets.all(8), children: <Widget>[
        Container(
          height: 50,
          color: Colors.red[500],
          child: Center(child: Text('Already Exists 1')),
        ),
        Container(
          height: 50,
          color: Colors.red[600],
          child: Center(child: Text('Already Exists 2')),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Adds new option',
        child: Icon(Icons.add),
      ),
    );
  }
}
