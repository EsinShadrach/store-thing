import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_thing/view/login.dart';
import 'package:store_thing/view/sign_up.dart';

class PlatformDependentWidget extends StatelessWidget {
  const PlatformDependentWidget({
    super.key,
    required this.home,
    required this.title,
  });

  static const Color turquoise = Color(0xFFE51065);
  final Widget home;
  final String title;

  static final Map<String, Widget Function(BuildContext)> routes = {
    "/sign_up": (context) => const SignUpScreen(),
    "/login": (context) => const LoginScreen(),
  };

  @override
  Widget build(BuildContext context) {
    bool isApple = Platform.isIOS || Platform.isMacOS;

    if (isApple) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        themeMode: ThemeMode.system,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: turquoise,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: turquoise,
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        home: CupertinoApp(
          routes: routes,
          debugShowCheckedModeBanner: false,
          title: title,
          theme: const CupertinoThemeData(
            primaryColor: turquoise,
            applyThemeToAll: true,
          ),
          color: turquoise,
          home: home,
        ),
      );
    }
    return MaterialApp(
      routes: routes,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: turquoise,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: turquoise,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      title: title,
    );
  }
}
