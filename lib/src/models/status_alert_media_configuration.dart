import 'package:flutter/material.dart';

@immutable
abstract class PopupMediaConfiguration {
  const PopupMediaConfiguration();
}

@immutable
class IconConfiguration extends PopupMediaConfiguration {
  /// Key
  final Key? key;

  /// The icon to display.
  final IconData icon;

  /// The size of the icon in logical pixels.
  final double? size;

  /// The color to use when drawing the icon.
  final Color? color;

  /// Semantic label for the icon.
  final String? semanticLabel;

  /// The text direction to use for rendering the icon.
  final TextDirection? textDirection;

  /// Margin for [Icon]
  final EdgeInsets margin;

  const IconConfiguration({
    this.key,
    this.margin = const EdgeInsets.all(0.0),
    this.size,
    this.icon = Icons.done,
    this.color,
    this.semanticLabel,
    this.textDirection,
  });
}

@immutable
class ImageConfiguration extends PopupMediaConfiguration {
  const ImageConfiguration();
}

@immutable
class WidgetConfiguration extends PopupMediaConfiguration {
  /// The widget to be displayed.
  /// All in your hands!!!
  ///
  /// _____＼＿ﾍ(︶ω︶)
  ///
  final Widget widget;

  const WidgetConfiguration({
    required this.widget,
  });
}
