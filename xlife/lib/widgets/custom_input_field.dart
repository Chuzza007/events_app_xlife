import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class CustomInputField extends StatefulWidget {
  final String hint;
  final bool isPasswordField;
  final Function(String? value)? onChange;
  final TextInputType keyboardType;
  Widget? prefix;
  int? limit;
  TextEditingController? controller;
  VoidCallback? onTap;
  bool? readOnly;
  Color? fillColor;
  int? maxLines;
  int? minLines;
  String? text;
  Color? counterColor;
  bool? showCounter;
  bool? showBorder;
  bool? isDense;
  EdgeInsetsGeometry? margin;

  CustomInputField(
      {required this.hint,
      required this.isPasswordField,
      this.onChange,
      required this.keyboardType,
      this.prefix,
      this.limit,
      this.controller,
      this.onTap,
      this.readOnly,
      this.fillColor,
      this.maxLines,
      this.text,
      this.showCounter,
      this.counterColor,
      this.showBorder,
      this.minLines,
      this.margin,
      this.isDense});

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  late bool _isHidden;

  @override
  void initState() {
    _isHidden = widget.isPasswordField;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: widget.margin ?? EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        maxLength: widget.limit,
        onChanged: widget.onChange,
        obscureText: _isHidden,
        onTap: widget.onTap,
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines,
        readOnly: widget.readOnly ?? false,
        keyboardType: widget.keyboardType,
        controller: widget.controller,
        buildCounter: (_,
            {required currentLength, maxLength, required isFocused}) {
          return Visibility(
            visible: widget.showCounter ?? false,
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Container(
                alignment: Alignment.centerRight,
                child: Text(
                  currentLength.toString() +
                      "/" +
                      maxLength.toString(),
                  style: TextStyle(color: widget.counterColor),
                ),
              ),
            ),
          );
        },
        decoration: InputDecoration(
            prefixIcon: widget.prefix,
            hintText: widget.hint,
            isDense: widget.isDense,
            fillColor: widget.fillColor ?? /*Color(0xFFECECEC)*/
                Colors.white,
            filled: true,
            suffixIcon: widget.isPasswordField
                ? IconButton(
                    onPressed: () {
                      if (widget.isPasswordField) {
                        setState(() {
                          _isHidden = !_isHidden;
                        });
                      }
                    },
                    icon: Visibility(
                      visible: widget.isPasswordField,
                      child: Icon(
                        widget.isPasswordField
                            ? (_isHidden
                                ? Icons.visibility
                                : Icons.visibility_off)
                            : null,
                      ),
                    ),
                  )
                : null,
            hintStyle: TextStyle(color: hintColor),
            contentPadding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: (widget.maxLines != null) ? 15 : 5,
                bottom: (widget.maxLines != null) ? 15 : 5),
            border: (widget.showBorder != null &&
                    widget.showBorder == false)
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(width: 1, color: hintColor),
                  ),
            enabledBorder: (widget.showBorder != null &&
                    widget.showBorder == false)
                ? InputBorder.none
                : OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(Radius.circular(10)),
                    borderSide:
                        BorderSide(width: 1, color: hintColor))
            // filled: true,
            // fillColor: Color(0xF0BBBBBB),
            ),
      ),
    );
  }
}
