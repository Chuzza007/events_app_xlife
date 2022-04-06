import 'package:flutter/material.dart';

class CustomProgressWidget extends StatefulWidget {
  bool loading;
  Widget child;

  @override
  _CustomProgressWidgetState createState() =>
      _CustomProgressWidgetState();

  CustomProgressWidget({
    required this.loading,
    required this.child,
  });
}

class _CustomProgressWidgetState extends State<CustomProgressWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: widget.child),
        widget.loading
            ? Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              )
            : Container()
      ],
    );
  }
}
