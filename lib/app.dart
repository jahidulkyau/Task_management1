import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: TaskManagerApp.navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorSchemeSeed: Colors.green,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
            ),
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16,
            ),
            border: _getZeroBorder(),
            enabledBorder: _getZeroBorder(),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(double.maxFinite),
                backgroundColor: Colors.green,
                iconColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
          ),
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          )),
      home: const SplashScreen(),
    );
  }

  OutlineInputBorder _getZeroBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
    );
  }
}
