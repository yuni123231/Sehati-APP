import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/otp_controller.dart';

class OtpView extends GetView<OtpController> {
  OtpView({super.key});

  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color darkText = Color(0xFF1E293B);

  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(6, (_) => FocusNode());

  @override
  Widget build(BuildContext context) {
    final email = Get.arguments;

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
                            Icons.lock_outline_rounded,
                            color: Colors.white,
                            size: 42,
                          ),
                        ),

                        const SizedBox(height: 28),

                        /// ================= TITLE =================
                        const Text(
                          "Masukkan Kode OTP",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                            color: darkText,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Kode verifikasi telah dikirim ke\n$email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey.shade600,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 35),

                        /// ================= OTP BOX =================
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            6,
                            (index) => SizedBox(
                              width: 48,
                              height: 60,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(
                                    color: primary.withValues(alpha: 0.45),
                                    width: 1.5,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          primary.withValues(alpha: 0.08),
                                      blurRadius: 10,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: TextField(
                                  controller: otpControllers[index],
                                  focusNode: focusNodes[index],
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  maxLength: 1,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: darkText,
                                  ),
                                  decoration: const InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                  ),
                                  onChanged: (value) {
                                    /// NEXT
                                    if (value.isNotEmpty && index < 5) {
                                      FocusScope.of(context).requestFocus(
                                        focusNodes[index + 1],
                                      );
                                    }

                                    /// BACK
                                    if (value.isEmpty && index > 0) {
                                      FocusScope.of(context).requestFocus(
                                        focusNodes[index - 1],
                                      );
                                    }

                                    /// COMBINE OTP
                                    String otp = otpControllers
                                        .map((e) => e.text)
                                        .join();

                                    controller.otp.value = otp;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        /// ================= BUTTON =================
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: controller.verifikasi,
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                            ),
                            child: const Text(
                              "Verifikasi",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// ================= RESEND =================
                        TextButton(
                          onPressed: () {
                            // logic resend OTP
                          },
                          child: const Text(
                            "Kirim ulang kode",
                            style: TextStyle(
                              color: secondary,
                              fontWeight: FontWeight.w700,
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