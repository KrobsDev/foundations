import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: kDefaultBackground,
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(color: kDefaultBackground),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: inactiveColor.withOpacity(0.2),
                child: Icon(
                  Icons.notifications_active,
                  color: kDefaultBackground,
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Notification Title'),
                  Text(
                    '5:36am',
                    style: TextStyle(color: inactiveColor, fontSize: 14),
                  ),
                ],
              ),
              subtitle: const Text('This is the notification body'),
            )
          ],
        ),
      ),
    );
  }
}
