import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_services.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SigninController extends GetxController {
  final ApiServices api = ApiServices();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isLoading = false.obs;
  final isPasswordHidden = true.obs;

  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();

    googleSignIn.initialize(
      serverClientId:
      "873854358065-8eag2t5upirkhq3sj7o74u0o1re08qdc.apps.googleusercontent.com",
    );
  }

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

      final userId = result['user_id'];

      box.write('userId', userId);
      box.write('nama', result['nama']);


      Get.snackbar(
        "Sukses",
        "Login berhasil",
        snackPosition: SnackPosition.TOP,
      );


      Get.offAllNamed('/home');

    } else {
      Get.snackbar("Gagal", result['message'] ?? "Login gagal");
    }
  }

  Future<void> signinWithGoogle() async {
    try {
      isLoading.value = true;

      final GoogleSignInAccount account =
          await googleSignIn.authenticate();

      final email = account.email;

      final result =
          await api.signinGoogle(email);

      isLoading.value = false;

      if (result['success'] == true) {
        box.write(
          'userId',
          result['user_id'],
        );

        box.write(
          'nama',
          result['nama'],
        );

        Get.snackbar(
          "Sukses",
          "Login berhasil",
        );

        Get.offAllNamed('/home');
      } else {
        Get.snackbar(
          "Akses Ditolak",
          "Email Google belum terdaftar",
        );
      }
    } catch (e) {
      isLoading.value = false;

      Get.snackbar(
        "Error",
        e.toString(),
      );
    }
  }

  @override
  void onClose() {
    // emailController.clear();
    // passwordController.clear();

    // emailController.dispose();
    // passwordController.dispose();

    super.onClose();
  }
}
