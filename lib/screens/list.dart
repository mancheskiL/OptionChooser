import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Options Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () => Navigator.pushNamed(context, '/add-edit'),
          ),
          IconButton(
            icon: Icon(Icons.android),
            onPressed: () => Navigator.pushNamed(context, '/records'),
          ),
        ],
      ),
      body: ListView(padding: EdgeInsets.all(8), children: <Widget>[
        Container(
          height: 50,
          color: Colors.amber[500],
          child: Center(child: Text('Item 1')),
        ),
        Container(
          height: 50,
          color: Colors.amber[600],
          child: Center(child: Text('Item 2')),
        ),
        Container(
          height: 50,
          color: Colors.amber[700],
          child: Center(child: Text('Item 3')),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Random selection',
        child: Icon(Icons.add),
      ),
    );
  }
}
