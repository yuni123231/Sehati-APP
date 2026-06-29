import 'package:get/get.dart';

import '../../../data/providers/api_services.dart';

class LupaPasswordController extends GetxController {
  final ApiServices api = ApiServices();

  var email = ''.obs;
  var isLoading = false.obs;

  Future<void> kirimOtp() async {
    try {
      isLoading.value = true;

      final result = await api.forgotPassword(email.value);

      isLoading.value = false;

      if (result['success'] == true) {
        Get.snackbar(
          "Berhasil",
          "Kode OTP sudah dikirim ke email",
        );

        Get.toNamed(
          '/otp',
          arguments: email.value,
        );
      } else {
        Get.snackbar(
          "Gagal",
          result['message'] ?? "Gagal mengirim OTP",
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