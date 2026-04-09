import 'package:flutter/material.dart';
import 'package:status_alert/src/models/status_alert_media_configuration.dart';
import 'package:status_alert/src/models/status_alert_text_configuration.dart';
import 'package:status_alert/src/utils/status_alert_manager.dart';
import 'package:status_alert/src/widgets/status_alert_base_widget.dart';

class StatusAlert {
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
      child: StatusAlertBaseWidget(
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
        onHide: () {
          StatusAlertManager.dismiss();
          onComplete?.call();
        },
        configuration: configuration,
        subtitleOptions: subtitleConfig,
        backgroundColor: backgroundColor,
      ),
    );
  }

  static void hide() => StatusAlertManager.dismiss();

  static bool get isVisible => StatusAlertManager.isVisible;
}
