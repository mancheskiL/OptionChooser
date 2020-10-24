import 'package:flutter/material.dart';
import 'package:option_chooser/screens/list.dart';
import 'package:option_chooser/screens/records.dart';
import 'package:provider/provider.dart';
import 'package:option_chooser/models/list.dart';
import 'package:option_chooser/models/records.dart';
import 'package:option_chooser/models/dbControl.dart';

void main() {
  runApp(
    // ChangeNotifierProvider(
    //   create: (context) => ListModel(),
    //   child: MyApp(),
    // ),
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ListModel(context)),
        ChangeNotifierProvider(create: (context) => RecordsModel()),
        Provider(
          create: (context) => DbControl(),
          lazy: false,
        ),
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
      // home: MyList()
      initialRoute: '/',
      routes: {
        '/': (context) => MyList(context),
        '/records': (context) => MyRecords(),
      },
    );
  }
}
