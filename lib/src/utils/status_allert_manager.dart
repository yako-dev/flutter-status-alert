import 'package:flutter/material.dart';

class StatusAlertManager {
  static OverlayState state;
  static OverlayEntry alert;
  static bool isVisible = false;

  static void createView({
    @required BuildContext context,
    @required Widget child,
    bool dismissOnBackgroundTap = false,
  }) async {
    if (dismissOnBackgroundTap) {
      showDialog(
        context: context,
        builder: (_) => child,
        barrierColor: Colors.transparent,
      );
    } else if (!isVisible) {
      dismiss();
      state = Overlay.of(context);
      alert = OverlayEntry(builder: (_) => child);
      isVisible = true;
      state.insert(alert);
    }
  }

  static void dismiss() async {
    if (!isVisible) {
      return;
    }
    isVisible = false;
    alert?.remove();
  }
}
