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
                        "Pantau kesehatanmu setiap hari ✨",
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    width: 50,
                    height: 50,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),

                    child: const Icon(
                      Icons.settings_outlined,
                      color: darkText,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              /// =========================================================
              /// PROFILE CARD
              /// =========================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primary,
                      secondary,
                    ],
                  ),

                  borderRadius: BorderRadius.circular(30),

                  boxShadow: [
                    BoxShadow(
                      color: secondary.withOpacity(0.20),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Column(
                  children: [

                    /// =========================
                    /// USER PROFILE
                    /// =========================

                    Row(
                      children: [

                        /// FOTO PROFILE

                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [

                            Container(
                              width: 82,
                              height: 82,

                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.18),
                                shape: BoxShape.circle,

                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
                              ),

                              child: Obx(() {

                              /// Foto dari galeri (langsung tampil setelah upload)
                              if (controller.profileImage.value != null) {
                                return ClipOval(
                                  child: Image.file(
                                    controller.profileImage.value!,
                                    width: 82,
                                    height: 82,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }

                              /// Foto dari database saat login ulang
                              if (controller.profilePhotoUrl.value.isNotEmpty) {
                                return ClipOval(
                                  child: Image.network(
                                    '${controller.api.baseUrl}/uploads/profile/${controller.profilePhotoUrl.value}',
                                    width: 82,
                                    height: 82,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }

                              return const Icon(
                                Icons.person_rounded,
                                color: Colors.white,
                                size: 42,
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
                                  color: primary,
                                  size: 16,
                                ),
                              ),
                            ),
                          ]
                        ),

                        const SizedBox(width: 16),

                        /// USER INFO

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              Obx(
                                () => Text(
                                  controller.name.value,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 4),

                              Obx(
                                () => Text(
                                  controller.email.value,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,

                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white70,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),

                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.16),
                                  borderRadius: BorderRadius.circular(30),
                                ),

                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [

                                    Icon(
                                      Icons.local_fire_department_rounded,
                                      color: Colors.white,
                                      size: 15,
                                    ),

                                    SizedBox(width: 6),

                                    Flexible(
                                      child: Text(
                                        "Healthy lifestyle aktif",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 22),

                    /// =========================
                    /// STATUS CARD
                    /// =========================

                    Row(
                      children: [

                        Expanded(
                          child: _statusCard(
                            icon: Icons.favorite_rounded,
                            title: "Lifestyle",
                            value: "Aktif",
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: _statusCard(
                            icon: Icons.nightlight_round,
                            title: "Tidur",
                            value: "Teratur",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

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

              const SizedBox(height: 16),

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

              _menuItem(
                icon: Icons.favorite_outline_rounded,
                title: "Data Kesehatan",
                subtitle: "Lihat progress harian kamu",
                color: Colors.redAccent,
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

                      Switch(
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
                icon: Icons.lock_outline_rounded,
                title: "Privasi & Keamanan",
                subtitle: "Atur keamanan akun",
                color: Colors.blue,
                onTap: () {},
              ),

              const SizedBox(height: 30),

              /// =========================================================
              /// LOGOUT
              /// =========================================================

              SizedBox(
                width: double.infinity,
                height: 56,

                child: ElevatedButton.icon(
                  onPressed: controller.logout,

                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.redAccent.withOpacity(0.12),

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
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
                      fontWeight: FontWeight.w700,
                      color: Colors.redAccent,
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
                  width: 34,
                  height: 34,

                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 14,
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