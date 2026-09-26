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

<!-- more-from-yako:start -->
## More from Yako

Other Flutter packages from the same team:

<table>
  <tr>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/settings_ui"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/settings_ui.gif" width="220" alt="Animated demo of the settings_ui Flutter package: an iOS-style settings screen with Appearance and General sections; turning on Dark mode switches the whole list to dark."></a><br>
      <a href="https://pub.dev/packages/settings_ui"><b>settings_ui</b></a><br>
      <sub>Settings screens that look native on every platform.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/badges"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/badges.gif" width="220" alt="Animated demo of the badges Flutter package: a count badge on a cart icon goes from 1 to 4, a notification badge pops in, and a Twitter-style verified badge, a NEW label and an Instagram-shaped badge appear."></a><br>
      <a href="https://pub.dev/packages/badges"><b>badges</b></a><br>
      <sub>Badges for any widget: counters, dots, shapes and animations.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://github.com/yako-dev/flutter-yako-celebrations"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/yako_celebrations.webp" width="220" alt="Animated demo of the yako_celebrations Flutter package: an epic celebration fills a dark screen with fireworks, flames, spinning coins, confetti and popping Yako logos under a LEVEL UP! title."></a><br>
      <a href="https://github.com/yako-dev/flutter-yako-celebrations"><b>yako_celebrations</b></a><br>
      <sub>Full-screen celebrations in one line: confetti, coins, fireworks, flames.</sub>
    </td>
  </tr>
  <tr>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/full_screen_menu"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/full_screen_menu.gif" width="220" alt="Animated demo of the full_screen_menu Flutter package: a blurred full-screen overlay opens over a weather app with five round gradient buttons and a close button."></a><br>
      <a href="https://pub.dev/packages/full_screen_menu"><b>full_screen_menu</b></a><br>
      <sub>A full-screen menu with round gradient buttons.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/yako_theme_switch"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/yako_theme_switch.gif" width="220" alt="Animated demo of the yako_theme_switch Flutter package: a toggle whose sun thumb rolls into a moon as the screen changes from light mode to dark mode."></a><br>
      <a href="https://pub.dev/packages/yako_theme_switch"><b>yako_theme_switch</b></a><br>
      <sub>An animated switch between light and dark themes.</sub>
    </td>
    <td align="center" valign="top" width="33%">
      <a href="https://pub.dev/packages/diagonal_decoration"><img src="https://raw.githubusercontent.com/yako-dev/.github/main/tiles/diagonal_decoration.png" width="220" alt="Screenshot of the diagonal_decoration Flutter package: one card filled with fine diagonal lines (DiagonalDecoration) and one with a curved line mesh (MatrixDecoration)."></a><br>
      <a href="https://pub.dev/packages/diagonal_decoration"><b>diagonal_decoration</b></a><br>
      <sub>Diagonal-line and mesh backgrounds for boxes.</sub>
    </td>
  </tr>
</table>
<!-- more-from-yako:end -->

## License

This project is licensed under the Apache License 2.0 — see the [LICENSE](LICENSE) file for details.
