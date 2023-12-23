import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformButton extends StatelessWidget {
  const PlatformButton({
    super.key,
    required this.child,
    this.onPressed,
    this.isFilled,
    this.padding,
  });

  final void Function()? onPressed;
  final Widget child;
  final bool? isFilled;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    bool isApple = Platform.isIOS || Platform.isMacOS;

    if (isApple) {
      if (isFilled == true) {
        return CupertinoButton.filled(
          onPressed: onPressed,
          child: child,
        );
      }
      return CupertinoButton(
        padding: padding,
        onPressed: onPressed,
        child: child,
      );
    }
    if (isFilled == true) {
      return FilledButton(
        onPressed: onPressed,
        child: child,
      );
    }
    return TextButton(
      onPressed: onPressed,
      child: child,
    );
  }
}
