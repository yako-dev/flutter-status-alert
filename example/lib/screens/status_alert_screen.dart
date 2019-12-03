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
                'https://www.legalzoom.com'
                '/sites/legalzoom.com/files/images/uploaded/'
                'xhow_to_copyright_a_song_1.jpg.pagespeed.ic.2yMm8SpPm5.jpg',
              ),
            ),
            title: Text('Some song'),
            subtitle: Text('Some Artist'),
            trailing: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                StatusAlert.show(
                  context,
                  duration: Duration(milliseconds: 1400),
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
