import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color darkText = Color(0xFF1E293B);
  static const Color bgColor = Color(0xFFF5F7FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// LOGO
              Center(
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [primary, secondary],
                    ),
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withValues(alpha: 0.18),
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

              const SizedBox(height: 25),

              /// TITLE
              const Center(
                child: Text(
                  "Buat Akun 🌱",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              Center(
                child: Text(
                  "Mulai perjalanan hidup sehatmu",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// NAMA
              TextField(
                controller: controller.nameController,
                decoration: _inputDecoration(
                  hint: "Nama lengkap",
                  icon: Icons.person_rounded,
                ),
              ),

              const SizedBox(height: 15),

              /// EMAIL
              TextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                decoration: _inputDecoration(
                  hint: "Email",
                  icon: Icons.email_rounded,
                ),
              ),

              const SizedBox(height: 15),

              /// PASSWORD
              Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  decoration: _inputDecoration(
                    hint: "Password",
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

              const SizedBox(height: 15),

              /// KONFIRMASI PASSWORD
              Obx(
                () => TextField(
                  controller: controller.confirmPasswordController,
                  obscureText:
                      controller.isConfirmPasswordHidden.value,
                  decoration: _inputDecoration(
                    hint: "Konfirmasi password",
                    icon: Icons.lock_reset_rounded,
                    suffix: IconButton(
                      onPressed: () {
                        controller.isConfirmPasswordHidden.toggle();
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

              const SizedBox(height: 15),

              /// BUTTON DAFTAR
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : controller.signup,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Obx(() {
                      if(controller.isLoading.value){
                      return const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      );
                    }
                    return const Text(
                    "Daftar",
                    style: TextStyle(
                      fontSize:16,
                      fontWeight:FontWeight.w700,
                      color:Colors.white
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 15),

              /// DIVIDER
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey.shade300),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      "atau",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey.shade300),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              /// GOOGLE BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton(
                  onPressed: controller.signupWithGoogle,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: Colors.grey.shade300,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/google.png',
                        height: 22,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "Lanjut dengan Google",
                        style: TextStyle(
                          color: darkText,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              /// LOGIN
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
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(
        color: Colors.grey.shade500,
      ),
      prefixIcon: Icon(
        icon,
        color: primary,
      ),
      suffixIcon: suffix,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: primary,
          width: 1.5,
        ),
      ),
    );
  }
}