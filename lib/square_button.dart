import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'on_dpad_click_widget.dart';

class SquareButton extends StatefulWidget {
  String data;
  final Function(String t) onTap;
  double padding;

  SquareButton({this.data, this.onTap, this.padding});

  @override
  State<StatefulWidget> createState() {
    return SquareButtonState();
  }
}

class SquareButtonState extends State<SquareButton> {
  bool hasChange = false;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return DpadWidget(
      child: makeActualButton(),
      onClick: () {
        widget.onTap(widget.data);
        setState(() {
          isClicked = !isClicked;
        });
      },
      id: widget.data,
      onFocus: (focus) {
        setState(() {
          this.hasChange = focus;
        });
      },
    );
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: this.hasChange
          ? Colors.blue.shade400.withOpacity(0.3)
          : Colors.grey.shade600.withOpacity(0.3),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
          ),
      border: Border.all(
        color: hasChange
            ? Colors.white
            : isClicked
                ? Colors.blue.shade400
                : Colors.grey.shade400,
        //                   <--- border color
        width: 2.0,
      ),
    );
  }

  BoxDecoration miniBoxDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(5), topRight: Radius.circular(5)),
      color: Colors.blue.shade400,
    );
  }

  Widget getTickifNeeded() {
    return (isClicked)
        ? Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.all(5),
              child: Image.asset(
                "assets/images/check.png",
                width: 12,
                height: 12,
                color: Colors.white,
              ),
              decoration: miniBoxDecoration(),
            ),
          )
        : Text(" ");
  }


  Widget makeActualButton() {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: EdgeInsets.all(widget.padding),
        alignment: Alignment.center,
        decoration: myBoxDecoration(),
        child: new ClipRRect(
          clipBehavior: Clip.antiAlias,
          borderRadius: BorderRadius.circular(5),
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Stack(
              children: [
                getTickifNeeded(),
                Container(
                  height: double.infinity,
                  padding: EdgeInsets.all(6),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(16, 3, 16, 0),
                          child: Image.asset("assets/images/heart.png",
                              fit: BoxFit.fitWidth, color:
                              hasChange ? Colors.white : Colors.blue,)),
                      Padding(
                        padding: EdgeInsets.all(2),
                      ),
                      Spacer(),
                      new Text(
                        widget.data,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                                hasChange ? Colors.white : Colors.blue,
                            fontSize: 20),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
