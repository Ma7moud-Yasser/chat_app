import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void customDialog(
  BuildContext context, {
  required String errorMessage,
  required bool isError,
}) {
  AwesomeDialog(
    context: context,
    dialogType: isError ? DialogType.error : DialogType.success,
    animType: AnimType.bottomSlide,
    title: isError ? 'Error' : 'Success',
    desc: errorMessage,
  ).show();
}
