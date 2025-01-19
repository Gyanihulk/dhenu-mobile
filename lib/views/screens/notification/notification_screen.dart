import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:dhenu_dharma/utils/providers/home_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder(
        future: homeProvider.fetchNotifications(), // Fetch notifications
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final notifications = homeProvider.notifications;

            if (notifications.isEmpty) {
              return const Center(
                child: Text(
                  'No notifications available.',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }
            if (notifications.isNotEmpty) {
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    elevation: 4,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: notification['priority'] == 'high'
                            ? Colors.red
                            : Colors.grey,
                        child: const Icon(
                          Icons.notifications_outlined,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        notification['heading'] ?? 'No Title',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(notification['subheading'] ?? 'No Subheading'),
                          const SizedBox(height: 4),
                          Text(notification['message'] ?? 'No Message'),
                        ],
                      ),
                      trailing: Text(
                        notification['type']?.toUpperCase() ?? '',
                        style: const TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.w500),
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
                child: Text(
                  'No notifications available.',
                  style: TextStyle(fontSize: 16),
                ),
              );
          }
        },
      ),
    );
  }
}
