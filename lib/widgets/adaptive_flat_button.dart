import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdaptiveFlatButton extends StatelessWidget {
  //const AdaptiveFlatButton({Key key}) : super(key: key);

  final String text;
  final Function OnbuttonPressed;

  AdaptiveFlatButton(this.text, this.OnbuttonPressed);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: OnbuttonPressed,
            child: Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ))
        : TextButton(
            onPressed: OnbuttonPressed,
            child: Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
          );
  }
}
