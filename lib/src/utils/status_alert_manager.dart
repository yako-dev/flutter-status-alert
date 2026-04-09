import 'package:flutter/material.dart';

class StatusAlertManager {
  static OverlayState? _state;
  static OverlayEntry? _alert;
  static OverlayEntry? _barrier;
  static bool isVisible = false;

  static void createView({
    required BuildContext context,
    required Widget child,
    bool dismissOnBackgroundTap = false,
  }) {
    if (isVisible) return;

    _state = Overlay.of(context);

    _alert = OverlayEntry(builder: (_) => child);

    if (dismissOnBackgroundTap) {
      _barrier = OverlayEntry(
        builder: (_) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: dismiss,
          child: const ColoredBox(color: Colors.transparent),
        ),
      );
    }

    isVisible = true;

    if (_barrier != null) {
      _state!.insert(_barrier!);
    }
    _state!.insert(_alert!);
  }

  static void dismiss() {
    if (!isVisible) return;
    isVisible = false;
    _alert?.remove();
    _alert = null;
    _barrier?.remove();
    _barrier = null;
  }
}
