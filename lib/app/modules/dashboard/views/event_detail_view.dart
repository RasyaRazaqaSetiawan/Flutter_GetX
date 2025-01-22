import 'package:belajarmobile/app/data/detail_event_response.dart';
import 'package:belajarmobile/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class EventDetailView extends GetView {
  final int eventId;
  const EventDetailView({super.key, required this.eventId});
  @override
  Widget build(BuildContext context) {
    DashboardController controller = Get.put(DashboardController());
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<DetailEventResponse>(
          future: controller.getDetailEvent(id: eventId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }
            if (snapshot.hasData && snapshot.data != null) {
              return Text(snapshot.data!.name ?? 'Event Detail');
            }
            return const Text('Event Not Found');
          },
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<DetailEventResponse>(
        future: controller.getDetailEvent(id: eventId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.network(
                'https://gist.githubusercontent.com/olipiskandar/4f08ac098c81c32ebc02c55f5b11127b/raw/6e21dc500323da795e8b61b5558748b5c7885157/loading.json',
                repeat: true,
                width: MediaQuery.of(context).size.width / 2,
              ),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text("Events details not found"),
            );
          }
          final event = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  'https://picsum.photos/id/${snapshot.data!.id!}/700/300',
                  fit: BoxFit.cover,
                  height: 200,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 200,
                      child: Center(
                        child: Text('Image not found'),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  event.name ?? "Event Name",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  event.description ?? "Event Description",
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        event.location ?? "Location not available",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 10,
                ),
                SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
    );
  }
}
