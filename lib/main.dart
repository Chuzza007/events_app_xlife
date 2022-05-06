import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:xlife/generated/locales.g.dart';
import 'package:xlife/screen_video_player_test.dart';

import 'package:xlife/views/screens/screen_signup.dart';

import 'helpers/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (GetPlatform.isWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyB2tfPVP5CVeqDZAtuMjzE_tz0K62Gb_LY",
          authDomain: "fenua-xlife.firebaseapp.com",
          projectId: "fenua-xlife",
          storageBucket: "fenua-xlife.appspot.com",
          messagingSenderId: "797516731889",
          appId: "1:797516731889:web:4d468fd95ba56058806050",
          measurementId: "G-DJG5N590E2"),
    );
  } else {
    await Firebase.initializeApp();
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, device) {
      return GetMaterialApp(
        locale: Locale('fr', 'FR'),
        debugShowCheckedModeBanner: false,
        title: "Fenua X Life",
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
        home: /*AnimatedSplashScreen(
          splash: Image.asset(
            "assets/gifs/splash.gif",
            fit: BoxFit.cover,
          ),
          duration: 3000,
          splashIconSize: Get.height,
          pageTransitionType: PageTransitionType.rightToLeftWithFade,
          nextScreen: SignupScreen(),
        ),*/ScreenVideoPlayerTest()
      );
    });
  }
}

class ScrollBehaviorModified extends ScrollBehavior {
  ScrollBehaviorModified();

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return ClampingScrollPhysics();
    }
  }
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.

  print("Handling a background message: ${message}");
}