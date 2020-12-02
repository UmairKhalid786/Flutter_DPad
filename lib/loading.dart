import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        height: 50.0,
        width: 50.0,
        child: new CircularProgressIndicator(
          value: null,
          strokeWidth: 7.0,
        ),
      ),
    );
  }
}
