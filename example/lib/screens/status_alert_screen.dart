import 'package:flutter/material.dart';
import 'package:status_alert/status_alert.dart';

class StatusAlertScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Status Alert')),
      body: ListView.separated(
        itemCount: 20,
        separatorBuilder: (_, __) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/en/thumb/4/4c/Ones_and_Zeros_Young_Guns.jpg/220px-Ones_and_Zeros_Young_Guns.jpg',
              ),
            ),
            title: Text('Ones and Zeros'),
            subtitle: Text('Young Guns'),
            trailing: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                StatusAlert.show(
                  context,
                  duration: Duration(milliseconds: 14000),
                  title: 'Loved',
                  subtitle: 'We\'ll recommend more like this For You.',
                  configuration: IconConfiguration(icon: Icons.favorite_border),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
