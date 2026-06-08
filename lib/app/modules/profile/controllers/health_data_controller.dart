import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/api_services.dart';
import '../../home/controllers/home_controller.dart';
import 'package:get_storage/get_storage.dart';

class HealthDataController extends GetxController {
  final ApiServices api = ApiServices();

  /// ================= GET STORAGE =================
  final box = GetStorage();
  late int userId;

  // Rx untuk dropdown
  final gender = ''.obs;
  final activity = ''.obs;
  final goal = ''.obs;

  // ================= ADDRESS =================
  final addressController = TextEditingController();

  // TextEditingController
  final ageController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    // userId = Get.arguments['userId'];
    /// ambil dari GetStorage
    userId = box.read('userId') ?? 0;

    print("USER ID: $userId");
    
    loadHealthData();
  }

  Future<void> loadHealthData() async {
    final data = await api.getUserProfile(userId);

    if (data != null) {
      ageController.text = data['umur']?.toString() ?? '';
      heightController.text = data['tinggi_badan']?.toString() ?? '';
      weightController.text = data['berat_badan']?.toString() ?? '';

      // ================= ADDRESS =================
      addressController.text = data['alamat'] ?? '';

      gender.value = data['jenis_kelamin'] ?? '';
      activity.value = data['aktivitas'] ?? '';
      goal.value = data['tujuan'] ?? '';
    }
  }

  Future<void> saveHealthData() async {
  if (isLoading.value) return;

  isLoading.value = true;

  try {
    final result = await api.saveUserProfile(
      userId: userId,
      umur: int.tryParse(ageController.text) ?? 0,
      tinggiBadan: double.tryParse(heightController.text) ?? 0,
      beratBadan: double.tryParse(weightController.text) ?? 0,
      jenisKelamin: gender.value,
      aktivitas: activity.value,
      tujuan: goal.value,
      alamat: addressController.text,
    );

    // ================= CEK RESPONSE =================
    if (result != null && result['success'] == true) {

      /// ================= SIMPAN ALAMAT =================
      box.write('alamat', addressController.text);
      print("ALAMAT TERSIMPAN: ${box.read('alamat')}");

      /// refresh home profile
      if (Get.isRegistered<HomeController>()) {
        await Get.find<HomeController>().fetchUserProfile();
      }

      /// tutup snackbar lama
      Get.closeAllSnackbars();

      Get.snackbar(
        "Berhasil",
        "Profile berhasil diperbarui",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 14,
        duration: const Duration(seconds: 2),
      );

      Get.back();

    } else {

      Get.closeAllSnackbars();

      Get.snackbar(
        "Error",
        result?['message'] ?? "Gagal menyimpan data",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }

  } catch (e) {

    print("ERROR SAVE HEALTH DATA: $e");

    Get.closeAllSnackbars();

    Get.snackbar(
      "Error",
      "Terjadi kesalahan pada server",
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );

  } finally {
    isLoading.value = false;
  }
}

  @override
  void onClose() {
    ageController.dispose();
    heightController.dispose();
    weightController.dispose();
    addressController.dispose();
    super.onClose();
  }
}