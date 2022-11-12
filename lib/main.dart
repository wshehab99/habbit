import 'package:flutter/material.dart';
import 'package:habbit/db_helper/database_helper.dart';
import 'package:habbit/layout/screens/onboarding_screen.dart';
import 'package:habbit/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      home: Builder(builder: (context) {
        ResponsiveApp.setMq(context);
        return OnBoardingScreen();
      }),
    );
  }
}

class ResponsiveApp {
  static MediaQueryData? _mediaQueryData;

  MediaQueryData get mq => _mediaQueryData!;

  static void setMq(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
  }
}
