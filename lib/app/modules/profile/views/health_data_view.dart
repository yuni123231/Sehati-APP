import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/health_data_controller.dart';

class HealthDataView extends StatelessWidget {
  const HealthDataView({super.key});

  static const Color primary = Color(0xFF22C55E);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color darkText = Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HealthDataController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      /// ================= APPBAR =================
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        foregroundColor: darkText,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          "Data Kesehatan",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),
      ),

      /// ================= BODY =================
      body: Obx(() {

        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ================= HERO CARD =================
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF4ADE80),
                      Color(0xFF60A5FA),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: secondary.withValues(alpha: 0.18),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),

                    const SizedBox(height: 18),

                    const Text(
                      "Lengkapi\nProfil Kesehatanmu ✨",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                        height: 1.3,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Data ini membantu aplikasi memberikan rekomendasi kesehatan yang lebih akurat dan personal 🌱",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.92),
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              /// ================= INFORMASI PRIBADI =================
              _sectionTitle(
                "Informasi Pribadi",
                "Lengkapi data dasar kesehatan kamu",
              ),

              const SizedBox(height: 16),

              _card(
                child: Column(
                  children: [

                    _label("Usia"),

                    TextField(
                      controller: controller.ageController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration(
                        hint: "Masukkan usia kamu",
                        icon: Icons.cake_rounded,
                      ),
                    ),

                    const SizedBox(height: 18),

                    _label("Jenis Kelamin"),

                    _dropdown(
                      value: controller.gender.value,
                      items: const [
                        'Laki-laki',
                        'Perempuan',
                      ],
                      onChanged: (val) {
                        controller.gender.value = val!;
                      },
                    ),

                    const SizedBox(height: 18),

                    Row(
                      children: [

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              _label("Tinggi Badan"),

                              TextField(
                                controller:
                                    controller.heightController,
                                keyboardType:
                                    TextInputType.number,
                                decoration: _inputDecoration(
                                  hint: "cm",
                                  icon: Icons.height_rounded,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              _label("Berat Badan"),

                              TextField(
                                controller:
                                    controller.weightController,
                                keyboardType:
                                    TextInputType.number,
                                decoration: _inputDecoration(
                                  hint: "kg",
                                  icon: Icons.monitor_weight_rounded,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    _label("Alamat"),

                    TextField(
                      controller: controller.addressController,
                      maxLines: 2,
                      decoration: _inputDecoration(
                        hint: "Contoh: Slawi, Tegal",
                        icon: Icons.location_on_rounded,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// ================= GAYA HIDUP =================
              _sectionTitle(
                "Gaya Hidup",
                "Bantu kami memahami aktivitas harianmu",
              ),

              const SizedBox(height: 16),

              _card(
                child: Column(
                  children: [

                    _label("Tingkat Aktivitas"),

                    _dropdown(
                      value: controller.activity.value,
                      items: const [
                        'Rendah',
                        'Sedang',
                        'Aktif',
                        'Sangat Aktif',
                      ],
                      onChanged: (val) {
                        controller.activity.value = val!;
                      },
                    ),

                    const SizedBox(height: 18),

                    _label("Tujuan Kesehatan"),

                    _dropdown(
                      value: controller.goal.value,
                      items: const [
                        'Menurunkan Berat Badan',
                        'Menjaga Berat Badan',
                        'Menaikkan Berat Badan',
                      ],
                      onChanged: (val) {
                        controller.goal.value = val!;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// ================= INFO CARD =================
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(22),
                ),

                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.tips_and_updates_rounded,
                        color: primary,
                        size: 22,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        "Semakin lengkap data kesehatanmu, semakin akurat rekomendasi pola makan, aktivitas, dan kesehatan yang diberikan aplikasi 💚",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade700,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),

      /// ================= BUTTON =================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),

        child: SizedBox(
          height: 58,
          child: Obx(
            () => ElevatedButton(
              onPressed: controller.isLoading.value
                  ? null
                  : controller.saveHealthData,

              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),

              child: controller.isLoading.value

                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.2,
                      ),
                    )

                  : const Text(
                      "Simpan Data",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }

  /// =========================================================
  /// SECTION TITLE
  /// =========================================================

  Widget _sectionTitle(
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// =========================================================
  /// CARD
  /// =========================================================

  Widget _card({
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  /// =========================================================
  /// LABEL
  /// =========================================================

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: darkText,
          ),
        ),
      ),
    );
  }

  /// =========================================================
  /// INPUT
  /// =========================================================

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
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
        size: 20,
      ),

      filled: true,
      fillColor: const Color(0xFFF4F7FA),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
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

  /// =========================================================
  /// DROPDOWN
  /// =========================================================

  Widget _dropdown({
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F7FA),
        borderRadius: BorderRadius.circular(18),
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: items.contains(value) ? value : null,
          isExpanded: true,
          borderRadius: BorderRadius.circular(16),

          hint: const Text(
            "Pilih opsi",
          ),

          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),

          items: items.map((e) {
            return DropdownMenuItem(
              value: e,
              child: Text(
                e,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),

          onChanged: onChanged,
        ),
      ),
    );
  }
}