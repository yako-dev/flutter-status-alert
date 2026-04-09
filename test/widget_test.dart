import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/src/widgets/status_alert_base_widget.dart';
import 'package:status_alert/src/utils/status_alert_manager.dart';
import 'package:status_alert/status_alert.dart';

void main() {
  group('StatusAlertBaseWidget rendering', () {
    late StatusAlertBaseWidget statusAlert;

    setUp(() {
      statusAlert = StatusAlertBaseWidget(
        duration: const Duration(minutes: 1),
        title: 'Subscribed',
        margin: const EdgeInsets.all(40.0),
        padding: EdgeInsets.zero,
        subtitle: 'test',
        alignment: Alignment.center,
        blurPower: 15,
        maxWidth: 260,
        titleOptions: StatusAlertTextConfiguration(
          style: const TextStyle(
            color: Colors.red,
            fontSize: 23,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitleOptions: StatusAlertTextConfiguration(
          style: const TextStyle(
            color: Colors.orange,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        onHide: StatusAlertManager.dismiss,
        configuration: const IconConfiguration(
          icon: Icons.favorite_border,
          color: Colors.blue,
        ),
        backgroundColor: Colors.green,
      );
    });

    testWidgets('Widget renders correctly', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrap(statusAlert));
        expect(find.byType(StatusAlertBaseWidget), findsOneWidget);
      });
    });

    testWidgets('Title content matches', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrap(statusAlert));
        expect(find.text('Subscribed'), findsOneWidget);
      });
    });

    testWidgets('Title style matches', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrap(statusAlert));
        final titleWidget = tester.widget<Text>(find.text('Subscribed'));
        expect(titleWidget.style?.color, Colors.red);
        expect(titleWidget.style?.fontSize, 23);
        expect(titleWidget.style?.fontWeight, FontWeight.w600);
      });
    });

    testWidgets('Subtitle content matches', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrap(statusAlert));
        expect(find.text('test'), findsOneWidget);
      });
    });

    testWidgets('Subtitle style matches', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrap(statusAlert));
        final subtitleWidget = tester.widget<Text>(find.text('test'));
        expect(subtitleWidget.style?.color, Colors.orange);
        expect(subtitleWidget.style?.fontSize, 16);
        expect(subtitleWidget.style?.fontWeight, FontWeight.w400);
      });
    });

    testWidgets('Background color matches', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrap(statusAlert));
        final widget = tester
            .widget<StatusAlertBaseWidget>(find.byType(StatusAlertBaseWidget));
        expect(widget.backgroundColor, Colors.green);
      });
    });

    testWidgets('Icon renders correctly', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrap(statusAlert));
        expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      });
    });

    testWidgets('Icon color matches', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrap(statusAlert));
        final iconWidget =
            tester.widget<Icon>(find.byIcon(Icons.favorite_border));
        expect(iconWidget.color, Colors.blue);
      });
    });
  });

  group('WidgetConfiguration', () {
    testWidgets('Custom widget renders inside alert', (tester) async {
      await tester.runAsync(() async {
        const widget = StatusAlertBaseWidget(
          duration: Duration(minutes: 1),
          title: null,
          margin: EdgeInsets.all(40.0),
          padding: EdgeInsets.zero,
          subtitle: null,
          alignment: Alignment.center,
          blurPower: 0.0,
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          onHide: StatusAlertManager.dismiss,
          backgroundColor: null,
          configuration: WidgetConfiguration(
            widget: Icon(Icons.check, key: Key('custom_widget')),
          ),
        );
        await tester.pumpWidget(_wrap(widget));
        expect(find.byKey(const Key('custom_widget')), findsOneWidget);
      });
    });
  });

  group('StatusAlert.show integration', () {
    tearDown(() {
      // Ensure manager is clean between tests
      StatusAlertManager.dismiss();
    });

    testWidgets('show() inserts overlay and isVisible becomes true',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  StatusAlert.show(
                    context,
                    title: 'Hello',
                    duration: const Duration(minutes: 1),
                    configuration: const IconConfiguration(icon: Icons.done),
                  );
                },
                child: const Text('Show'),
              );
            },
          ),
        ),
      );

      expect(StatusAlert.isVisible, isFalse);
      await tester.tap(find.text('Show'));
      await tester.pump();
      expect(StatusAlert.isVisible, isTrue);
    });

    testWidgets('hide() removes alert and isVisible becomes false',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  StatusAlert.show(
                    context,
                    title: 'Hello',
                    duration: const Duration(minutes: 1),
                    configuration: const IconConfiguration(icon: Icons.done),
                  );
                },
                child: const Text('Show'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show'));
      await tester.pump();
      expect(StatusAlert.isVisible, isTrue);

      StatusAlert.hide();
      await tester.pump();
      expect(StatusAlert.isVisible, isFalse);
    });

    testWidgets('onComplete callback is invoked when alert finishes',
        (tester) async {
      bool completed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  StatusAlert.show(
                    context,
                    title: 'Done',
                    duration: const Duration(milliseconds: 100),
                    configuration: const IconConfiguration(icon: Icons.done),
                    onComplete: () => completed = true,
                  );
                },
                child: const Text('Show'),
              );
            },
          ),
        ),
      );

      await tester.tap(find.text('Show'));

      // Wait for animation in (200ms) + display (100ms) + animation out (200ms)
      await tester.runAsync(() async {
        await Future.delayed(const Duration(milliseconds: 600));
      });
      await tester.pumpAndSettle();

      expect(completed, isTrue);
    });

    testWidgets('Underlying widgets remain tappable while alert is visible',
        (tester) async {
      bool buttonTapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Builder(
                  builder: (context) => ElevatedButton(
                    onPressed: () {
                      StatusAlert.show(
                        context,
                        title: 'Alert',
                        duration: const Duration(minutes: 1),
                        alignment: Alignment.bottomCenter,
                      );
                    },
                    child: const Text('Show Alert'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () => buttonTapped = true,
                  child: const Text('Tap me'),
                ),
              ],
            ),
          ),
        ),
      );

      await tester.tap(find.text('Show Alert'));
      await tester.pump();
      expect(StatusAlert.isVisible, isTrue);

      // The alert uses IgnorePointer — underlying widgets should still respond
      await tester.tap(find.text('Tap me'));
      await tester.pump();
      expect(buttonTapped, isTrue);

      StatusAlert.hide();
    });
  });
}

Widget _wrap(Widget testWidget) {
  return MaterialApp(home: testWidget);
}
