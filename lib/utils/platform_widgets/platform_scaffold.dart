import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store_thing/utils/extensions/on_context.dart';

class PlatformScaffold extends StatelessWidget {
  const PlatformScaffold({
    super.key,
    required this.body,
    this.title,
    this.trailing,
  });

  final Widget body;
  final String? title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    bool isApple = Platform.isIOS || Platform.isMacOS;

    if (isApple) {
      return CupertinoPageScaffold(
        navigationBar: title != null
            ? CupertinoNavigationBar(
                leading: const Icon(Icons.menu),
                backgroundColor: context.colorScheme.inversePrimary,
                middle: Text(title!),
                trailing: trailing,
              )
            : null,
        child: SafeArea(child: body),
      );
    }
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
              centerTitle: true,
              actions: [
                trailing != null
                    ? Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: trailing,
                      )
                    : const SizedBox()
              ],
            )
          : null,
      body: SafeArea(child: body),
    );
  }
}
