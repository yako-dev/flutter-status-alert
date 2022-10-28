# Status Alert for Flutter

[![Pub Version](https://img.shields.io/pub/v/status_alert?color=blueviolet)](https://pub.dev/packages/status_alert)

<p align="center">
  <img src="https://raw.githubusercontent.com/yako-dev/flutter-status-alert/master/assets/status_alert_logo.png" height="400px">
</p>


## Installing:
1. Add the dependency in your `pubspec.yaml` file.

```yaml
dependencies:
  status_alert: ^1.0.1
```

2. Import the `settings_ui` package.

```dart
import 'package:status_alert/status_alert.dart';
```


## Basic Usage:
```dart
    StatusAlert.show(
      context,
      duration: Duration(seconds: 2),
      title: 'Title',
      subtitle: 'Subtitle',
      configuration: IconConfiguration(icon: Icons.done),
      maxWidth: 260,
    )
```
<br>
<br>

## Status Alert Base Widget

Status Alert Base Widget

### Parameters

| Parameter | Description | Required |
|--|--|--|
| PopupMediaConfiguration? configuration |  | +
| BorderRadius borderRadius | Set a border radius for Alert Widget | +
| Color? backgroundColor | Set a background color for Alert Widget | +
| Alignment alignment | Set an alignment of the whole widget  | +
| EdgeInsets padding | Set a padding of the content widget | +
| EdgeInsets margin | Margin of the content widget | +
| String? title | Set a title of Alert Widget | -
| String? subtitle | Set a subtitle of Alert Widget | -
| Duration? duration | Set a duration after which the widget disappears | -
| StatusAlertTextConfiguration? titleOptions | Set a TextConfiguration for title | -
| StatusAlertTextConfiguration? subtitleOptions | Set a TextConfiguration for subtitle | -
| VoidCallback? onHide | Set the function that will be called after duration | -
| double? blurPower | Set a blur Power for Alert Widget | -
| double? maxWidth | Set a max width Alert Widget | -

<br>
<br>
<br>
<br>

## Apple Podcasts vs Status Alert:
<img src="https://raw.githubusercontent.com/yako-dev/flutter-status-alert/master/assets/apple_podcasts_subscribed_animation.gif" height="500px">  <img src="https://raw.githubusercontent.com/yako-dev/flutter-status-alert/master/assets/status_alert_subscribed_animation.gif" height="500px">
<br>



## License
This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details
