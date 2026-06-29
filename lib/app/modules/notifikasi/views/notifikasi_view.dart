import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/notifikasi_controller.dart';

class NotifikasiView extends GetView<NotifikasiController> {
  const NotifikasiView({super.key});

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      /// ================= APP BAR =================
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          Obx(() {
            if (controller.isSelectionMode.value) {
              return IconButton(
                icon: const Icon(Icons.delete),
                onPressed: controller.deleteSelected,
              );
            }

            return IconButton(
              icon: const Icon(Icons.checklist),
              onPressed: () {
                controller.isSelectionMode.value = true;
              },
            );
          }),
        ],
      ),

      /// ================= BODY =================
      body: Obx(() {
        final notifications = controller.notifications;

        if (notifications.isEmpty) {
          return _emptyState();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: notifications.length,
          itemBuilder: (context, i) {
            final item = notifications[i];

            return Obx(() => _notificationCard(
              index: i,
              title: item['title'] ?? '',
              body: item['body'] ?? '',
              time: item['time'] ?? '',
            ));
          },
        );
      }),
    );
  }

  /// ================= EMPTY STATE =================
  Widget _emptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_outlined,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 12),
          Text(
            "Belum ada notifikasi",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Notifikasi dari aplikasi akan muncul di sini",
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  /// ================= CARD NOTIF =================
  Widget _notificationCard({
    required int index,
    required String title,
    required String body,
    required String time,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Row(
        children: [
          // CHECKBOX
          if (controller.isSelectionMode.value)
          Checkbox(
            value: controller.selectedIndexes.contains(index),
            onChanged: (_) {
              controller.toggleSelection(index);
            },
          ),
          /// ICON
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(
              Icons.notifications,
              color: Colors.green,
            ),
          ),

          const SizedBox(width: 12),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}