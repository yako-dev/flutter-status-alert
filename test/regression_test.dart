import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:status_alert/status_alert.dart';

/// Pumps a MaterialApp and returns a context that has an Overlay above it.
Future<BuildContext> _pumpApp(WidgetTester tester) async {
  late BuildContext context;
  await tester.pumpWidget(
    MaterialApp(
      home: Builder(
        builder: (BuildContext c) {
          context = c;
          return const SizedBox();
        },
      ),
    ),
  );
  return context;
}

/// A page with a nested Navigator (like a tab) that can be removed.
class _NestedNavigatorPage extends StatefulWidget {
  const _NestedNavigatorPage();

  @override
  State<_NestedNavigatorPage> createState() => _NestedNavigatorPageState();
}

class _NestedNavigatorPageState extends State<_NestedNavigatorPage> {
  bool showNested = true;
  late BuildContext nestedContext;

  void removeNestedNavigator() => setState(() => showNested = false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showNested
          ? Navigator(
              onGenerateRoute: (_) => MaterialPageRoute<void>(
                builder: (BuildContext c) {
                  nestedContext = c;
                  return const Text('nested');
                },
              ),
            )
          : const Text('other'),
    );
  }
}

void main() {
  testWidgets(
      'a new alert shows after the overlay of the previous one was disposed',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: _NestedNavigatorPage()));
    final _NestedNavigatorPageState page =
        tester.state(find.byType(_NestedNavigatorPage));

    StatusAlert.show(
      page.nestedContext,
      title: 'First',
      duration: const Duration(seconds: 5),
    );
    await tester.pump();
    expect(find.text('First'), findsOneWidget);

    // Removing the nested Navigator disposes its Overlay and the alert in it.
    page.removeNestedNavigator();
    await tester.pump();
    expect(find.text('First'), findsNothing);
    expect(StatusAlert.isVisible, isFalse);

    StatusAlert.show(
      page.context,
      title: 'Second',
      duration: const Duration(milliseconds: 100),
    );
    await tester.pump();
    expect(find.text('Second'), findsOneWidget);
    expect(StatusAlert.isVisible, isTrue);

    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(StatusAlert.isVisible, isFalse);
  });

  testWidgets('hide() does not leave a pending timer behind',
      (WidgetTester tester) async {
    final BuildContext context = await _pumpApp(tester);
    StatusAlert.show(context,
        title: 'Alert', duration: const Duration(seconds: 5));
    await tester.pump();
    // The fade-in is done, so the alert is waiting for `duration`.
    await tester.pump(const Duration(milliseconds: 300));

    StatusAlert.hide();
    await tester.pump();
    expect(find.text('Alert'), findsNothing);
    // The test framework fails the test if a Timer is still pending here.
  });

  testWidgets('a background tap dismisses the alert and calls onComplete once',
      (WidgetTester tester) async {
    final BuildContext context = await _pumpApp(tester);
    int completed = 0;
    StatusAlert.show(
      context,
      title: 'Alert',
      dismissOnBackgroundTap: true,
      duration: const Duration(seconds: 5),
      onComplete: () => completed++,
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    await tester.tapAt(const Offset(5, 5));
    await tester.pump();
    expect(StatusAlert.isVisible, isFalse);
    expect(find.text('Alert'), findsNothing);
    expect(completed, 1);

    await tester.pump(const Duration(seconds: 6));
    expect(completed, 1);
  });

  testWidgets('hide() does not call onComplete', (WidgetTester tester) async {
    final BuildContext context = await _pumpApp(tester);
    int completed = 0;
    StatusAlert.show(
      context,
      title: 'Alert',
      duration: const Duration(milliseconds: 100),
      onComplete: () => completed++,
    );
    await tester.pump();
    StatusAlert.hide();
    await tester.pump(const Duration(seconds: 1));
    expect(completed, 0);
  });

  testWidgets(
      'the end of a hidden alert does not dismiss the alert shown after it',
      (WidgetTester tester) async {
    final BuildContext context = await _pumpApp(tester);
    int firstCompleted = 0;
    StatusAlert.show(
      context,
      title: 'First',
      duration: const Duration(milliseconds: 100),
      onComplete: () => firstCompleted++,
    );
    await tester.pump(); // fade-in starts
    await tester.pump(const Duration(milliseconds: 250)); // fade-in done
    await tester.pump(const Duration(milliseconds: 100)); // fade-out starts
    await tester.pump(const Duration(milliseconds: 150)); // fade-out 3/4 done

    // Replace the alert in the frame where its fade-out finishes.
    StatusAlert.hide();
    StatusAlert.show(
      context,
      title: 'Second',
      duration: const Duration(seconds: 5),
    );
    await tester.pump(const Duration(milliseconds: 100));

    expect(find.text('Second'), findsOneWidget);
    expect(StatusAlert.isVisible, isTrue);
    expect(firstCompleted, 0);

    StatusAlert.hide();
    await tester.pump();
  });

  testWidgets('a bottom alert stays above the keyboard',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1170, 2532);
    tester.view.devicePixelRatio = 3;
    tester.view.viewInsets = const FakeViewPadding(bottom: 900);
    addTearDown(tester.view.reset);
    const double keyboardTop = 844 - 300;

    final BuildContext context = await _pumpApp(tester);
    StatusAlert.show(
      context,
      title: 'Alert',
      alignment: Alignment.bottomCenter,
      duration: const Duration(milliseconds: 100),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    final Rect alert = tester.getRect(find.byType(BackdropFilter));
    expect(alert.bottom, lessThanOrEqualTo(keyboardTop));

    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('the alert is a live region for screen readers',
      (WidgetTester tester) async {
    final SemanticsHandle semantics = tester.ensureSemantics();
    final BuildContext context = await _pumpApp(tester);
    StatusAlert.show(
      context,
      title: 'Saved',
      duration: const Duration(milliseconds: 100),
    );
    await tester.pump();

    bool isLiveRegion = false;
    for (SemanticsNode? node = tester.getSemantics(find.text('Saved'));
        node != null;
        node = node.parent) {
      if (isSemantics(isLiveRegion: true).matches(node, {})) {
        isLiveRegion = true;
      }
    }
    expect(isLiveRegion, isTrue);

    await tester.pump(const Duration(seconds: 1));
    semantics.dispose();
  });

  testWidgets('content scales down instead of overflowing in phone landscape',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(2532, 1170);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final BuildContext context = await _pumpApp(tester);
    StatusAlert.show(
      context,
      maxWidth: 260,
      title: 'Loved',
      subtitle: "We'll recommend more like this For You.",
      configuration: const IconConfiguration(icon: Icons.favorite_border),
      duration: const Duration(milliseconds: 100),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    // A RenderFlex overflow would be reported here.
    expect(tester.takeException(), isNull);
    expect(find.text('Loved'), findsOneWidget);
    final Rect alert = tester.getRect(find.byType(BackdropFilter));
    expect(alert.top, greaterThanOrEqualTo(0));
    expect(alert.bottom, lessThanOrEqualTo(390));

    await tester.pump(const Duration(seconds: 1));
  });
}
