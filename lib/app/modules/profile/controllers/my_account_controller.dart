import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teen_up/app/modules/home/controllers/home_controller.dart';
import '../../../data/providers/api_services.dart';

class MyAccountController extends GetxController {
  final ApiServices api = ApiServices();

  late int userId;

  /// ================= TEXT CONTROLLERS =================
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isLoading = false.obs;

  /// ================= INIT =================
  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null && Get.arguments['userId'] != null) {
      userId = Get.arguments['userId'];
      fetchUserProfile();
    } else {
      Get.snackbar("Error", "User ID tidak ditemukan");
    }
  }

  /// ================= FETCH PROFILE =================
  Future<void> fetchUserProfile() async {
    try {
      isLoading.value = true;

      final profile = await api.getUserProfile(userId);

      if (profile != null) {
        nameController.text = profile['nama'] ?? '';
        emailController.text = profile['email'] ?? '';
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil data profile");
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= UPDATE PROFILE =================
  Future<void> updateProfile() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty) {
      Get.snackbar("Error", "Nama dan Email wajib diisi");
      return;
    }

    if (password.isNotEmpty && password != confirmPassword) {
      Get.snackbar("Error", "Password dan konfirmasi tidak sama");
      return;
    }

    try {
      isLoading.value = true;

      final success = await api.updateUserProfileBasic(
        userId: userId,
        name: name,
        email: email,
        password: password.isEmpty ? null : password,
      );

      if (success) {
        /// Refresh Home Profile kalau ada
        if (Get.isRegistered<HomeController>()) {
          await Get.find<HomeController>().fetchUserProfile();
          
        }

        /// Clear password field setelah update
        passwordController.clear();
        confirmPasswordController.clear();

        Get.snackbar("Success", "Profile berhasil diperbarui");
        Get.back();
      } else {
        Get.snackbar("Error", "Gagal memperbarui profile");
      }
    } catch (e) {
      Get.snackbar("Error", "Terjadi kesalahan");
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= DISPOSE =================
  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}