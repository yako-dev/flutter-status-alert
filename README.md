# Status Alert for Flutter

[![Pub Version](https://img.shields.io/pub/v/status_alert?color=blueviolet)](https://pub.dev/packages/status_alert)

<p align="center">
  <img src="https://raw.githubusercontent.com/yako-dev/flutter-status-alert/master/assets/status_alert_logo.png" height="400px">
</p>


## Installing:
In your pubspec.yaml
```yaml
dependencies:
  status_alert: ^0.1.3
```
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
    )
```
<br>
<br>

## Apple Podcasts vs Status Alert:
<img src="https://raw.githubusercontent.com/yako-dev/flutter-status-alert/master/assets/apple_podcasts_subscribed_animation.gif" height="500px">  <img src="https://raw.githubusercontent.com/yako-dev/flutter-status-alert/master/assets/status_alert_subscribed_animation.gif" height="500px">
<br>



## License
This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details
