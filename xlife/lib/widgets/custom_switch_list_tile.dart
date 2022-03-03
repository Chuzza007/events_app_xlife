import 'package:flutter/material.dart';

class CustomSwitchListTile extends StatefulWidget {
  Widget? title, subtitle, leading;
  bool value;
  ValueChanged<bool> onChanged;
  double? sizeScale;

  @override
  _CustomSwitchListTileState createState() =>
      _CustomSwitchListTileState();

  CustomSwitchListTile(
      {this.title,
      this.subtitle,
      this.leading,
      required this.value,
      required this.onChanged,
      this.sizeScale});
}

class _CustomSwitchListTileState extends State<CustomSwitchListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: widget.title,
      subtitle: widget.subtitle,
      leading: widget.leading,
      trailing: Transform.scale(
        scale: widget.sizeScale ?? 1.3,
        child: Switch(
          value: widget.value,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
