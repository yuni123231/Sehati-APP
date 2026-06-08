import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:teen_up/app/data/providers/api_services.dart';

class SignupController extends GetxController {
  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  final ApiServices apiServices = ApiServices();
  final box = GetStorage();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ================= SIGNUP MANUAL =================
  Future<void> signup() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "Semua kolom wajib diisi");
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar("Error", "Password dan konfirmasi tidak cocok");
      return;
    }

    isLoading.value = true;

    try {
      final response = await apiServices.signup(
        name: name,
        email: email,
        password: password,
      );

      isLoading.value = false;

      if (response['success'] == true) {
        final userId = response['user_id'];
        Get.snackbar("Sukses", "Registrasi berhasil");

        // Kirim userId ke halaman EnterDetails
        // Get.toNamed('/enter-details', arguments: {'userId': userId});
        box.write('userId', userId);
        Get.offAllNamed('/enter-details');
      } else {
        Get.snackbar("Gagal", response['message'] ?? "Registrasi gagal");
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "Gagal terhubung ke server");
    }
  }

  // ===== GOOGLE SIGNUP (DUMMY) =====
  void signupWithGoogle() {
    Get.snackbar(
      "Info",
      "Sign Up dengan Google belum tersedia",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
