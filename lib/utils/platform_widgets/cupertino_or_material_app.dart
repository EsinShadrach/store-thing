import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformDependentWidget extends StatelessWidget {
  const PlatformDependentWidget({
    super.key,
    required this.home,
    required this.title,
  });

  static const Color turquoise = Color(0xFF40E0D0);
  final Widget home;
  final String title;

  @override
  Widget build(BuildContext context) {
    bool isApple = Platform.isIOS || Platform.isMacOS;

    if (isApple) {
      return CupertinoApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: const CupertinoThemeData(
          primaryColor: Color(0xFF40E0D0),
        ),
        home: home,
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
