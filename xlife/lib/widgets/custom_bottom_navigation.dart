import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/helpers/constants.dart';

class CustomBottomNavigation extends StatefulWidget {
  bool? showSelectedLabels;
  bool? showUnselectedLabels;
  int currentIndex;
  int primaryIndex;
  ValueChanged<int> onTap;
  Future<bool> Function()? onScreenExit;
  Color? selectedItemColor, unselectedItemColor;
  double? elevation;
  Color? fixedColor;
  Color? backgroundColor;
  double? iconSize = 21.0.sp;
  IconThemeData? selectedIconTheme;
  IconThemeData? unselectedIconTheme;
  double? selectedFontSize = 11.0;
  double? unselectedFontSize = 9.0;
  TextStyle? selectedLabelStyle;
  TextStyle? unselectedLabelStyle;
  List<CustomBottomMenuItem> items;
  CustomBottomNavigationType? type;

  @override
  _CustomBottomNavigationState createState() =>
      _CustomBottomNavigationState();

  CustomBottomNavigation(
      {this.showSelectedLabels,
      this.showUnselectedLabels,
      required this.currentIndex,
      required this.onTap,
      required this.primaryIndex,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.elevation,
      this.fixedColor,
      this.backgroundColor,
      this.iconSize,
      this.selectedIconTheme,
      this.unselectedIconTheme,
      this.selectedFontSize,
      this.unselectedFontSize,
      this.selectedLabelStyle,
      this.unselectedLabelStyle,
      required this.items,
      this.type,
      this.onScreenExit});
}

class _CustomBottomNavigationState
    extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.currentIndex != widget.primaryIndex) {
          setState(() {
            widget.onTap(widget.primaryIndex);
          });
          return false;
        }
        bool response = true;
        if (widget.onScreenExit != null) {
          response = await widget.onScreenExit!();
        }
        return response;
      },
      child: BottomNavigationBar(
        items: _buildMenuItem(),
        currentIndex: widget.currentIndex,
        onTap: widget.onTap,
        selectedItemColor: widget.selectedItemColor,
        unselectedItemColor: widget.unselectedItemColor,
        showSelectedLabels: widget.showSelectedLabels,
        showUnselectedLabels: widget.showUnselectedLabels,
        type: widget.type == null
            ? null
            : (widget.type == CustomBottomNavigationType.fixed
                ? BottomNavigationBarType.fixed
                : BottomNavigationBarType.shifting),
        elevation: widget.elevation,
        fixedColor: widget.fixedColor,
        backgroundColor: widget.backgroundColor,
        iconSize: widget.iconSize ?? 21.0.sp,
        selectedIconTheme: widget.selectedIconTheme,
        unselectedIconTheme: widget.unselectedIconTheme,
        selectedFontSize: widget.selectedFontSize ?? 0.0.sp,
        unselectedFontSize: widget.unselectedFontSize ?? 0.0.sp,
        selectedLabelStyle: widget.selectedLabelStyle,
        unselectedLabelStyle: widget.unselectedLabelStyle,
      ),
    );
  }

  List<BottomNavigationBarItem> _buildMenuItem() {
    double totalWidth = MediaQuery.of(context).size.width;

    return widget.items.map((item) {
      return BottomNavigationBarItem(
        icon: item.icon,
        label: item.label ?? widget.items.indexOf(item).toString(),
        activeIcon: Column(
          children: [
            ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 17.sp,
                  maxWidth: 17.sp
                ),
                child: item.icon),
            SizedBox(
              height: 2.sp,
            ),
            Image.asset(
              "assets/images/menu_bottom.png",
              height: 11.sp,
              width: totalWidth /
                  ((widget.items.length <= 3
                          ? 1.2.sp
                          : widget.items.length) *
                      1.5.sp),
              color: appPrimaryColor,
            ),
          ],
        ),
      );
    }).toList();
  }
}

class CustomBottomMenuItem {
  String? label;
  Widget icon;

  CustomBottomMenuItem({
    this.label,
    required this.icon,
  });
}

enum CustomBottomNavigationType { fixed, animating }
