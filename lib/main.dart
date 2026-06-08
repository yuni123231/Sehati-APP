import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teen_up/app/routes/app_pages.dart';
import 'package:teen_up/app/modules/home/controllers/home_controller.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'app/data/providers/notification_service.dart';

void main() async{
  // Get.put(HomeController(), permanent: true);
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));

  await GetStorage.init();

  /// 🔔 INISIALISASI NOTIFIKASI DI SINI
  await NotificationService.init();
  
  runApp(GetMaterialApp(
    title: "TeenUp",
    initialRoute: AppPages.INITIAL,
    getPages: AppPages.routes,
  ),);
}

