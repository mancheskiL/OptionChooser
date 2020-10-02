import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Options Screen')),
      body: Center(
        child: Text('This is where options will be shown'),
      ),
    );
  }
}
