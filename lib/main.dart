import 'package:flutter/material.dart';
import 'package:option_chooser/screens/list.dart';
// import 'package:option_chooser/screens/edit.dart';
import 'package:option_chooser/screens/records.dart';
import 'package:provider/provider.dart';
import 'package:option_chooser/models/list.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ListModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Option Chooser',
      home: MyList(),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => MyList(),
      //   // '/add-edit': (context) => MyEdit(),
      //   '/records': (context) => MyRecords(),
      // },
    );
  }
}
