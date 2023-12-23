import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformDependentWidget extends StatelessWidget {
  const PlatformDependentWidget({
    super.key,
    required this.home,
    required this.title,
  });

  static const Color turquoise = Color(0xFFE51065);
  final Widget home;
  final String title;

  @override
  Widget build(BuildContext context) {
    bool isApple = Platform.isIOS || Platform.isMacOS;

    if (isApple) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: turquoise),
          useMaterial3: true,
        ),
        home: CupertinoApp(
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
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: turquoise),
        useMaterial3: true,
      ),
    );
  }
}
