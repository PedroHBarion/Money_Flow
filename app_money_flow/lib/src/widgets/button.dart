import 'package:flutter/material.dart';

enum ButtonVariant { normal, danger, ghost }

class Button extends StatelessWidget {
  final bool isLoading;
  final ButtonVariant variant;
  final VoidCallback? onPressed;
  final String text;
  final bool disabled;

  const Button({
    super.key,
    required this.text,
    this.isLoading = false,
    this.variant = ButtonVariant.normal,
    this.onPressed,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = disabled || isLoading;

    Color backgroundColor;
    Color textColor;
    BorderSide? border;

    switch (variant) {
      case ButtonVariant.danger:
        backgroundColor = isDisabled ? Colors.red[100]! : const Color(0xFFC92A2A);
        textColor = Colors.white;
        break;
      case ButtonVariant.ghost:
        backgroundColor = Color(0xffF1F3F5);
        textColor = isDisabled ? Colors.grey : const Color(0xFF1F1F1F);
        border = BorderSide(color: Colors.grey.shade800);
        break;
      case ButtonVariant.normal:
        backgroundColor = isDisabled ? Colors.grey.shade200 : const Color(0xFF087F5B);
        textColor = isDisabled ? Colors.grey : Colors.white;
      }

    return ElevatedButton(
      onPressed: isDisabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: border ?? BorderSide.none,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        elevation: 0,
      ),
      child: isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
    );
  }
}
