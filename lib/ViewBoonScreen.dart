import 'package:flutter/material.dart';
import 'boon_model.dart'; 

class ViewBoonScreen extends StatelessWidget {
  final BoonModel boon;
  const ViewBoonScreen({super.key, required this.boon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Boon'),
        backgroundColor: Colors.grey[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Title: ${boon.title}', style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Description: ${boon.desc ?? 'No description'}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Event Date: ${boon.eventDate}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Start Hour: ${boon.startHour}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Start Minute: ${boon.startMinute}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text('Location: ${boon.location}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
