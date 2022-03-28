import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'constants.dart';

Color listFillColor = Color(0xF0F6F6F6);
Color opacityGrey = Color(0xC1707070);
Color appSecondaryColor = /*Color(0xFF244B71)*/ Colors.orange;
Color appSecondaryColorDark = /*Color(0xFF152C42)*/ Colors.deepOrangeAccent;
Color appTextColor = Color(0xFF242C43);
Color ratingColor = Color(0xFFFBB957);
// Color appSecondaryColorOpacity = Color(0xFF7154AAFF);

ButtonStyle disabledButtonStyle = ElevatedButton.styleFrom(
  primary: Colors.grey,
  onPrimary: Colors.white,
  shadowColor: Colors.grey,
  padding: EdgeInsets.all(10.sp),
  elevation: 3.sp,
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0.sp)),
  minimumSize: Size(100, 40),
);
TextStyle headingStyle = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.bold,
);

TextStyle primaryColorText = TextStyle(color: appPrimaryColor);

TextStyle heading1_style = TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold);
TextStyle heading2_style = TextStyle(fontSize: 23.sp, fontWeight: FontWeight.bold);
TextStyle heading3_style = TextStyle(fontSize: 19.sp, fontWeight: FontWeight.bold);
TextStyle heading4_style = TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold);

TextStyle normal_h1Style = TextStyle(color: appTextColor, fontSize: 16.sp);
TextStyle normal_h2Style = TextStyle(color: appTextColor, fontSize: 14.sp);
TextStyle normal_h3Style = TextStyle(color: appTextColor, fontSize: 12.sp);
TextStyle normal_h4Style = TextStyle(color: appTextColor, fontSize: 10.sp);
TextStyle normal_h5Style = TextStyle(color: appTextColor, fontSize: 8.sp);
TextStyle normal_h6Style = TextStyle(color: appTextColor, fontSize: 6.sp);

TextStyle normal_h1Style_bold = TextStyle(color: appTextColor, fontSize: 16.sp, fontWeight: FontWeight.bold);
TextStyle normal_h2Style_bold = TextStyle(color: appTextColor, fontSize: 14.sp, fontWeight: FontWeight.bold);
TextStyle normal_h3Style_bold = TextStyle(color: appTextColor, fontSize: 12.sp, fontWeight: FontWeight.bold);
TextStyle normal_h4Style_bold = TextStyle(color: appTextColor, fontSize: 10.sp, fontWeight: FontWeight.bold);
TextStyle normal_h5Style_bold = TextStyle(color: appTextColor, fontSize: 8.sp, fontWeight: FontWeight.bold);
TextStyle normal_h6Style_bold = TextStyle(color: appTextColor, fontSize: 6.sp, fontWeight: FontWeight.bold);

TextStyle grey_h1Style = TextStyle(color: opacityGrey, fontSize: 16.sp);
TextStyle grey_h2Style = TextStyle(color: opacityGrey, fontSize: 14.sp);
TextStyle grey_h3Style = TextStyle(color: opacityGrey, fontSize: 12.sp);
TextStyle grey_h4Style = TextStyle(color: opacityGrey, fontSize: 10.sp);

TextStyle grey_h1Style_bold = TextStyle(color: opacityGrey, fontSize: 16.sp, fontWeight: FontWeight.bold);
TextStyle grey_h2Style_bold = TextStyle(color: opacityGrey, fontSize: 14.sp, fontWeight: FontWeight.bold);
TextStyle grey_h3Style_bold = TextStyle(color: opacityGrey, fontSize: 12.sp, fontWeight: FontWeight.bold);

TextStyle heading1_style_web = TextStyle(fontSize: (26 + 2), fontWeight: FontWeight.bold);
TextStyle heading2_style_web = TextStyle(fontSize: (23 + 2), fontWeight: FontWeight.bold);
TextStyle heading3_style_web = TextStyle(fontSize: (19 + 2), fontWeight: FontWeight.bold);
TextStyle heading4_style_web = TextStyle(fontSize: (16 + 2), fontWeight: FontWeight.bold);

TextStyle normal_h1Style_web = TextStyle(color: appTextColor, fontSize: (2 + 16));
TextStyle normal_h2Style_web = TextStyle(color: appTextColor, fontSize: (2 + 14));
TextStyle normal_h3Style_web = TextStyle(color: appTextColor, fontSize: (2 + 12));
TextStyle normal_h4Style_web = TextStyle(color: appTextColor, fontSize: (2 + 10));
TextStyle normal_h5Style_web = TextStyle(color: appTextColor, fontSize: (2 + 8));
TextStyle normal_h6Style_web = TextStyle(color: appTextColor, fontSize: (2 + 6));

TextStyle normal_h1Style_bold_web = TextStyle(color: appTextColor, fontSize: (16 + 2), fontWeight: FontWeight.bold);
TextStyle normal_h2Style_bold_web = TextStyle(color: appTextColor, fontSize: (14 + 2), fontWeight: FontWeight.bold);
TextStyle normal_h3Style_bold_web = TextStyle(color: appTextColor, fontSize: (12 + 2), fontWeight: FontWeight.bold);
TextStyle normal_h4Style_bold_web = TextStyle(color: appTextColor, fontSize: (10 + 2), fontWeight: FontWeight.bold);
TextStyle normal_h5Style_bold_web = TextStyle(color: appTextColor, fontSize: (8 + 2), fontWeight: FontWeight.bold);
TextStyle normal_h6Style_bold_web = TextStyle(color: appTextColor, fontSize: (6 + 2), fontWeight: FontWeight.bold);

TextStyle grey_h1Style_web = TextStyle(color: opacityGrey, fontSize: (16 + 2));
TextStyle grey_h2Style_web = TextStyle(color: opacityGrey, fontSize: (14 + 2));
TextStyle grey_h3Style_web = TextStyle(color: opacityGrey, fontSize: (12 + 2));
TextStyle grey_h4Style_web = TextStyle(color: opacityGrey, fontSize: (10 + 2));

TextStyle grey_h1Style_bold_web = TextStyle(color: opacityGrey, fontSize: (16 + 2), fontWeight: FontWeight.bold);
TextStyle grey_h2Style_bold_web = TextStyle(color: opacityGrey, fontSize: (14 + 2), fontWeight: FontWeight.bold);
TextStyle grey_h3Style_bold_web = TextStyle(color: opacityGrey, fontSize: (12 + 2), fontWeight: FontWeight.bold);

BoxDecoration roundDecorationWithBorder = BoxDecoration(borderRadius: BorderRadius.circular(10.sp), border: Border.all(color: Colors.black26));
BoxDecoration roundDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10.sp),
);

List<BoxShadow> appBoxShadow = [BoxShadow(blurRadius: 5.sp, color: Color(0x414D5678))];
