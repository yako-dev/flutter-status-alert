import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:status_alert/status_alert.dart';

void main() {
  testWidgets('Test Alert Widget', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(TestApp());

      final listTileFinder = find.text('Ones and Zeros');
      final iconButtonFinder = find.byIcon(Icons.favorite_border);
      final alertFinder  = find.text('Loved');

      await tester.tap(iconButtonFinder);

      await tester.pumpAndSettle(const Duration(seconds:1));

      await tester.ensureVisible(alertFinder);

      expect(alertFinder, findsOneWidget);
      expect(listTileFinder, findsOneWidget);
      expect(iconButtonFinder, findsWidgets);
    });
  });
}

class TestApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: StatusAlertScreen(),
    );
  }
}

class StatusAlertScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Status Alert')),
      body: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 40,
            height: 40,
            color: Colors.black,
          ),
        ),
        title: Text('Ones and Zeros'),
        subtitle: Text('Young Guns'),
        trailing: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {
            StatusAlert.show(

              context,
              duration: Duration(seconds: 3),
              title: 'Loved',
              subtitle: 'We\'ll recommend more like this For You.',
              configuration: IconConfiguration(icon: Icons.favorite_border),
            );
          },
        ),
      ),
    );
  }
}
