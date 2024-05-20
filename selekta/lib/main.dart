import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:selekta/pages/Intro.dart';
import 'package:selekta/pages/MyHomePage.dart';
import 'package:selekta/utils/custom_animation.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 25.0
    ..radius = 50.0
    ..progressColor = Color(0xFFF150B29)
    ..backgroundColor = Colors.white
    ..indicatorColor = Color(0xFFF150B29)
    ..textColor = Color(0xFFF150B29)
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false
    ..customAnimation = CustomAnimation();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPages(),
      builder: EasyLoading.init(),
    );
  }
}
