import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../data/providers/notification_service.dart';

class ProfileController extends GetxController {

  final ImagePicker picker = ImagePicker();
  final Rxn<File> profileImage = Rxn<File>();

  /// =====================================================
  /// SERVICE
  /// =====================================================

  final ApiServices api = ApiServices();
  final box = GetStorage();

  /// =====================================================
  /// USER DATA
  /// =====================================================

  final name = ''.obs;
  final email = ''.obs;
  final age = ''.obs;
  final gender = ''.obs;
  final height = ''.obs;
  final weight = ''.obs;
  final activity = ''.obs;
  final goal = ''.obs;

  /// =====================================================
  /// LOADING
  /// =====================================================

  final isLoading = false.obs;

  /// =====================================================
  /// REMINDER
  /// =====================================================

  final isReminderOn = false.obs;

  /// =====================================================
  /// USER ID
  /// =====================================================

  late int userId;
  final profilePhotoUrl = ''.obs;

  /// =====================================================
  /// INIT
  /// =====================================================

  @override
  void onInit() {
    super.onInit();

    userId = box.read('userId') ?? 0;

    /// Kalau belum login
    if (userId == 0) {
      Get.offAllNamed('/signin');
      return;
    }

    isReminderOn.value =
      box.read('dailyReminder_$userId') ?? false;

    if (isReminderOn.value) {
      NotificationService.scheduleDailyReminder(20,30);
    }

    fetchUserProfile();
  }

  /// =====================================================
  /// GET PROFILE
  /// =====================================================

  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;

      final profile = await api.getUserProfile(userId);
      print("PROFILE RESPONSE: $profile");

      if (profile != null) {

        name.value = profile['nama']?.toString() ?? '';
        email.value = profile['email']?.toString() ?? '';

        age.value =
            profile['umur']?.toString() ?? '';

        gender.value =
            profile['jenis_kelamin']?.toString() ?? '';

        height.value =
            profile['tinggi_badan']?.toString() ?? '';

        weight.value =
            profile['berat_badan']?.toString() ?? '';

        activity.value =
            profile['aktivitas']?.toString() ?? '';

        goal.value =
            profile['tujuan']?.toString() ?? '';

        profilePhotoUrl.value =
            profile['profile_photo']?.toString() ?? '';

        print("PHOTO URL: ${profilePhotoUrl.value}");
      }

    } catch (e) {

      Get.snackbar(
        "Error",
        "Gagal mengambil data profil",
        snackPosition: SnackPosition.BOTTOM,
      );

    } finally {

      isLoading.value = false;
    }
  }

  /// =====================================================
  /// TOGGLE REMINDER
  /// =====================================================

  void toggleReminder(bool value) {
    isReminderOn.value = value;

    box.write('dailyReminder_$userId', value);

    if (value) {
      NotificationService.scheduleDailyReminder(20,30);

      Get.snackbar(
        "Reminder ON",
        "Pengingat harian aktif",
        snackPosition: SnackPosition.TOP,
      );
    } else {
      NotificationService.cancelReminder();

      Get.snackbar(
        "Reminder OFF",
        "Notifikasi dimatikan",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  /// FOTO PROFIL 

  Future<void> pickImageFromGallery() async {
    try {

      final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (pickedFile != null) {

        final file = File(pickedFile.path);

        profileImage.value = file;

        final result = await api.uploadProfilePhoto(
          userId: userId,
          imageFile: file,
        );

        if (result != null &&
            result['success'] == true) {

          Get.snackbar(
            "Berhasil",
            "Foto profil berhasil diperbarui",
            snackPosition: SnackPosition.TOP,
          );

          fetchUserProfile();
        }
      }

    } catch (e) {

      Get.snackbar(
        "Error",
        "Gagal upload foto",
        snackPosition: SnackPosition.TOP,
      );
    }
  }

  /// =====================================================
  /// LOGOUT
  /// =====================================================

  Future<void> logout() async {

    await api.logout();

    /// Hapus local session
    box.remove('userId');
    box.remove('token');

    Get.offAllNamed('/signin');
  }
}