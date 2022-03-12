import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomChips extends StatefulWidget {
  final List<String> chipNames;
  bool selectable;
  bool? scrollable;
  Color? textColor, selectedColor, unselectedColor;
  ValueChanged<List<String>>? onDeleted;
  ValueChanged<int>? onSelected;
  Widget? deleteIcon;
  double? fontSize;

  @override
  _CustomChipsState createState() => _CustomChipsState();

  CustomChips(
      {required this.chipNames,
      required this.selectable,
      this.textColor,
      this.selectedColor,
      this.unselectedColor,
      this.onSelected,
      this.fontSize,
      this.onDeleted,
      this.scrollable,
      this.deleteIcon});
}

class _CustomChipsState extends State<CustomChips> {
  String _isSelected = "";

  _buildChoiceList() {
    List<Widget> choices = List.empty(growable: true);
    widget.chipNames.forEach((item) {
      if (item.trim().isNotEmpty)
      choices.add(Container(
        child: RawChip(
          label: Text(item),
          labelStyle: TextStyle(
              color: widget.textColor ?? Colors.black,
              fontSize: widget.fontSize),
          deleteIcon: widget.deleteIcon,
          onDeleted: widget.onDeleted != null
              ? () {
                  setState(
                    () {
                      int deleteIndex =
                          widget.chipNames.indexOf(item);
                      widget.chipNames.removeAt(deleteIndex);
                      widget.onDeleted!(widget.chipNames);
                    },
                  );
                }
              : null,
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
    List<Widget> choices = _buildChoiceList();
    return (widget.scrollable != null && widget.scrollable == true)
        ? Container(
            height: 7.h,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return choices[index];
                },
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 3.5.sp,
                  );
                },
                itemCount: choices.length),
          )
        : Wrap(
            spacing: 3.5.sp,
            runSpacing: 2.5.sp,
            children: choices,
          );
  }
}
