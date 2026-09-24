import 'package:flutter/widgets.dart';
import 'package:status_alert/src/models/status_alert_media_configuration.dart';
import 'package:status_alert/src/models/status_alert_text_configuration.dart';
import 'package:status_alert/src/utils/status_alert_manager.dart';
import 'package:status_alert/src/widgets/status_alert_base_widget.dart';

/// Shows Apple-style, self-hiding status alerts.
class StatusAlert {
  /// Shows a status alert in the closest [Overlay] of [context].
  ///
  /// The alert fades in, stays for [duration], fades out and then calls
  /// [onComplete]. With [dismissOnBackgroundTap], a tap anywhere outside the
  /// alert removes it right away and also calls [onComplete]. Otherwise the
  /// alert ignores touches, so the widgets below stay usable.
  ///
  /// Only one alert is shown at a time: while one is visible, further calls
  /// are ignored (and their [onComplete] is never called).
  ///
  /// With a [WidgetConfiguration], the custom widget is the whole content of
  /// the alert: [title] and [subtitle] are not shown.
  static void show(
    BuildContext context, {
    String? title,
    String? subtitle,
    Color? backgroundColor,
    double blurPower = 2.0,
    double? maxWidth,
    StatusAlertTextConfiguration? titleOptions,
    StatusAlertTextConfiguration? subtitleOptions,
    PopupMediaConfiguration? configuration,
    Alignment alignment = Alignment.center,
    bool dismissOnBackgroundTap = false,
    EdgeInsets margin = const EdgeInsets.all(40.0),
    EdgeInsets padding = const EdgeInsets.all(30.0),
    Duration duration = const Duration(milliseconds: 1300),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
    VoidCallback? onComplete,
  }) {
    StatusAlertTextConfiguration titleConfig = titleOptions ??
        StatusAlertTextConfiguration(
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w600,
            fontFamily: 'SFNS',
          ),
        );

    StatusAlertTextConfiguration subtitleConfig = subtitleOptions ??
        StatusAlertTextConfiguration(
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'SFNS',
          ),
        );

    StatusAlertManager.createView(
      context: context,
      dismissOnBackgroundTap: dismissOnBackgroundTap,
      onComplete: onComplete,
      builder: (VoidCallback onHide) => StatusAlertBaseWidget(
        title: title,
        margin: margin,
        padding: padding,
        duration: duration,
        subtitle: subtitle,
        alignment: alignment,
        blurPower: blurPower,
        maxWidth: maxWidth,
        borderRadius: borderRadius,
        titleOptions: titleConfig,
        onHide: onHide,
        configuration: configuration,
        subtitleOptions: subtitleConfig,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Removes the visible alert right away, without calling its `onComplete`.
  static void hide() => StatusAlertManager.dismiss();

  /// Whether an alert is currently visible.
  static bool get isVisible => StatusAlertManager.isVisible;
}
