import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  /// 🔧 INIT NOTIFICATION
  static Future<void> init() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidInit,
    );

    await _plugin.initialize(initSettings);

    // Android 13+ permission
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    await _plugin
    .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
    ?.requestExactAlarmsPermission();
  }

  /// 🔔 DAILY REMINDER JAM TERTENTU
  static Future<void> scheduleDailyReminder(int hour, int minute) async {
    final scheduledTime = _nextInstance(hour, minute);

    print("NOTIF DIJADWALKAN: $scheduledTime");

    await _plugin.zonedSchedule(
      0,
      "Pengingat Gaya Hidup Sehat",
      "Jangan lupa mengisi parameter gaya hidup harianmu 💪",
      scheduledTime,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'daily_channel',
          'Pengingat Harian',
          channelDescription: 'Notifikasi pengingat harian pengguna',
          importance: Importance.max,
          priority: Priority.high,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // matchDateTimeComponents: DateTimeComponents.time,
    );

    print("ZONED SCHEDULE BERHASIL");

    final pending = await _plugin.pendingNotificationRequests();

    print("TOTAL PENDING : ${pending.length}");

    for (var item in pending) {
      print(item.id);
      print(item.title);
    }
  }

  /// 🕒 HITUNG WAKTU BERIKUTNYA
  static tz.TZDateTime _nextInstance(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduled =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    return scheduled;
  }

  /// ❌ CANCEL NOTIF
  static Future<void> cancelReminder() async {
    await _plugin.cancel(0);
  }

  static Future<void> showTestNotification() async {
  await _plugin.show(
    999,
    "TEST NOTIFIKASI",
    "Kalau ini muncul berarti plugin bekerja",
    const NotificationDetails(
      android: AndroidNotificationDetails(
        'test_channel',
        'Test Notification',
        channelDescription: 'Channel untuk testing',
        importance: Importance.max,
        priority: Priority.high,
      ),
    ),
  );
}
}