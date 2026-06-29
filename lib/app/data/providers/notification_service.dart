import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../modules/notifikasi/controllers/notifikasi_controller.dart';
import 'in_app_notification_service.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// =====================================================
  /// INIT NOTIFICATION
  /// =====================================================
  static Future<void> init() async {
    const AndroidInitializationSettings androidInit =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings =
        InitializationSettings(
      android: androidInit,
    );

    await _plugin.initialize(
      initSettings,

      /// SAAT NOTIF DIKLIK
      onDidReceiveNotificationResponse:
        (NotificationResponse response) async {
      print("NOTIFIKASI DIKLIK");

      /// simpan dulu
      InAppNotificationService.add(
        "Pengingat Harian",
        "Jangan lupa isi aktivitas hari ini 💪",
      );

      /// baru buka halaman
      if (response.payload == "reminder_harian") {
        await Get.toNamed('/notifikasi');

        /// setelah halaman kebuka, refresh controller
        if (Get.isRegistered<NotifikasiController>()) {
          Get.find<NotifikasiController>().loadNotifications();
        }
      }
    },
    );

    /// Android 13+ permission
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    /// Android exact alarm permission
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestExactAlarmsPermission();
  }

  /// =====================================================
  /// SCHEDULE DAILY REMINDER
  /// =====================================================
  static Future<void> scheduleDailyReminder(
    int hour,
    int minute,
  ) async {
    final scheduledTime = _nextInstance(hour, minute);

    print("NOTIF DIJADWALKAN: $scheduledTime");

    // /// simpan ke riwayat notifikasi
    // InAppNotificationService.add(
    //   "Pengingat Harian",
    //   "Jangan lupa isi aktivitas hari ini 💪",
    // );

    await _plugin.zonedSchedule(
      0,
      "Pengingat Gaya Hidup Sehat",
      "Jangan lupa mengisi parameter gaya hidup harianmu 💪",
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel',
          'Pengingat Harian',
          channelDescription:
              'Notifikasi pengingat harian pengguna',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),

      /// penting untuk alarm tepat waktu
      androidScheduleMode:
          AndroidScheduleMode.exactAllowWhileIdle,

      /// ulang setiap hari
      matchDateTimeComponents:
          DateTimeComponents.time,

      /// payload untuk buka halaman notifikasi
      payload: "reminder_harian",
    );

    print("ZONED SCHEDULE BERHASIL");

    final pending =
        await _plugin.pendingNotificationRequests();

    print("TOTAL PENDING : ${pending.length}");

    for (var item in pending) {
      print("ID: ${item.id}");
      print("TITLE: ${item.title}");
    }
  }

  /// =====================================================
  /// HITUNG WAKTU BERIKUTNYA
  /// =====================================================
  static tz.TZDateTime _nextInstance(
    int hour,
    int minute,
  ) {
    final now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    /// kalau waktu sudah lewat → jadwalkan besok
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(
        const Duration(days: 1),
      );
    }

    return scheduled;
  }

  /// =====================================================
  /// CANCEL REMINDER
  /// =====================================================
  static Future<void> cancelReminder() async {
    await _plugin.cancel(0);

    print("REMINDER DIBATALKAN");
  }

  /// =====================================================
  /// TEST NOTIFICATION
  /// =====================================================
  static Future<void> showTestNotification() async {
    /// simpan ke riwayat juga
    InAppNotificationService.add(
      "TEST NOTIFIKASI",
      "Kalau ini muncul berarti plugin bekerja",
    );

    await _plugin.show(
      999,
      "TEST NOTIFIKASI",
      "Kalau ini muncul berarti plugin bekerja",
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'test_channel',
          'Test Notification',
          channelDescription:
              'Channel untuk testing',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      payload: "reminder_harian",
    );
  }
}