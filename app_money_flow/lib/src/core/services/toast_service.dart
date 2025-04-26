import 'package:app_money_flow/src/widgets/toast/animated_toast.dart';
import 'package:flutter/material.dart';


class ToastService {
  late OverlayState _overlayState;
  OverlayEntry? _overlayEntry;
  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  void init(OverlayState overlayState) {
    _overlayState = overlayState;
    _isInitialized = true;
  }

  void show({
    required String message,
    required ToastType type,
  }) {
    if (_overlayEntry != null) return; 

    _overlayEntry = OverlayEntry(
      builder: (context) => AnimatedToast(
        message: message,
        type: type, 
        onDismissed: () {
          _overlayEntry?.remove();
          _overlayEntry = null;
        },
      ),
    );

    _overlayState.insert(_overlayEntry!);
  }
}
