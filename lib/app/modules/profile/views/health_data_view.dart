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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: darkText,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Data Kesehatan",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: darkText,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Kelola data kesehatanmu",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

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
                        Icons.person_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Informasi Pribadi",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              "Lengkapi data kesehatanmu",
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

                const SizedBox(height: 20),
                
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      
                      _label("Usia"),

                      TextField(
                        controller: controller.ageController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration(
                          hint: "Masukkan usia",
                          icon: Icons.cake_rounded,
                        ),
                      ),

                      const SizedBox(height: 16),

                      _label("Jenis Kelamin"),

                      Obx(
                        () => _dropdown(
                          value: ['Laki-laki', 'Perempuan']
                                  .contains(controller.gender.value)
                              ? controller.gender.value
                              : null,
                          items: const [
                            'Laki-laki',
                            'Perempuan',
                          ],
                          onChanged: (val) {
                            if (val != null) {
                              controller.gender.value = val;
                            }
                          },
                        ),
                      ),

                      const SizedBox(height: 16),

                      _label("Tinggi Badan"),

                      TextField(
                        controller: controller.heightController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration(
                          hint: "Contoh: 170 cm",
                          icon: Icons.height_rounded,
                        ),
                      ),

                      const SizedBox(height: 16),

                      _label("Berat Badan"),

                      TextField(
                        controller: controller.weightController,
                        keyboardType: TextInputType.number,
                        decoration: _inputDecoration(
                          hint: "Contoh: 60 kg",
                          icon: Icons.monitor_weight_rounded,
                        ),
                      ),

                      const SizedBox(height: 16),

                      _label("Alamat"),

                      TextField(
                        controller: controller.addressController,
                        maxLines: 2,
                        decoration: _inputDecoration(
                          hint: "Contoh: Slawi, Tegal",
                          icon: Icons.location_on_rounded,
                        ),
                      ),

                      const SizedBox(height: 24),

                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [

                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.favorite_rounded,
                                color: primary,
                                size: 20,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Text(
                                "Data kesehatan membantu aplikasi memberikan rekomendasi yang lebih akurat.",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade700,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        height: 58,
                        child: ElevatedButton.icon(
                          onPressed: controller.saveHealthData,
                          icon: const Icon(
                            Icons.save_rounded,
                            color: Colors.white,
                          ),
                          label: const Text(
                            "Simpan",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primary,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
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

  /// CARD
 Widget _card({
  required Widget child,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    child: child,
  );
}

  /// LABEL
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

  /// INPUT DECORATION
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
      fillColor: const Color(0xFFF8FAFC),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 18,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(
          color: primary,
          width: 1.5,
        ),
      ),
    );
  }

  /// DROPDOWN
  Widget _dropdown({
    required String? value,
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
          value: value,
          isExpanded: true,
          borderRadius: BorderRadius.circular(16),
          hint: const Text("Pilih opsi"),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          items: items.map((e) {
            return DropdownMenuItem<String>(
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