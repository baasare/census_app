import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String path;

  CustomDialog({this.title, this.content, this.path});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(title),
      content: new Text(content),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text("Ok"),
          onPressed: () {
            Navigator.of(context).pushNamed("/$path");
          },
        ),
      ],
    );
  }
}
