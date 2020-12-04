import 'package:flutter/material.dart';
import 'package:status_alert/src/models/status_alert_media_configuration.dart';
import 'package:status_alert/src/models/status_alert_text_configuration.dart';
import 'package:status_alert/src/utils/status_allert_manager.dart';
import 'package:status_alert/src/widgets/status_alert_base_widget.dart';

class StatusAlert {
  static void show(
    BuildContext context, {
    String title,
    String subtitle,
    Color backgroundColor,
    double blurPower = 15,
    StatusAlertTextConfiguration titleOptions,
    StatusAlertTextConfiguration subtitleOptions,
    PopupMediaConfiguration configuration,
    Alignment alignment = Alignment.center,
    bool dismissOnBackgroundTap = false,
    EdgeInsets margin = const EdgeInsets.all(40.0),
    EdgeInsets padding = const EdgeInsets.all(30.0),
    Duration duration = const Duration(milliseconds: 1300),
    BorderRadius borderRadius = const BorderRadius.all(Radius.circular(10.0)),
  }) {
    StatusAlertTextConfiguration titleConfig = titleOptions;
    StatusAlertTextConfiguration subtitleConfig = subtitleOptions;
    if (titleConfig == null) {
      titleConfig = StatusAlertTextConfiguration();
      titleConfig.style = titleConfig.style.copyWith(
        fontSize: 23,
        fontWeight: FontWeight.w600,
      );
    }

    if (subtitleConfig == null) {
      subtitleConfig = StatusAlertTextConfiguration();
      subtitleConfig.style = subtitleConfig.style.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      );
    }

    StatusAlertManager.createView(
      context: context,
      dismissOnBackgroundTap: dismissOnBackgroundTap,
      child: StatusAlertBaseWidget(
        title: title,
        margin: margin,
        padding: padding,
        duration: duration,
        subtitle: subtitle,
        alignment: alignment,
        blurPower: blurPower,
        borderRadius: borderRadius,
        titleOptions: titleConfig,
        onHide: StatusAlertManager.dismiss,
        configuration: configuration,
        subtitleOptions: subtitleConfig,
        backgroundColor: backgroundColor,
      ),
    );
  }

  static void hide() => StatusAlertManager.dismiss();

  static get isVisible => StatusAlertManager.isVisible;
}
