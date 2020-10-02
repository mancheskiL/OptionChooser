import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyRecords extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Records Screen')),
      body: ListView(padding: EdgeInsets.all(8), children: <Widget>[
        Container(
          height: 50,
          color: Colors.green[600],
          child: Center(child: Text('Record 1')),
        ),
        Container(
          height: 50,
          color: Colors.green[700],
          child: Center(child: Text('Record 2')),
        ),
      ]),
    );
  }
}
