import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('البحث'), backgroundColor: Theme.of(context).primaryColor),
      body: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.search, size: 80, color: Colors.grey), SizedBox(height: 20),
        Text('البحث', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        SizedBox(height: 10), Text('قيد التطوير...', style: TextStyle(fontSize: 16, color: Colors.grey)),
      ])),
    );
  }
}
