import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chat_app/core/styles/color_manager.dart';
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
    titleTextStyle: const TextStyle(
      color: ColorManager.primary,
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
    descTextStyle: const TextStyle(
      color: ColorManager.white,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    desc: errorMessage,
    dialogBackgroundColor: ColorManager.secondary,
  ).show();
}
