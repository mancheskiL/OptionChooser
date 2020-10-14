import 'package:flutter/material.dart';

class DialogWithTextField extends StatefulWidget {
  @override
  _DialogWithTextFieldState createState() => _DialogWithTextFieldState();
}

class _DialogWithTextFieldState extends State<DialogWithTextField> {
  @override
  Widget build(BuildContext context) {
    return _displayDialog();
  }

  _displayDialog() {
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
            child: TextFormField(
              maxLines: 1,
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Test Text Form',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
