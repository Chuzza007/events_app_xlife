import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomChips extends StatefulWidget {
  final List<String> chipNames;
  bool selectable;
  Color? textColor, selectedColor, unselectedColor;
  ValueChanged<int>? onSelected;
  double? fontSize;

  @override
  _CustomChipsState createState() => _CustomChipsState();

  CustomChips({
    required this.chipNames,
    required this.selectable,
    this.textColor,
    this.selectedColor,
    this.unselectedColor,
    this.onSelected,
    this.fontSize
  });
}

class _CustomChipsState extends State<CustomChips> {
  String _isSelected = "";

  _buildChoiceList() {
    List<Widget> choices = List.empty(growable: true);
    widget.chipNames.forEach((item) {
      choices.add(Container(
        child: ChoiceChip(
          label: Text(item),
          labelStyle:
              TextStyle(color: widget.textColor ?? Colors.black,
                fontSize: widget.fontSize
              ),
          selectedColor: widget.selectedColor ?? Colors.pinkAccent,
          backgroundColor: widget.unselectedColor ?? Colors.grey[300],
          selected: widget.selectable ? _isSelected == item : false,
          onSelected: (selected) {
            if (widget.selectable) {
              setState(() {
                _isSelected = item;
                if (widget.onSelected != null) {
                  widget.onSelected!(widget.chipNames.indexOf(item));
                }
              });
            }
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 3.5.sp,
      runSpacing: 2.5.sp,
      children: _buildChoiceList(),
    );
  }
}
