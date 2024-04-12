import 'package:chat_app/core/styles/color_manager.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final void Function()? onPressed;
  bool isLoading = false;
  CustomButton({
    super.key,
    required this.name,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.primary,
        fixedSize: Size(
          MediaQuery.sizeOf(context).width,
          MediaQuery.sizeOf(context).height * .07,
        ),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: onPressed,
      child: isLoading
          ? CircularProgressIndicator.adaptive(
              backgroundColor: ColorManager.secondary,
              valueColor: AlwaysStoppedAnimation<Color>(ColorManager.primary),
            )
          : Text(
              name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w500,
                color: ColorManager.secondary,
              ),
            ),
    );
  }
}
