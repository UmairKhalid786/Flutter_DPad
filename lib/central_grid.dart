import 'package:dpad_tv/loading.dart';
import 'package:dpad_tv/square_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainGrid extends StatefulWidget {
  Function(String id) onItemSelected;

  MainGrid({Key key, this.onItemSelected}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainGridState();
  }
}

class MainGridState extends State<MainGrid> {

  double margin = 10;
  int ITEMS = 3;

  int totalPages;
  int totalItemsCanBeOnPage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(30),
            child: new LayoutBuilder(
              builder: (ctx, constraints) {
                return calculateChildWithWidth(constraints);
              },
            )));
  }


  Widget calculateChildWithWidth(BoxConstraints constraints) {
    updateHeightAccordingly(constraints.maxWidth, constraints.maxHeight);

    if (totalItemsCanBeOnPage != null) {
      return makeListFrom();
    } else {
      return Loading();
    }
  }

  Widget makeListFrom() {
    return GridView.count(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      crossAxisCount: ITEMS,
      children: List.generate(totalItemsCanBeOnPage, (index) {
        return Center(
            child: SquareButton(
              padding: margin,
              data: "Item " + index.toString(),
              onTap: (String m) {
                // Scaffold.of(context).showSnackBar(SnackBar(
                //   content: Text(m),
                // ));
              },
            ));
      }),
    );
  }

  void updateHeightAccordingly(double width, double height) {
    print(width);
    print(height);
    double secHeight = height;
    secHeight = secHeight / ITEMS;
    double posItemsDouble = width / secHeight;
    int posItems = posItemsDouble.toInt();
    totalItemsCanBeOnPage = posItems * ITEMS;
  }

}
