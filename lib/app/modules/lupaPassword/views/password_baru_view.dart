import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/password_baru_controller.dart';

class PasswordBaruView extends GetView<PasswordBaruController> {
  PasswordBaruView({super.key});

  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color darkText = Color(0xFF1E293B);

  final passwordText = TextEditingController();
  final isObscure = true.obs;

  @override
  Widget build(BuildContext context) {
    final data = Get.arguments;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// ================= ICON =================
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [primary, secondary],
                            ),
                            borderRadius: BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: secondary.withValues(alpha: 0.20),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.lock_reset_rounded,
                            color: Colors.white,
                            size: 42,
                          ),
                        ),

                        const SizedBox(height: 28),

                        /// ================= TITLE =================
                        const Text(
                          "Buat Password Baru",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: darkText,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Masukkan password baru untuk akunmu agar bisa login kembali dengan aman.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 35),

                        /// ================= PASSWORD INPUT =================
                        Obx(
                          () => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: primary.withValues(alpha: 0.35),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: primary.withValues(alpha: 0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: passwordText,
                              obscureText: isObscure.value,
                              decoration: InputDecoration(
                                contentPadding:
                                    const EdgeInsets.symmetric(
                                  horizontal: 18,
                                  vertical: 18,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline_rounded,
                                  color: primary,
                                ),
                                hintText: "Masukkan password baru",
                                border: InputBorder.none,
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    isObscure.value
                                        ? Icons.visibility_off_rounded
                                        : Icons.visibility_rounded,
                                    color: Colors.grey,
                                  ),
                                  onPressed: () {
                                    isObscure.value =
                                        !isObscure.value;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// ================= BUTTON =================
                        Obx(
                          () => SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed:
                                  controller.isLoading.value
                                      ? null
                                      : () {
                                          controller.simpanPassword(
                                            data['email'],
                                            data['otp'],
                                            passwordText.text,
                                          );
                                        },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(18),
                                ),
                              ),
                              child: controller.isLoading.value
                                  ? const SizedBox(
                                      height: 22,
                                      width: 22,
                                      child:
                                          CircularProgressIndicator(
                                        strokeWidth: 2.5,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const Text(
                                      "Simpan Password",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight:
                                            FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}