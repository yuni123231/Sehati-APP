import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_mood_controller.dart';
import '../controllers/detail_stress_controller.dart';

class AddMoodView extends GetView<AddMoodController> {
  const AddMoodView({super.key});

  /// ================= ORANGE THEME =================
  static const Color primaryOrange = Color(0xFFF97316);
  static const Color secondaryOrange = Color(0xFFFBBF24);
  static const Color bgColor = Color(0xFFF8FAFC);
  static const Color darkText = Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    Get.put(AddMoodController());

    final detailStressController =
      Get.put(DetailStressController());

    final options = [
      {"label": "Tidak pernah", "value": 0},
      {"label": "Hampir tidak pernah", "value": 1},
      {"label": "Kadang-kadang", "value": 2},
      {"label": "Cukup sering", "value": 3},
      {"label": "Sangat sering", "value": 4},
    ];

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkText),
        title: const Text(
          "Manajemen Stres",
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// ================= HEADER =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    primaryOrange,
                    secondaryOrange,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: primaryOrange.withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: Colors.white24,
                    child: Icon(
                      Icons.psychology_alt_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Cek kondisi stres kamu 🧠",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Jawab sesuai perasaan kamu minggu ini ya",
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.white,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Pertanyaan Stres",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 16),

            /// ================= TIDAK DIUBAH (PERTANYAAN ASLI) =================
            _questionCard("Seberapa sering kamu merasa tidak bisa mengontrol hal penting dalam hidupmu?", controller.q1, options),
            _questionCard("Seberapa sering tugas atau masalah terasa menumpuk?", controller.q2, options),
            _questionCard("Seberapa sering kamu merasa stres karena aktivitas sehari-hari?", controller.q3, options),
            _questionCard("Seberapa sering kamu merasa yakin bisa menyelesaikan masalah?", controller.q4, options),
            _questionCard("Seberapa sering kamu merasa hidup berjalan sesuai harapan?", controller.q5, options),
            _questionCard("Seberapa sering kamu mudah kesal atau marah?", controller.q6, options),
            _questionCard("Seberapa sering kamu merasa mampu mengatasi masalah?", controller.q7, options),
            _questionCard("Seberapa sering kamu overthinking sampai sulit fokus?", controller.q8, options),
            _questionCard("Seberapa sering kamu merasa kewalahan dengan tugas?", controller.q9, options),
            _questionCard("Seberapa sering kamu merasa bisa mengendalikan situasi hidup?", controller.q10, options),

            const SizedBox(height: 26),

            /// ================= BUTTON =================
            SizedBox(
              width: double.infinity,
              height: 58,

              child: ElevatedButton(
                onPressed: controller.hitungSkor,

                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryOrange,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                child: const Text(
                  "Lihat Hasil",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// ================= RESULT =================
            Obx(() {
              if (controller.kategori.value.isEmpty) {
                return const SizedBox();
              }

              return Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryOrange.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.psychology_alt_rounded,
                            color: primaryOrange,
                          ),
                        ),
                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Hasil Stres Kamu",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: darkText,
                                ),
                              ),
                              Text(
                                controller.kategori.value,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: primaryOrange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    ...controller.rekomendasi.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 18,
                              color: primaryOrange,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                e,
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.4,
                                  color: darkText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    if (controller.kategori.value == "Sedang" ||
                        controller.kategori.value == "Tinggi") ...[
                      const Divider(),
                      const SizedBox(height: 10),

                      const Text(
                        "Rekomendasi Bantuan",
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),

                      const SizedBox(height: 10),

                      ...detailStressController
                      .rekomendasiPsikolog
                      .map(
                        (e) => psikologItem(
                          e.tempat,
                          e.dokter,
                        ),
                      ),
                    ]
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// ================= QUESTION CARD =================
  Widget _questionCard(
    String question,
    RxInt selected,
    List<Map<String, dynamic>> options,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
            question, // 👈 TIDAK DIUBAH
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: darkText,
            ),
          ),

          const SizedBox(height: 14),

          Obx(() => Column(
                children: options.map((opt) {
                  final isSelected = selected.value == opt["value"];

                  return GestureDetector(
                    onTap: () => selected.value = opt["value"],

                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: isSelected
                            ? primaryOrange.withValues(alpha: 0.10)
                            : const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isSelected
                              ? primaryOrange
                              : Colors.transparent,
                        ),
                      ),

                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color: isSelected
                                ? primaryOrange
                                : Colors.grey,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              opt["label"],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: isSelected
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: darkText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }

  Widget psikologItem(String rs, String nama) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Color(0xFFFFF3E0),
            child: Icon(Icons.psychology, color: primaryOrange),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(nama, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 4),
                Text(rs, style: TextStyle(color: Colors.grey.shade600)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}