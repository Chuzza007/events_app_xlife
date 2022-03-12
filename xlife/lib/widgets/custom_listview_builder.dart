import 'package:flutter/material.dart';

class CustomListviewBuilder extends StatefulWidget {
  IndexedWidgetBuilder itemBuilder;
  int itemCount;
  CustomDirection scrollDirection;
  bool? scrollable;
  bool? reverse;

  @override
  _CustomListviewBuilderState createState() =>
      _CustomListviewBuilderState();

  CustomListviewBuilder(
      {required this.itemBuilder,
      required this.itemCount,
      required this.scrollDirection,
      this.scrollable, this.reverse});
}

class _CustomListviewBuilderState
    extends State<CustomListviewBuilder> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        reverse: widget.reverse ?? false,
        physics:
            (widget.scrollable != null && widget.scrollable == false)
                ? NeverScrollableScrollPhysics()
                : BouncingScrollPhysics(),
        scrollDirection: widget.scrollDirection == CustomDirection.vertical
            ? Axis.vertical
            : Axis.horizontal,
        child: widget.scrollDirection == CustomDirection.vertical
            ? Column(
                children: List.generate(widget.itemCount,
                        (index) => widget.itemBuilder(context, index))
                    .toList(),
              )
            : Row(
                children: List.generate(widget.itemCount,
                        (index) => widget.itemBuilder(context, index))
                    .toList(),
              ),
      ),
    );
  }
}

enum CustomDirection { vertical, horizontal }
