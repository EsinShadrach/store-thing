import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_thing/utils/extensions/on_context.dart';

class PlatformScaffold extends StatelessWidget {
  const PlatformScaffold({
    super.key,
    required this.body,
    this.title,
  });

  final Widget body;
  final String? title;

  @override
  Widget build(BuildContext context) {
    bool isApple = Platform.isIOS || Platform.isMacOS;

    if (isApple) {
      return CupertinoPageScaffold(
        navigationBar: title != null
            ? CupertinoNavigationBar(
                backgroundColor: context.colorScheme.inversePrimary,
                middle: Text(title!),
              )
            : null,
        child: SafeArea(child: body),
      );
    }
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
            )
          : null,
      body: SafeArea(child: body),
    );
  }
}
