import 'package:page_transition/src/enum.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/generated/locales.g.dart';

import 'package:xlife/views/screens/screen_signup.dart';

import 'helpers/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, device){
      return GetMaterialApp(
        locale: Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        title: LocaleKeys.AppName.tr,
        theme: ThemeData(
          fontFamily: 'Outfit',
          primarySwatch: appPrimaryColor,
          checkboxTheme: CheckboxThemeData(
            checkColor: MaterialStateProperty.all(Colors.white),
            fillColor: MaterialStateProperty.all(appPrimaryColor),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            side: BorderSide(color: Color(0xff585858), width: 1),
          ),
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Outfit"),
            centerTitle: false,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          scaffoldBackgroundColor: Color(0xFFFAFBFF),
          backgroundColor: Color(0xFFFAFBFF),
        ),
        defaultTransition: Transition.downToUp,
        builder: (context, widget) {
          return ScrollConfiguration(
              behavior: ScrollBehaviorModified(), child: widget!);
        },
        translationsKeys: AppTranslation.translations,
        home: AnimatedSplashScreen(
          splash: Image.asset("assets/gifs/splash.gif", fit: BoxFit.cover,),
          duration: 3000,
          splashIconSize: Get.height,
          pageTransitionType: PageTransitionType.rightToLeftWithFade,
          nextScreen: SignupScreen(),
        ),
      );
    });
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
  }
}
