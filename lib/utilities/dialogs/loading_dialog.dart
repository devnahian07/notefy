import 'package:flutter/material.dart';

typedef CloseDialog = void Function();

CloseDialog showLoadingDialog({required BuildContext context, required String text}){
  final dialog = AlertDialog(
    content: Column(
      mainAxisSize: MainAxisSize.min, // column pretends to take as much of the height of the screen it can take, so we use this
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 10.0,), // used instead of spaces
        Text(text),
      ],
    ),
  );

  showDialog(context: context, 
    barrierDismissible:false, // so that upon pressing outside of the dialog it doesn't get closed
    builder: (context) => dialog
  );

  return () => Navigator.of(context).pop();
}