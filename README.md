# Status Alert for Flutter

[![Pub Version](https://img.shields.io/pub/v/status_alert?color=blueviolet)](https://pub.dev/packages/status_alert)
[![CI](https://github.com/yako-dev/flutter-status-alert/actions/workflows/ci.yml/badge.svg)](https://github.com/yako-dev/flutter-status-alert/actions/workflows/ci.yml)

<p align="center">
  <img src="https://raw.githubusercontent.com/yako-dev/flutter-status-alert/master/assets/status_alert_logo.png" height="400px">
</p>

Display Apple system-like self-hiding status alerts. Well suited for notifying users without interrupting their flow.

## Installing

Requirements: Flutter 3.47+ (`material_ui`). On older Flutter, use `status_alert: ^2.1.0`.

Apps not yet migrated to `material_ui` can keep `package:flutter/material.dart`; the alert then
uses the default (light) Material theme instead of the app's theme.

```yaml
dependencies:
  status_alert: ^3.0.0
```

```dart
import 'package:status_alert/status_alert.dart';
```

## Basic Usage

```dart
StatusAlert.show(
  context,
  duration: Duration(seconds: 2),
  title: 'Subscribed',
  subtitle: 'You will be notified of new posts',
  configuration: IconConfiguration(icon: Icons.done),
  maxWidth: 260,
);
```

## Parameters

| Parameter | Type | Default | Description |
|---|---|---|---|
| `title` | `String?` | `null` | Main text |
| `subtitle` | `String?` | `null` | Secondary text |
| `configuration` | `PopupMediaConfiguration?` | `null` | Icon or custom widget |
| `duration` | `Duration` | `1300ms` | How long the alert stays visible |
| `backgroundColor` | `Color?` | Theme-based | Alert background |
| `blurPower` | `double` | `2.0` | Background blur sigma |
| `maxWidth` | `double?` | `null` | Max width on large screens |
| `alignment` | `Alignment` | `center` | Alert position on screen |
| `margin` | `EdgeInsets` | `all(40)` | Outer spacing |
| `padding` | `EdgeInsets` | `all(30)` | Inner spacing |
| `borderRadius` | `BorderRadius` | `circular(10)` | Corner radius |
| `dismissOnBackgroundTap` | `bool` | `false` | Dismiss (and call `onComplete`) when the background is tapped |
| `onComplete` | `VoidCallback?` | `null` | Called after the alert is dismissed |
| `titleOptions` | `StatusAlertTextConfiguration?` | `null` | Title text styling |
| `subtitleOptions` | `StatusAlertTextConfiguration?` | `null` | Subtitle text styling |

## Media Configurations

### Icon

```dart
StatusAlert.show(
  context,
  title: 'Done',
  configuration: IconConfiguration(
    icon: Icons.check_circle,
    color: Colors.green,
    size: 60,
  ),
);
```

### Custom Widget (e.g. Rive animation)

The widget becomes the whole content of the alert, so `title` and `subtitle`
are not shown. Put any text inside your widget.

```dart
StatusAlert.show(
  context,
  configuration: WidgetConfiguration(
    widget: RiveAnimation.asset('assets/animation.riv'),
  ),
);
```

## Programmatic Control

```dart
// Show
StatusAlert.show(context, title: 'Saved');

// Hide manually (right away, without calling onComplete)
StatusAlert.hide();

// Check visibility
if (StatusAlert.isVisible) { ... }
```

Only one alert is shown at a time: calling `show()` while an alert is visible
does nothing.

## `onComplete` Callback

Called after the alert finishes its dismiss animation, or right after a
background tap when `dismissOnBackgroundTap` is `true`. It is not called when
the alert is removed with `StatusAlert.hide()`:

```dart
StatusAlert.show(
  context,
  title: 'Uploaded',
  onComplete: () => Navigator.push(context, ...),
);
```

## Migration from 1.x

| 1.x | 2.x |
|---|---|
| `FlareConfiguration` | Use `WidgetConfiguration` with a Rive widget |
| `textScaleFactor` in `StatusAlertTextConfiguration` | Use `textScaler` |
| Dart SDK `<3.0.0` | Requires Dart `>=3.0.0` |

<br>

## Apple Podcasts vs Status Alert

<img src="https://raw.githubusercontent.com/yako-dev/flutter-status-alert/master/assets/apple_podcasts_subscribed_animation.gif" height="500px">  <img src="https://raw.githubusercontent.com/yako-dev/flutter-status-alert/master/assets/status_alert_subscribed_animation.gif" height="500px">

## License

This project is licensed under the Apache License 2.0 — see the [LICENSE](LICENSE) file for details.
