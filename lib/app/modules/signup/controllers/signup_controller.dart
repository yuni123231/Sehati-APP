import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:teen_up/app/data/providers/api_services.dart';

class SignupController extends GetxController {

  final ApiServices apiServices = ApiServices();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // ================= SIGNUP =================

  Future<void> signup() async {

    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // VALIDASI KOSONG
    if (
      name.isEmpty ||
      email.isEmpty ||
      password.isEmpty ||
      confirmPassword.isEmpty
    ) {
      Get.snackbar(
        "Error",
        "Semua kolom wajib diisi",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // VALIDASI PASSWORD SAMA
    if (password != confirmPassword) {
      Get.snackbar(
        "Error",
        "Password dan konfirmasi password tidak sama",
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    // VALIDASI PASSWORD KUAT
    if (!isStrongPassword(password)) {
      Get.snackbar(
        "Password Lemah",
        "Password minimal 8 karakter, harus mengandung huruf besar, huruf kecil, angka dan simbol",
        snackPosition: SnackPosition.TOP,
      );
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

        final int userId =
            response['user_id'] ?? 0;

        Get.snackbar(
          "Registrasi Berhasil",
          "Silakan cek email untuk verifikasi akun",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );

        // Bersihkan form
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        // Masuk ke halaman isi data diri
        Get.toNamed(
          '/enter-details',
          arguments: userId,
        );

      } else {

        Get.snackbar(
          "Gagal",
          response['message'] ?? "Registrasi gagal",
          snackPosition: SnackPosition.TOP,
        );
      }

    } catch (e) {

      isLoading.value = false;

      Get.snackbar(
        "Error",
        "Terjadi kesalahan server",
        snackPosition: SnackPosition.TOP,
      );

      print("SIGNUP ERROR: $e");
    }
  }

  // ================= PASSWORD VALIDATION =================

  bool isStrongPassword(String password) {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$',
    ).hasMatch(password);
  }

  // ================= GOOGLE SIGNUP =================

  void signupWithGoogle() {

    Get.snackbar(
      "Info",
      "Google Signup belum tersedia",
      snackPosition: SnackPosition.TOP,
    );
  }

  // ================= DISPOSE =================

  @override
  void onClose() {

    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.onClose();
  }
}