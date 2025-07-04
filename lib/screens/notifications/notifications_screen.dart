import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإشعارات'), backgroundColor: Theme.of(context).primaryColor),
      body: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.notifications, size: 80, color: Colors.grey), SizedBox(height: 20),
        Text('الإشعارات', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 10), Text('قيد التطوير...', style: TextStyle(fontSize: 16, color: Colors.grey)),
      ])),
    );
  }
}
