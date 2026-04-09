import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:status_alert/src/models/status_alert_media_configuration.dart';
import 'package:status_alert/src/models/status_alert_text_configuration.dart';
import 'package:status_alert/src/utils/colors.dart';

class StatusAlertBaseWidget extends StatefulWidget {
  final PopupMediaConfiguration? configuration;
  final BorderRadius borderRadius;
  final Color? backgroundColor;
  final Alignment alignment;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final String? title;
  final String? subtitle;
  final Duration? duration;
  final StatusAlertTextConfiguration? titleOptions;
  final StatusAlertTextConfiguration? subtitleOptions;
  final VoidCallback? onHide;
  final double? blurPower;
  final double? maxWidth;

  const StatusAlertBaseWidget({
    super.key,
    required this.margin,
    required this.padding,
    required this.alignment,
    required this.borderRadius,
    required this.backgroundColor,
    this.title,
    this.onHide,
    this.subtitle,
    this.duration,
    this.blurPower,
    this.titleOptions,
    this.configuration,
    this.subtitleOptions,
    this.maxWidth,
  });

  @override
  State<StatusAlertBaseWidget> createState() => _StatusAlertBaseWidgetState();
}

class _StatusAlertBaseWidgetState extends State<StatusAlertBaseWidget>
    with SingleTickerProviderStateMixin {
  static const Duration _animationDuration = Duration(milliseconds: 200);
  late final AnimationController _animationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  final Tween<double> _scaleTween = Tween<double>(begin: 0.9, end: 1.0);
  final Tween<double> _fadeTween = Tween<double>(begin: 0.0, end: 1.0);

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: _animationDuration,
      vsync: this,
    );
    _scaleAnimation = _scaleTween.animate(_animationController);
    _fadeAnimation = _fadeTween.animate(_animationController);
    _runAnimation();
  }

  Future<void> _runAnimation() async {
    if (!mounted) return;
    await _animationController.forward();
    if (!mounted) return;
    await Future.delayed(widget.duration!);
    if (!mounted) return;
    await _animationController.reverse();
    if (mounted) {
      widget.onHide?.call();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IgnorePointer(
        child: Material(
          color: Colors.transparent,
          child: Align(
            alignment: widget.alignment,
            child: Padding(
              padding: widget.margin,
              child: _buildBody(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    double screenWidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.height;

    if (widget.maxWidth != null && screenWidth > widget.maxWidth! / 0.72) {
      screenWidth = widget.maxWidth! / 0.72;
    }

    final List<Widget> content = <Widget>[];

    if (widget.configuration is WidgetConfiguration) {
      final config = widget.configuration as WidgetConfiguration;
      content.add(config.widget);
    } else {
      if (widget.configuration is IconConfiguration) {
        final config = widget.configuration as IconConfiguration;
        content.add(Padding(
          padding: config.margin,
          child: Icon(
            config.icon,
            key: config.key,
            size: config.size ?? screenWidth * 0.35,
            color: config.color ?? _themeColor,
            semanticLabel: config.semanticLabel,
            textDirection: config.textDirection,
          ),
        ));
      }

      if (widget.title != null) {
        content.add(Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            widget.title!,
            key: widget.titleOptions!.key,
            style: widget.titleOptions!.style.copyWith(
              color: widget.titleOptions!.style.color ?? _themeColor,
            ),
            locale: widget.titleOptions!.locale,
            softWrap: widget.titleOptions!.softWrap,
            maxLines: widget.titleOptions!.maxLines,
            overflow: widget.titleOptions!.overflow,
            textAlign: widget.titleOptions!.textAlign,
            strutStyle: widget.titleOptions!.strutStyle,
            textDirection: widget.titleOptions!.textDirection,
            textWidthBasis: widget.titleOptions!.textWidthBasis,
            semanticsLabel: widget.titleOptions!.semanticsLabel,
            textScaler: widget.titleOptions!.textScaler,
          ),
        ));
      }

      if (widget.subtitle != null) {
        content.add(Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(
            widget.subtitle!,
            key: widget.subtitleOptions!.key,
            style: widget.subtitleOptions!.style.copyWith(
              color: widget.subtitleOptions!.style.color ??
                  (Theme.of(context).brightness == Brightness.light
                      ? lightAccent
                      : darkAccent),
            ),
            locale: widget.subtitleOptions!.locale,
            softWrap: widget.subtitleOptions!.softWrap,
            maxLines: widget.subtitleOptions!.maxLines,
            overflow: widget.subtitleOptions!.overflow,
            textAlign: widget.subtitleOptions!.textAlign,
            strutStyle: widget.subtitleOptions!.strutStyle,
            textDirection: widget.subtitleOptions!.textDirection,
            textWidthBasis: widget.subtitleOptions!.textWidthBasis,
            semanticsLabel: widget.subtitleOptions!.semanticsLabel,
            textScaler: widget.subtitleOptions!.textScaler,
          ),
        ));
      }
    }

    final double blurSigma = widget.blurPower ?? 2.0;

    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: blurSigma,
        sigmaY: blurSigma,
      ),
      child: SizedBox(
        width: screenWidth * 0.72,
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Container(
            decoration: BoxDecoration(
              color: widget.backgroundColor ??
                  (Theme.of(context).brightness == Brightness.dark
                      ? darkBackground
                      : lightBackground),
              borderRadius: widget.borderRadius,
            ),
            child: Padding(
              padding: widget.padding,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: content,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color get _themeColor {
    return Theme.of(context).brightness == Brightness.light
        ? lightAccent
        : darkAccent;
  }
}
