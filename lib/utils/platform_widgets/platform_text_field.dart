import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformTextField extends StatelessWidget {
  const PlatformTextField({
    super.key,
    required this.controller,
    required this.obsureText,
    required this.enableSuggestions,
    required this.autocorrect,
    required this.placeholder,
    this.onSubmitted,
    this.onChanged,
  });

  static const Color turquoise = Color(0xFF40E0D0);
  final TextEditingController controller;
  final bool obsureText;
  final bool enableSuggestions;
  final bool autocorrect;
  final String placeholder;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    bool isApple = Platform.isIOS || Platform.isMacOS;

    if (isApple) {
      return CupertinoTextField(
        onSubmitted: onSubmitted,
        controller: controller,
        onChanged: onSubmitted,
        obscureText: obsureText,
        enableSuggestions: enableSuggestions,
        autocorrect: autocorrect,
        padding: const EdgeInsets.all(10),
        placeholder: placeholder,
      );
    }
    return TextField(
      controller: controller,
      obscureText: obsureText,
      enableSuggestions: enableSuggestions,
      onChanged: onSubmitted,
      onSubmitted: onSubmitted,
      autocorrect: autocorrect,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(10),
        labelText: placeholder,
      ),
    );
  }
}
