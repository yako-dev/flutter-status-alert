import 'dart:ui';

//import 'package:flare_flutter/flare_actor.dart';
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

  const StatusAlertBaseWidget(
      {Key? key,
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
      this.maxWidth})
      : super(key: key);

  @override
  TDBaseWidgetState createState() => TDBaseWidgetState();
}

class TDBaseWidgetState extends State<StatusAlertBaseWidget>
    with SingleTickerProviderStateMixin {
  Duration animationDuration = const Duration(milliseconds: 200);
  AnimationController? scaleController;
  AnimationController? animationController;
  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  final Tween<double> scaleTween = Tween<double>(begin: 0.9, end: 1.0);
  final Tween<double> fadeTween = Tween<double>(begin: 0.0, end: 1.0);

  @override
  void initState() {
    initAnimations();
    super.initState();
  }

  Future<void> initAnimations() async {
    animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    scaleAnimation = scaleTween.animate(animationController!);
    fadeAnimation = fadeTween.animate(animationController!);
    if (mounted) {
      animationController?.forward();
      await Future.delayed(animationDuration);
      await Future.delayed(widget.duration!);
    }
    if (mounted) {
      animationController?.reverse();
      await Future.delayed(animationDuration);
    }
    widget.onHide!();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IgnorePointer(
        child: Material(
          color: Colors.transparent,
          child: Container(
            alignment: widget.alignment,
            child: Padding(
              padding: widget.margin,
              child: buildBody(),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return ScaleTransition(
      scale: scaleAnimation,
      child: FadeTransition(
        opacity: fadeAnimation,
        child: ClipRRect(
          borderRadius: widget.borderRadius,
          child: buildContent(),
        ),
      ),
    );
  }

  Widget buildContent() {
    double screenWidth =
        MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.height;

    // Used to contoll the widget size on big screens
    if (widget.maxWidth != null && screenWidth > widget.maxWidth! / 0.72) {
      screenWidth = widget.maxWidth! / 0.72;
    }

    List<Widget> content = <Widget>[];
    if (widget.configuration is WidgetConfiguration) {
      WidgetConfiguration config = widget.configuration as WidgetConfiguration;
      content.add(config.widget);
    } else {
      if (widget.configuration is IconConfiguration) {
        IconConfiguration config = widget.configuration as IconConfiguration;
        content.add(Padding(
          padding: config.margin,
          child: Icon(
            config.icon,
            key: config.key,
            size: config.size ?? screenWidth * 0.35,
            color: config.color ?? getThemeColor(),
            semanticLabel: config.semanticLabel,
            textDirection: config.textDirection,
          ),
        ));
      }
      if (widget.configuration is FlareConfiguration) {
        FlareConfiguration config = widget.configuration as FlareConfiguration;
        content.add(Padding(
          padding: config.margin,
          child: SizedBox(
            width: config.size.width,
            height: config.size.height,
            // child: FlareActor(
            //   config.filename,
            //   alignment: config.alignment,
            //   fit: config.fit,
            //   animation: config.animation,
            //   color: config.color,
            //   controller: config.controller,
            //   artboard: config.artboard,
            //   boundsNode: config.boundsNode,
            //   callback: config.callback,
            //   isPaused: config.isPaused,
            //   shouldClip: config.shouldClip,
            //   sizeFromArtboard: config.sizeFromArtboard,
            //   snapToEnd: config.snapToEnd,
            // ),
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
              color: widget.titleOptions!.style.color ?? getThemeColor(),
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
            textScaleFactor: widget.titleOptions!.textScaleFactor,
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
                        : darkAccent)),
            locale: widget.subtitleOptions!.locale,
            softWrap: widget.subtitleOptions!.softWrap,
            maxLines: widget.subtitleOptions!.maxLines,
            overflow: widget.subtitleOptions!.overflow,
            textAlign: widget.subtitleOptions!.textAlign,
            strutStyle: widget.subtitleOptions!.strutStyle,
            textDirection: widget.subtitleOptions!.textDirection,
            textWidthBasis: widget.subtitleOptions!.textWidthBasis,
            semanticsLabel: widget.subtitleOptions!.semanticsLabel,
            textScaleFactor: widget.subtitleOptions!.textScaleFactor,
          ),
        ));
      }
    }
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 2.0,
        sigmaY: 2.0,
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

  Color getThemeColor() {
    return Theme.of(context).brightness == Brightness.light
        ? lightAccent
        : darkAccent;
  }
}
