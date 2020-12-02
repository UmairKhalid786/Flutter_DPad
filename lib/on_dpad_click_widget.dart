import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

const int KEY_UP = 19;
const int KEY_DOWN = 20;
const int KEY_LEFT = 21;
const int KEY_RIGHT = 22;
const int KEY_CENTER = 23;
const int KEY_CENTER_KEYBOARD = 66;

class DpadWidget extends StatefulWidget {
  final Function onClick;
  final Function(bool isFocused) onFocus;
  final Widget child;
  final String id;

  const DpadWidget({Key key, this.onClick, this.child, this.id, this.onFocus})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DpadWidgetState();
  }
}

class DpadWidgetState extends State<DpadWidget> {
  List<FocusNode> focusNodes = List();
  FocusNode node;
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    node = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      child: widget.child,
      focusNode: node,
      onKey: (RawKeyEvent event) {
        isFocused = !isFocused;

        if (widget.onFocus != null) widget.onFocus(isFocused);

        if (event is RawKeyDownEvent && event.data is RawKeyEventDataAndroid) {
          RawKeyDownEvent rawKeyDownEvent = event;
          RawKeyEventDataAndroid rawKeyEventDataAndroid = rawKeyDownEvent.data;
          print(rawKeyEventDataAndroid.keyCode);
          switch (rawKeyEventDataAndroid.keyCode) {
            case KEY_CENTER:
              widget.onClick();
              break;
            case KEY_CENTER_KEYBOARD:
              widget.onClick();
              break;
            case KEY_UP:
              break;
            case KEY_DOWN:
              break;
            default:
              break;
          }
        }
      },
    );
  }
}
