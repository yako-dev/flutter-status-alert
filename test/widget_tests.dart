import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:status_alert/src/widgets/status_alert_base_widget.dart';
import 'package:status_alert/src/utils/status_allert_manager.dart';
import 'package:status_alert/status_alert.dart';

void main() {
  group('Status Alert Test', () {
    final statusAlert = StatusAlertBaseWidget(
      duration: Duration(minutes: 1),
      title: 'Subscribed',
      margin: const EdgeInsets.all(40.0),
      padding: EdgeInsets.zero,
      subtitle: 'test',
      alignment: Alignment.center,
      blurPower: 15,
      maxWidth: 260,
      titleOptions: StatusAlertTextConfiguration(
        style: TextStyle(
          color: Colors.red,
          fontSize: 23,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitleOptions: StatusAlertTextConfiguration(
        style: TextStyle(
          color: Colors.orange,
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      onHide: StatusAlertManager.dismiss,
      configuration: IconConfiguration(
        icon: Icons.favorite_border,
        color: Colors.blue,
      ),
      backgroundColor: Colors.green,
    );

    final iconButton = Builder(builder: (context) {
      return IconButton(
        icon: Icon(Icons.favorite_border),
        onPressed: () {
          StatusAlert.show(
            context,
            duration: Duration(seconds: 2),
            maxWidth: 20,
            title: 'Loved',
            subtitle: 'We\'ll recommend more like this For You.',
            configuration: IconConfiguration(icon: Icons.favorite_border),
          );
        },
      );
    });

    testWidgets('Widget should render correctly', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrapWithMaterialApp(statusAlert));

        expect(find.byType(StatusAlertBaseWidget), findsOneWidget);
      });
    });

    testWidgets('Title content should match', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrapWithMaterialApp(statusAlert));

        expect(find.text('Subscribed'), findsOneWidget);
      });
    });

    testWidgets('Title style should match', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrapWithMaterialApp(statusAlert));

        final titleWidget = tester.widget<Text>(find.text('Subscribed'));

        expect(titleWidget.style?.color, Colors.red);
        expect(titleWidget.style?.fontSize, 23);
        expect(titleWidget.style?.fontWeight, FontWeight.w600);
      });
    });

    testWidgets('SubTitle content should match', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrapWithMaterialApp(statusAlert));

        expect(find.text('test'), findsOneWidget);
      });
    });

    testWidgets('SubTitle style should match', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrapWithMaterialApp(statusAlert));

        final titleWidget = tester.widget<Text>(find.text('test'));

        expect(titleWidget.style?.color, Colors.orange);
        expect(titleWidget.style?.fontSize, 16);
        expect(titleWidget.style?.fontWeight, FontWeight.w400);
      });
    });

    testWidgets('Widget color should match', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrapWithMaterialApp(statusAlert));

        final statusAlertWidget = tester
            .widget<StatusAlertBaseWidget>(find.byType(StatusAlertBaseWidget));

        expect(statusAlertWidget.backgroundColor, Colors.green);
      });
    });

    testWidgets('Icon content should match', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrapWithMaterialApp(statusAlert));

        expect(find.byIcon(Icons.favorite_border), findsOneWidget);
      });
    });

    testWidgets('Icon colour should match', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrapWithMaterialApp(statusAlert));
        final iconWidget =
            tester.widget<Icon>(find.byIcon(Icons.favorite_border));

        expect(iconWidget.color, Colors.blue);
      });
    });

    testWidgets('Alert should appears after onTap ', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrapWithMaterialApp(iconButton));

        await tester.tap(find.byIcon(Icons.favorite_border));
        await tester.pumpAndSettle();
        expect(find.byType(StatusAlertBaseWidget), findsOneWidget);
      });
    });

    testWidgets('Alert should disappears after duration', (tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(_wrapWithMaterialApp(iconButton));

        await tester.tap(find.byIcon(Icons.favorite_border));
        await tester.pumpAndSettle();
        await new Future.delayed(new Duration(seconds: 3));
        await tester.pumpAndSettle();
        expect(find.byType(StatusAlertBaseWidget), findsNothing);
      });
    });
  });
}

Widget _wrapWithMaterialApp(Widget testWidget) {
  return MaterialApp(
      home: Scaffold(
    body: testWidget,
  ));
}
