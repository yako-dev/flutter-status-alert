# Status Alert for Flutter

[![Pub Version](https://img.shields.io/pub/v/status_alert?color=blueviolet)](https://pub.dev/packages/status_alert)
[![CI](https://github.com/yako-dev/flutter-status-alert/actions/workflows/ci.yml/badge.svg)](https://github.com/yako-dev/flutter-status-alert/actions/workflows/ci.yml)

<p align="center">
  <img src="https://raw.githubusercontent.com/yako-dev/flutter-status-alert/master/assets/status_alert_logo.png" height="400px">
</p>

Display Apple system-like self-hiding status alerts. Well suited for notifying users without interrupting their flow.

## Installing

```yaml
dependencies:
  status_alert: ^2.0.0
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
| `dismissOnBackgroundTap` | `bool` | `false` | Dismiss when background is tapped |
| `onComplete` | `VoidCallback?` | `null` | Called after dismiss animation ends |
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

```dart
StatusAlert.show(
  context,
  title: 'Loading',
  configuration: WidgetConfiguration(
    widget: RiveAnimation.asset('assets/animation.riv'),
  ),
);
```

## Programmatic Control

```dart
// Show
StatusAlert.show(context, title: 'Saved');

// Hide manually
StatusAlert.hide();

// Check visibility
if (StatusAlert.isVisible) { ... }
```

## `onComplete` Callback

Called after the alert finishes its dismiss animation:

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
