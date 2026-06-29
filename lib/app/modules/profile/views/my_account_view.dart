import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/my_account_controller.dart';

class MyAccountView extends StatelessWidget {
  MyAccountView({super.key});

  final MyAccountController controller =
      Get.put(MyAccountController());

  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color darkText = Color(0xFF1E293B);
  static const Color bgColor = Color(0xFFF5F7FB);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      resizeToAvoidBottomInset: true,

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: primary,
            ),
          );
        }

        return SafeArea(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.fromLTRB(20, 20, 20, 30),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                /// ======================================
                /// HEADER
                /// ======================================

                Row(
                  children: [

                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black
                                  .withValues(alpha: 0.05),
                              blurRadius: 15,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: darkText,
                          size: 20,
                      ),
                    ),
                  ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Akun Saya",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight:
                                  FontWeight.w800,
                              color: darkText,
                            ),
                          ),

                          SizedBox(height: 2),

                          Text(
                            "Kelola informasi akunmu ✨",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                /// ======================================
                /// HERO CARD (VERSI SIMPLE)
                /// ======================================

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        primary,
                        secondary,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primary.withOpacity(0.15),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Row(
                    children: [

                      Icon(
                        Icons.manage_accounts_rounded,
                        color: Colors.white,
                        size: 28,
                      ),

                      SizedBox(width: 10),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Pengaturan Akun",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(height: 2),

                            Text(
                              "Edit nama, email dan password",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                /// ======================================
                /// FORM CARD
                /// ======================================

                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(
                            25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black
                            .withValues(
                                alpha: 0.04),
                        blurRadius: 20,
                        offset:
                            const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Informasi Akun",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight:
                              FontWeight.w800,
                          color: darkText,
                        ),
                      ),

                      const SizedBox(
                          height: 5),

                      Text(
                        "Pastikan data yang kamu masukkan benar.",
                        style: TextStyle(
                          fontSize: 13,
                          color:
                              Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(
                          height: 20),

                      _inputField(
                        controller:
                            controller
                                .nameController,
                        hint: "Nama",
                        icon: Icons
                            .person_outline_rounded,
                      ),

                      const SizedBox(
                          height: 15),

                      _inputField(
                        controller:
                            controller
                                .emailController,
                        hint: "Email",
                        icon: Icons
                            .email_outlined,
                      ),

                      const SizedBox(
                          height: 15),

                      _inputPassword(
                        controller:
                            controller
                                .passwordController,
                        hint:
                            "Password Baru",
                      ),

                      const SizedBox(
                          height: 15),

                      _inputPassword(
                        controller: controller
                            .confirmPasswordController,
                        hint:
                            "Konfirmasi Password",
                      ),

                      const SizedBox(
                          height: 28),

                      SizedBox(
                        width:
                            double.infinity,
                        height: 58,
                        child:
                            ElevatedButton.icon(
                          onPressed:
                              controller
                                  .updateProfile,

                          icon: const Icon(
                            Icons
                                .save_rounded,
                            color: Colors.white,
                          ),

                          label:
                              const Text(
                            "Simpan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                                  FontWeight
                                      .w700,
                              color:
                                  Colors.white,
                            ),
                          ),

                          style:
                              ElevatedButton
                                  .styleFrom(
                            elevation: 0,
                            backgroundColor:
                                primary,
                            shape:
                                RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          18),
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
        );
      }),
    );
  }

  /// ======================================
  /// INPUT TEXT
  /// ======================================

  Widget _inputField({
    required TextEditingController
        controller,
    required String hint,
    required IconData icon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
          prefixIcon: Icon(
            icon,
            color: primary,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 10,
          ),
        ),
      ),
    );
  }

  /// ======================================
  /// PASSWORD
  /// ======================================

  Widget _inputPassword({
    required TextEditingController
        controller,
    required String hint,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius:
            BorderRadius.circular(18),
      ),
      child: TextField(
        controller: controller,
        obscureText: true,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
          ),
          prefixIcon: const Icon(
            Icons.lock_outline_rounded,
            color: primary,
          ),
          suffixIcon: const Icon(
            Icons.visibility_off_outlined,
            color: Colors.grey,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 10,
          ),
        ),
      ),
    );
  }
}