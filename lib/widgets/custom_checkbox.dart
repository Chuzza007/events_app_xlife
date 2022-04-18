import 'package:flutter/material.dart';

class CustomCheckboxListTile extends StatefulWidget {
  Color fillColor, checkColor;
  bool value;
  Function(bool? value)? onChange;
  Widget? title, subtitle;
  bool rightCheck;

  @override
  _CustomCheckboxListTileState createState() => _CustomCheckboxListTileState();

  CustomCheckboxListTile({
    required this.fillColor,
    required this.checkColor,
    required this.value,
    this.onChange,
    this.title,
    this.subtitle,
    required this.rightCheck,
  });
}

class _CustomCheckboxListTileState extends State<CustomCheckboxListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: widget.rightCheck
          ? null
          : Transform.scale(
              scale: 1.2,
              child: Checkbox(
                value: widget.value,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.all(widget.fillColor),
                onChanged: widget.onChange,
              ),
            ),
      trailing: widget.rightCheck
          ? Transform.scale(
              scale: 1.2,
              child: Checkbox(
                side: BorderSide(color: Colors.red, width: 2),
                value: widget.value,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.all(widget.fillColor),
                onChanged: widget.onChange,
              ),
            )
          : null,
      title: widget.title,
      subtitle: widget.subtitle,
      onTap: () {
        setState(() {
          widget.value = !widget.value;
        });
      },
    );
  }
}
