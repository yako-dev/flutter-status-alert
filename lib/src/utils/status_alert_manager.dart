import 'package:flutter/material.dart';

/// Keeps track of the single status alert that can be visible at a time.
class StatusAlertManager {
  static OverlayState? _state;
  static OverlayEntry? _alert;
  static OverlayEntry? _barrier;
  static VoidCallback? _onComplete;

  /// Whether an alert is currently shown.
  ///
  /// Also becomes false when the [Overlay] the alert was inserted into is
  /// disposed (for example when its [Navigator] leaves the tree), so the next
  /// alert is not blocked by one that can no longer be seen.
  static bool get isVisible => _alert != null && _state!.mounted;

  /// Inserts the widget built by [builder] into the closest [Overlay] of
  /// [context]. Does nothing if an alert is already visible.
  ///
  /// [builder] receives the callback the alert must call once its hide
  /// animation has finished. [onComplete] is called when the alert goes away
  /// on its own or through a background tap, but not through [dismiss].
  static void createView({
    required BuildContext context,
    required Widget Function(VoidCallback onHide) builder,
    bool dismissOnBackgroundTap = false,
    VoidCallback? onComplete,
  }) {
    if (isVisible) return;
    // Drops an alert whose overlay was disposed while it was showing.
    dismiss();

    final OverlayState state = Overlay.of(context);
    late final OverlayEntry alert;
    final Widget child = builder(() => _complete(alert));
    alert = OverlayEntry(builder: (_) => child);

    if (dismissOnBackgroundTap) {
      _barrier = OverlayEntry(
        builder: (_) => GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => _complete(alert),
          child: const ColoredBox(color: Colors.transparent),
        ),
      );
    }

    _state = state;
    _alert = alert;
    _onComplete = onComplete;

    if (_barrier != null) {
      state.insert(_barrier!);
    }
    state.insert(alert);
  }

  /// Removes the current alert right away, without calling its `onComplete`.
  static void dismiss() {
    final OverlayEntry? alert = _alert;
    final OverlayEntry? barrier = _barrier;
    _state = null;
    _alert = null;
    _barrier = null;
    _onComplete = null;
    alert
      ?..remove()
      ..dispose();
    barrier
      ?..remove()
      ..dispose();
  }

  /// Removes [alert] and calls its `onComplete`, unless it was already
  /// removed (a background tap and the end of the hide animation can both
  /// report the same alert).
  static void _complete(OverlayEntry alert) {
    if (!identical(alert, _alert)) return;
    final VoidCallback? onComplete = _onComplete;
    dismiss();
    onComplete?.call();
  }
}
