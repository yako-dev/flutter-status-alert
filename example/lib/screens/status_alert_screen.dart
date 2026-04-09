import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

class StatusAlertScreen extends StatelessWidget {
  const StatusAlertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Status Alert')),
      body: ListView.separated(
        itemCount: 20,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: const SizedBox(
                width: 50,
                height: 50,
                child: ColoredBox(
                  color: Color(0xFF1DB954),
                  child: Icon(Icons.music_note, color: Colors.white),
                ),
              ),
            ),
            title: const Text('Ones and Zeros'),
            subtitle: const Text('Young Guns'),
            trailing: IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                StatusAlert.show(
                  context,
                  duration: const Duration(seconds: 2),
                  maxWidth: 260,
                  title: 'Loved',
                  subtitle: "We'll recommend more like this For You.",
                  configuration:
                      const IconConfiguration(icon: Icons.favorite_border),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
