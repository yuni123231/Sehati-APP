import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color darkText = Color(0xFF1E293B);
  static const Color bgColor = Color(0xFFF5F7FB);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: bgColor,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// =========================================================
              /// HEADER
              /// =========================================================

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        "Profil",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: darkText,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        "Kelola akun dan pantau kesehatanmu ✨",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 20),

              /// =========================================================
              /// PROFILE CARD
              /// =========================================================

              Container(
                // width: double.infinity,
                padding: const EdgeInsets.all(18),

                decoration: BoxDecoration(
                 gradient: const LinearGradient(
                  begin: Alignment.topLeft, 
                  end: Alignment.bottomRight,
                    colors: [
                      primary,
                      secondary,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color: secondary.withOpacity(0.25),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Row(
                  children: [

                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [

                        Container(
                          width: 75,
                          height: 75,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 3,
                            ),
                          ),

                          child: Obx(() {

                            if (controller.profileImage.value != null) 
                            { 
                              return ClipOval( 
                                child: Image.file( 
                                  controller.profileImage.value!, 
                                  width: 82, 
                                  height: 82, 
                                  fit: BoxFit.cover, 
                                ), 
                              ); 
                            }

                            if (controller.profileImage.value != null) {
                              return ClipOval(
                                child: Image.file(
                                  controller.profileImage.value!,
                                  fit: BoxFit.cover,
                                ),
                              );
                            }

                            if (controller.profilePhotoUrl.value.isNotEmpty) {
                              return ClipOval(
                                child: Image.network(
                                  '${controller.api.baseUrl}/uploads/profile/${controller.profilePhotoUrl.value}',
                                  fit: BoxFit.cover,
                                ),
                              );
                            }

                            return const Icon(
                              Icons.person_rounded,
                              size: 42,
                              color: Colors.white70,
                            );
                          }),
                        ),

                        GestureDetector(
                          onTap: controller.pickImageFromGallery,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,

                              boxShadow: [ 
                                BoxShadow( 
                                  color: Colors.black.withOpacity(0.08), 
                                  blurRadius: 10, 
                                ), 
                              ],
                            ),
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              size: 16,
                              color: primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Obx(
                            () => Text(
                              controller.name.value,
                              // overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(height: 5),

                          Obx(
                            () => Text(
                              controller.email.value,
                              // maxLines: 1,
                              // overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white.withOpacity(0.85),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// =========================================================
              /// MENU
              /// =========================================================

              const Text(
                "Pengaturan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),

              const SizedBox(height: 14),

              _menuItem(
                icon: Icons.person_outline_rounded,
                title: "Akun Saya",
                subtitle: "Kelola profil dan akun",
                color: Colors.green,
                onTap: () {
                  Get.toNamed(
                    '/my-account',
                    arguments: {
                      'userId': controller.userId,
                    },
                  );
                },
              ),

              /// =========================================================
              /// REMINDER SWITCH
              /// =========================================================

              Obx(
                () => Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(16),

                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),

                  child: Row(
                    children: [

                      Container(
                        width: 54,
                        height: 54,

                        decoration: BoxDecoration(
                          color: Colors.orange.withOpacity(0.12),
                          borderRadius: BorderRadius.circular(18),
                        ),

                        child: const Icon(
                          Icons.notifications_active_rounded,
                          color: Colors.orange,
                          size: 26,
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Pengingat Harian",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: darkText,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              controller.isReminderOn.value
                                  ? "Notifikasi aktif setiap hari"
                                  : "Aktifkan reminder harian",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Switch.adaptive(
                        value: controller.isReminderOn.value,
                        activeColor: primary,
                        onChanged: (value) {
                          controller.toggleReminder(value);
                        },
                      ),
                    ],
                  ),
                ),
              ),

              _menuItem(
                icon: Icons.favorite_outline_rounded,
                title: "Data Kesehatan",
                subtitle: "Lihat progress harian kamu",
                color: Colors.blueAccent,
                onTap: () {
                  Get.toNamed(
                    '/health-data',
                    arguments: {
                      'userId': controller.userId,
                    },
                  );
                },
              ),


              /// =========================================================
              /// LOGOUT
              /// =========================================================

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Get.dialog(
                      Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(28),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 25,
                                offset: const Offset(0, 12),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize:
                                MainAxisSize.min,
                            children: [
                              /// ICON LOGOUT
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  gradient:
                                      const LinearGradient(
                                    colors: [
                                      Color(0xFF4ADE80),
                                      Color(0xFF60A5FA),
                                    ],
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.logout_rounded,
                                  size: 34,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 18),
                              const Text(
                                "Keluar dari Aplikasi?",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                      FontWeight.w800,
                                  color:
                                      Color(0xFF1E293B),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Apakah kamu yakin ingin keluar?\nSesi akun kamu akan berakhir.",
                                textAlign:
                                    TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.5,
                                  color:
                                      Colors.grey.shade600,
                                ),
                              ),
                              const SizedBox(height: 24),
                              /// BUTTON BATAL
                              SizedBox(
                                width:
                                    double.infinity,
                                height:
                                    48,
                                child:
                                    OutlinedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  style:
                                      OutlinedButton.styleFrom(
                                    side:
                                        BorderSide(
                                      color: Colors.grey.shade300,
                                    ),
                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(14),
                                    ),
                                  ),
                                  child:
                                    const Text(
                                    "Batal",
                                    style:
                                      TextStyle(
                                        color: Color(0xFF64748B),
                                        fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),
                              /// BUTTON KELUAR
                              SizedBox(
                                width: double.infinity,
                                height: 48,
                                child:
                                    ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                    controller.logout();
                                  },
                                  style:
                                      ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: const Color(0xFF4ADE80),
                                    shape:
                                        RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(14),
                                    ),
                                  ),
                                  child:
                                    const Text(
                                    "Ya, Keluar",
                                    style:
                                      TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      barrierDismissible: false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.red.shade50,
                    elevation: 0,
                    shape:
                        RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(14),
                    ),
                  ),
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.redAccent,
                  ),
                  label: const Text(
                    "Keluar",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight:
                          FontWeight.w700,
                      color:
                          Colors.redAccent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// =========================================================
  /// MENU ITEM
  /// =========================================================

  Widget _menuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),

      child: Material(
        color: Colors.transparent,

        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,

          child: Container(
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),

              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.04),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),

            child: Row(
              children: [

                Container(
                  width: 54,
                  height: 54,

                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(18),
                  ),

                  child: Icon(
                    icon,
                    color: color,
                    size: 26,
                  ),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,

                    children: [

                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: darkText,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  width: 28,
                  height: 28,

                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// =========================================================
  /// STATUS CARD
  /// =========================================================

  Widget _statusCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        children: [

          Container(
            width: 40,
            height: 40,

            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.20),
              borderRadius: BorderRadius.circular(14),
            ),

            child: Icon(
              icon,
              color: Colors.white,
              size: 20,
            ),
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,

              children: [

                Text(
                  title,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  value,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}