import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_activity_controller.dart';

class AddActivityView extends GetView<AddActivityController> {
  const AddActivityView({super.key});

  static const Color primaryGreen = Color(0xFF4ADE80);
  static const Color secondaryGreen = Color(0xFF22C55E);
  static const Color bgColor = Color(0xFFF8FAFC);
  static const Color darkText = Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    Get.put(AddActivityController());

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkText),

        title: const Text(
          "Aktivitas Fisik",
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

            /// ======================================================
            /// HEADER
            /// ======================================================

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    primaryGreen,
                    secondaryGreen,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                borderRadius: BorderRadius.circular(28),

                boxShadow: [
                  BoxShadow(
                    color: primaryGreen.withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),

              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [

                      CircleAvatar(
                        radius: 26,
                        backgroundColor: Colors.white24,

                        child: Icon(
                          Icons.directions_run_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),

                      SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            Text(
                              "Yuk cek aktivitasmu 💪",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(height: 4),

                            Text(
                              "Isi aktivitas fisik yang kamu lakukan hari ini",
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
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// ======================================================
            /// PETUNJUK
            /// ======================================================

            Container(
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

              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    padding: const EdgeInsets.all(10),

                    decoration: BoxDecoration(
                      color: primaryGreen.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(14),
                    ),

                    child: const Icon(
                      Icons.info_outline_rounded,
                      color: primaryGreen,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Text(
                      "Pilih jawaban yang paling sesuai dengan aktivitas fisik yang kamu lakukan hari ini.",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.6,
                        color: darkText,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              "Kuesioner Aktivitas",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 16),

            /// ======================================================
            /// DURASI
            /// ======================================================

            _questionCard(
              icon: Icons.timer_outlined,
              question:
                  "Berapa lama total kamu berolahraga atau aktif bergerak hari ini?",
              selected: controller.durasiAktivitas,
              options: const [
                {
                  "label": "≥ 60 menit",
                  "value": 3,
                },
                {
                  "label": "30 - 59 menit",
                  "value": 2,
                },
                {
                  "label": "< 30 menit",
                  "value": 1,
                },
              ],
            ),

            /// ======================================================
            /// INTENSITAS
            /// ======================================================

            _questionCard(
              icon: Icons.local_fire_department_rounded,
              question:
                  "Apa jenis aktivitas terberat yang kamu lakukan hari ini?",
              selected: controller.intensitasAktivitas,
              options: const [
                {
                  "label": "Berat (lari, futsal, gym, basket)",
                  "value": 3,
                },
                {
                  "label": "Sedang (jalan cepat, sepedaan santai)",
                  "value": 2,
                },
                {
                  "label": "Ringan (cuma jalan santai / banyak diam)",
                  "value": 1,
                },
              ],
            ),

            /// ======================================================
            /// SEDENTARY
            /// ======================================================

            _questionCard(
              icon: Icons.chair_alt_rounded,
              question:
                  "Di luar jam tidur, berapa lama kamu duduk, rebahan, atau bermain HP hari ini?",
              selected: controller.sedentary,
              options: const [
                {
                  "label": "< 4 jam",
                  "value": 3,
                },
                {
                  "label": "4 - 8 jam",
                  "value": 2,
                },
                {
                  "label": "> 8 jam",
                  "value": 1,
                },
              ],
            ),

            Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.auto_graph,
                    color: Colors.orange,
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Frekuensi aktivitas fisik mingguan dihitung otomatis berdasarkan riwayat pengisian aktivitas.",
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            /// ======================================================
            /// BUTTON
            /// ======================================================

            SizedBox(
              width: double.infinity,
              height: 58,

              child: ElevatedButton(
                onPressed: controller.hitungDanSimpan,

                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Icon(
                      Icons.analytics_rounded,
                      color: Colors.white,
                    ),

                    SizedBox(width: 10),

                    Text(
                      "Lihat Hasil Aktivitas",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            /// ======================================================
            /// RESULT
            /// ======================================================

            Obx(() {

              if (controller.kategori.value.isEmpty) {
                return const SizedBox();
              }

              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Row(
                      children: [

                        Container(
                          width: 54,
                          height: 54,

                          decoration: BoxDecoration(
                            color: primaryGreen.withValues(alpha: 0.12),
                            borderRadius:
                                BorderRadius.circular(18),
                          ),

                          child: const Icon(
                            Icons.favorite_rounded,
                            color: primaryGreen,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,

                            children: [

                              const Text(
                                "Hasil Aktivitas Kamu",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: darkText,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                controller.kategori.value,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: primaryGreen,
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
                        color: primaryGreen.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(18),
                      ),

                      child: Row(
                        children: [

                          const Icon(
                            Icons.stars_rounded,
                            color: primaryGreen,
                          ),

                          const SizedBox(width: 10),

                          Text(
                            "Skor Total : ${controller.skorTotal.value}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: darkText,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    ...controller.rekomendasi.map(
                      (e) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: 12),

                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,

                          children: [

                            const Padding(
                              padding:
                                  EdgeInsets.only(top: 3),

                              child: Icon(
                                Icons.check_circle_rounded,
                                size: 18,
                                color: primaryGreen,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                e,
                                style: const TextStyle(
                                  height: 1.5,
                                  fontSize: 13,
                                  color: darkText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  /// ======================================================
  /// QUESTION CARD
  /// ======================================================

  Widget _questionCard({
    required IconData icon,
    required String question,
    required RxInt selected,
    required List<Map<String, dynamic>> options,
  }) {
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

          Row(
            children: [

              Container(
                width: 42,
                height: 42,

                decoration: BoxDecoration(
                  color: primaryGreen.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),

                child: Icon(
                  icon,
                  color: primaryGreen,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Obx(
            () => Column(
              children: options.map((opt) {

                final isSelected =
                    selected.value == opt["value"];

                return GestureDetector(
                  onTap: () {
                    selected.value = opt["value"];
                  },

                  child: AnimatedContainer(
                    duration:
                        const Duration(milliseconds: 200),

                    margin:
                        const EdgeInsets.only(bottom: 12),

                    padding: const EdgeInsets.all(14),

                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryGreen.withValues(alpha: 0.10)
                          : const Color(0xFFF8FAFC),

                      borderRadius:
                          BorderRadius.circular(18),

                      border: Border.all(
                        color: isSelected
                            ? primaryGreen
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),

                    child: Row(
                      children: [

                        Icon(
                          isSelected
                              ? Icons.check_circle_rounded
                              : Icons.radio_button_unchecked,
                          color: isSelected
                              ? primaryGreen
                              : Colors.grey,
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            opt["label"],
                            style: TextStyle(
                              fontSize: 13,
                              height: 1.4,
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
            ),
          ),
        ],
      ),
    );
  }
}