import 'package:chat_app/core/styles/color_manager.dart';
import 'package:flutter/material.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String title;
  final TextInputType? keyboardType;
  final IconData? icon;

  const CustomTextForm({
    Key? key,
    required this.controller,
    required this.validator,
    required this.title,
    this.keyboardType,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: Text(
            title,
            style: const TextStyle(
              color: ColorManager.gray,
              fontSize: 20,
            ),
          ),
        ),
        TextFormField(
          style: const TextStyle(color: ColorManager.white),
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: ColorManager.darkGray,
            errorStyle: const TextStyle(
              color: ColorManager.danger,
              fontSize: 14,
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorManager.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorManager.primary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorManager.primary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: ColorManager.primary),
            ),
            prefixIcon: Icon(
              icon,
              color: ColorManager.primary,
            ),
          ),
          keyboardType: keyboardType,
          validator: validator,
        ),
      ],
    );
  }
}
