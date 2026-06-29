import 'package:get/get.dart';

import '../../../data/providers/api_services.dart';
import '../../signin/controllers/signin_controller.dart';

class PasswordBaruController extends GetxController {
  final ApiServices api = ApiServices();

  var isLoading = false.obs;

  Future<void> simpanPassword(
    String email,
    String otp,
    String password,
  ) async {
    try {
      isLoading.value = true;

      final result = await api.resetPassword(
        email,
        otp,
        password,
      );

      isLoading.value = false;

      if (result['success'] == true) {
        Get.snackbar(
          "Berhasil",
          "Password berhasil diganti",
        );

        // Hapus controller login lama
        if (Get.isRegistered<SigninController>()) {
          Get.delete<SigninController>();
        }

        // Pindah ke halaman login
        Get.offAllNamed('/signin');
      } else {
        Get.snackbar(
          "Gagal",
          result['message'] ?? "Reset password gagal",
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
}