# Status Alert for Flutter

[![pub package](https://img.shields.io/badge/pub-0.1.0-blueviolet.svg)](https://pub.dev/packages/status_alert)

<p align="center">
  <img src="https://raw.githubusercontent.com/yako-dev/flutter-status-alert/master/assets/status_alert_logo.png" height="400px">
</p>


## Installing:
In your pubspec.yaml
```yaml
dependencies:
  status_alert: ^0.1.0
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

| <img src="https://raw.githubusercontent.com/yako-dev/flutter_status_alert/master/assets/apple_podcasts_subscribed_animation.gif" height="700px">  | <img src="https://raw.githubusercontent.com/yako-dev/flutter_status_alert/master/assets/status_alert_subscribed_animation.gif" height="700px"> |
| ------------- | ------------- | ------------ |
| `Apple Podcasts` | `Status Alert` |
<br>



## License
This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details
