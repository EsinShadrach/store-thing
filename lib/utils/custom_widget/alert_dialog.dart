import 'package:flutter/cupertino.dart';

void showAlertDialog(
  BuildContext context, {
  required String title,
  required String content,
  void Function()? onPressed,
  String? actionText,
  bool isDestructiveAction = true,
}) {
  showCupertinoModalPopup<void>(
    context: context,
    builder: (BuildContext context) => CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <CupertinoDialogAction>[
        // CupertinoDialogAction(
        //   isDefaultAction: true,
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        //   child: const Text('No'),
        // ),
        CupertinoDialogAction(
          isDestructiveAction: isDestructiveAction,
          onPressed: () {
            onPressed!();
            Navigator.pop(context);
          },
          child: Text(actionText ?? "Okay"),
        ),
      ],
    ),
  );
}
