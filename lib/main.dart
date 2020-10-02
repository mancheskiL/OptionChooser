import 'package:flutter/material.dart';
import 'package:option_chooser/screens/list.dart';
import 'package:option_chooser/screens/edit.dart';
import 'package:option_chooser/screens/records.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Option Chooser',
      // home: MyList(),
      initialRoute: '/',
      routes: {
        '/': (context) => MyList(),
        '/add-edit': (context) => MyEdit(),
        '/records': (context) => MyRecords(),
      },
    );
  }
}
