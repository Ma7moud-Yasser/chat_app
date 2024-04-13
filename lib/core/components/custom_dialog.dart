import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void customDialog(
  BuildContext context, {
  required String errorMessage,
  required DialogType dialogType,
  required String title,
}) {
  AwesomeDialog(
    context: context,
    dialogType: dialogType,
    animType: AnimType.bottomSlide,
    title: title,
    desc: errorMessage,
  ).show();
}
