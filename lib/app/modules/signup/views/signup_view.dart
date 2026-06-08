import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color darkText = Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 18),

              /// ================= LOGO =================

              Center(
                child: Container(
                  width: 68,
                  height: 68,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        primary,
                        secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: secondary.withValues(alpha: 0.18),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: const Icon(
                    Icons.favorite_rounded,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// ================= TITLE =================

              const Center(
                child: Text(
                  "Daftar",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  "Mulai hidup sehatmu 🌱",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              /// ================= NAMA =================

              _label("Nama Lengkap"),

              TextField(
                controller: controller.nameController,
                decoration: _inputDecoration(
                  hint: "Masukkan nama lengkap",
                  icon: Icons.person_rounded,
                ),
              ),

              const SizedBox(height: 18),

              /// ================= EMAIL =================

              _label("Email"),

              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: _inputDecoration(
                  hint: "Masukkan email",
                  icon: Icons.email_rounded,
                ),
              ),

              const SizedBox(height: 18),

              /// ================= PASSWORD =================

              _label("Password"),

              Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,

                  decoration: _inputDecoration(
                    hint: "Masukkan password",
                    icon: Icons.lock_rounded,

                    suffix: IconButton(
                      onPressed: () {
                        controller.isPasswordHidden.toggle();
                      },
                      icon: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              /// ================= KONFIRMASI PASSWORD =================

              _label("Konfirmasi Password"),

              Obx(
                () => TextField(
                  controller:
                      controller.confirmPasswordController,

                  obscureText:
                      controller.isConfirmPasswordHidden.value,

                  decoration: _inputDecoration(
                    hint: "Ulangi password",
                    icon: Icons.lock_reset_rounded,

                    suffix: IconButton(
                      onPressed: () {
                        controller.isConfirmPasswordHidden
                            .toggle();
                      },
                      icon: Icon(
                        controller.isConfirmPasswordHidden.value
                            ? Icons.visibility_off_rounded
                            : Icons.visibility_rounded,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              /// ================= BUTTON =================

              SizedBox(
                width: double.infinity,
                height: 54,

                child: ElevatedButton(
                  onPressed: controller.signup,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  child: const Text(
                    "Daftar",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// ================= DIVIDER =================

              Row(
                children: [

                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),

                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12),

                    child: Text(
                      "atau",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  Expanded(
                    child: Divider(
                      color: Colors.grey.shade300,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// ================= GOOGLE =================

              SizedBox(
                width: double.infinity,
                height: 54,

                child: OutlinedButton(
                  onPressed: controller.signupWithGoogle,

                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,

                    side: BorderSide(
                      color: Colors.grey.shade300,
                    ),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Image.asset(
                        'assets/images/google.png',
                        height: 22,
                      ),

                      const SizedBox(width: 12),

                      const Text(
                        "Daftar dengan Google",
                        style: TextStyle(
                          color: darkText,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// ================= LOGIN =================

              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                      "Sudah punya akun?",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/signin');
                      },

                      child: const Padding(
                        padding: EdgeInsets.only(left: 6),
                        child: Text(
                          "Masuk",
                          style: TextStyle(
                            color: primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  /// ================= LABEL =================

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),

      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: darkText,
        ),
      ),
    );
  }

  /// ================= INPUT =================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,

      hintStyle: TextStyle(
        color: Colors.grey.shade500,
        fontSize: 13,
      ),

      prefixIcon: Icon(
        icon,
        color: primary,
      ),

      suffixIcon: suffix,

      filled: true,
      fillColor: Colors.white,

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: primary,
          width: 1.5,
        ),
      ),
    );
  }
}