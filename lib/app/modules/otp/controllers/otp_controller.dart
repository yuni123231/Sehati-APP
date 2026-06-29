import 'package:get/get.dart';

class OtpController extends GetxController {
  var otp = ''.obs;

  void verifikasi() {
    if (otp.value.length != 6) {
      Get.snackbar(
        "OTP Salah",
        "Masukkan kode OTP 6 digit",
      );
      return;
    }

    Get.toNamed(
      '/password-baru',
      arguments: {
        "email": Get.arguments,
        "otp": otp.value,
      },
    );
  }
}