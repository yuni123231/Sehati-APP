import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_services.dart';

class SigninController extends GetxController {
  final ApiServices api = ApiServices();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;
  
  final box = GetStorage();

  Future<void> signin() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Email dan password wajib diisi");
      return;
    }

    isLoading.value = true;

    final result = await api.signin(
      email: email,
      password: password,
    );

    isLoading.value = false;

    if (result['success'] == true) {
      // simpan userId jika perlu
      final userId = result['user_id'];

      Get.snackbar("Sukses", "Login berhasil");

      // langsung ke HOME
      // Get.offAllNamed('/home', arguments: {
      //   'userId': userId,
      // });
      box.write('userId', userId);
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Gagal", result['message'] ?? "Login gagal");
    }
  }

  void signinWithGoogle() {
    Get.snackbar(
      "Info",
      "Login Google belum tersedia",
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
