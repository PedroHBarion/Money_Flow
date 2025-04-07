export 'toast_widget.dart';

import 'package:flutter/material.dart';
import 'toast_widget.dart';

enum ToastType { success, error }

void showToast(BuildContext context, String message, ToastType type) {
  if (!context.mounted) return;

  final overlay = Overlay.of(context);
  if (!overlay.mounted) return;

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (_) => AnimatedToast(
      message: message,
      type: type,
      onDismissed: () {
        if (overlayEntry.mounted) {
          overlayEntry.remove();
        }
      },
    ),
  );

  overlay.insert(overlayEntry);
}
