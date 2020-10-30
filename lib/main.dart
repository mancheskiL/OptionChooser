import 'package:flutter/material.dart';
import 'package:option_chooser/screens/list.dart';
import 'package:option_chooser/screens/records.dart';
import 'package:provider/provider.dart';
import 'package:option_chooser/models/dbControl.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DbControl()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Option Chooser',
      initialRoute: '/',
      routes: {
        '/': (context) => MyList(),
        '/records': (context) => MyRecords(),
      },
    );
  }
}
