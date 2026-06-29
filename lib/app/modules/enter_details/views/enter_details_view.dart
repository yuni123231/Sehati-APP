import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/enter_details_controller.dart';

class EnterDetailsView extends StatelessWidget {
  EnterDetailsView({super.key});

  final controller = Get.put(EnterDetailsController());

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
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        
              const Text(
                "Lengkapi Profilmu",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Isi data diri untuk memantau kesehatanmu ✨",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 24),

              /// HERO CARD
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [primary, secondary],
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: primary.withValues(alpha: 0.18),
                      blurRadius: 15,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.monitor_weight_rounded,
                      color: Colors.white,
                      size: 32,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Profil Kesehatan Awal",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Lengkapi data untuk mulai memantau kesehatanmu",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// INFORMASI DASAR
              _sectionCard(
                title: "Informasi Dasar",
                child: Column(
                  children: [
                    _inputField(
                      label: "Nama",
                      hint: "Masukkan nama",
                      onChanged: controller.setName,
                    ),
                    _inputField(
                      label: "Usia",
                      hint: "Masukkan usia",
                      keyboard: TextInputType.number,
                      onChanged: controller.setAge,
                    ),
                    _dropdownGender(),
                    _dropdownAddress(),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              /// DATA TUBUH
              _sectionCard(
                title: "Data Tubuh",
                child: Column(
                  children: [
                    _inputField(
                      label: "Tinggi Badan (cm)",
                      hint: "Masukkan tinggi badan",
                      keyboard: TextInputType.number,
                      onChanged: controller.setHeight,
                    ),
                    _inputField(
                      label: "Berat Badan (kg)",
                      hint: "Masukkan berat badan",
                      keyboard: TextInputType.number,
                      onChanged: controller.setWeight,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// BUTTON
              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () async {
                    final result =
                        await controller.saveUserProfile();

                    if (result != null) {
                      Get.offAllNamed('/home');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Simpan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
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

  Widget _sectionCard({
    required String title,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ],
    ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w800,
              color: darkText,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _inputField({
    required String label,
    required String hint,
    required Function(String) onChanged,
    TextInputType keyboard = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 8),
        TextField(
          keyboardType: keyboard,
          onChanged: onChanged,
          decoration: _inputStyle(hint),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _dropdownGender() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "Jenis Kelamin",
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: darkText,
        ),
      ),
      const SizedBox(height: 8),

      Obx(
        () => DropdownButtonFormField<String>(
          value: controller.gender.value.isEmpty
              ? null
              : controller.gender.value,
          items: const [
            DropdownMenuItem(
              value: "Male",
              child: Text("Laki-laki"),
            ),
            DropdownMenuItem(
              value: "Female",
              child: Text("Perempuan"),
            ),
          ],
          onChanged: (val) {
            if (val != null) {
              controller.setGender(val);
            }
          },
          decoration: _inputStyle("Pilih jenis kelamin"),
        ),
      ),

      const SizedBox(height: 16),
    ],
  );
}

  Widget _dropdownAddress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Domisili",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: darkText,
          ),
        ),
        const SizedBox(height: 8),

        Obx(
          () => DropdownButtonFormField<String>(
            value: controller.alamat.value.isEmpty
                ? null
                : controller.alamat.value,
            items: const [
              DropdownMenuItem(
                value: "Tegal",
                child: Text("Tegal"),
              ),
              DropdownMenuItem(
                value: "Slawi",
                child: Text("Slawi"),
              ),
              DropdownMenuItem(
                value: "Brebes",
                child: Text("Brebes"),
              ),
            ],
            onChanged: (val) {
              if (val != null) {
                controller.setAddress(val);
              }
            },
            decoration: _inputStyle("Pilih domisili"),
          ),
        ),
      ],
    );
  }

  InputDecoration _inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: bgColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
    );
  }
}