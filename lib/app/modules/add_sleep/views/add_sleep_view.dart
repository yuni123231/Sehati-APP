import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_sleep_controller.dart';

class AddSleepView extends GetView<AddSleepController> {
  const AddSleepView({super.key});

  // ================= THEME BIRU =================
  static const Color primaryBlue = Color(0xFF3B82F6);
  static const Color secondaryBlue = Color(0xFF60A5FA);
  static const Color bgColor = Color(0xFFF8FAFC);
  static const Color darkText = Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    Get.put(AddSleepController());

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkText),

        title: const Text(
          "Pola Tidur",
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

            /// ================= HEADER CARD =================
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    primaryBlue,
                    secondaryBlue,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: primaryBlue.withValues(alpha: 0.25),
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
                      Icons.hotel_rounded,
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
                          "Yuk cek pola tidur 😴",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Isi kebiasaan tidur kamu biar kesehatan tetap terjaga",
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
              "Kebiasaan Tidur",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 16),

            _questionCard(
              icon: Icons.nightlight_round,
              question: "Berapa lama kamu tidur per hari?",
              selected: controller.q1,
              options: const [
                {"label": "7–9 jam", "value": 3},
                {"label": "5–6 / >9 jam", "value": 2},
                {"label": "<5 jam", "value": 1},
              ],
            ),

            _questionCard(
              icon: Icons.alarm_off_rounded,
              question: "Seberapa sering terbangun malam?",
              selected: controller.q2,
              options: const [
                {"label": "Tidak pernah", "value": 3},
                {"label": "1–2 kali", "value": 2},
                {"label": ">2 kali", "value": 1},
              ],
            ),

            _questionCard(
              icon: Icons.timer_outlined,
              question: "Berapa lama sulit tidur kembali?",
              selected: controller.q3,
              options: const [
                {"label": "<15 menit", "value": 3},
                {"label": "15–30 menit", "value": 2},
                {"label": ">30 menit", "value": 1},
              ],
            ),

            _questionCard(
              icon: Icons.bedtime_rounded,
              question: "Kualitas tidur kamu?",
              selected: controller.q4,
              options: const [
                {"label": "Nyenyak", "value": 3},
                {"label": "Cukup", "value": 2},
                {"label": "Tidak nyenyak", "value": 1},
              ],
            ),

            _questionCard(
              icon: Icons.schedule_rounded,
              question: "Apakah jadwal tidur teratur?",
              selected: controller.q5,
              options: const [
                {"label": "Teratur", "value": 3},
                {"label": "Kadang", "value": 2},
                {"label": "Tidak", "value": 1},
              ],
            ),

            const SizedBox(height: 30),

            /// ================= BUTTON =================
            SizedBox(
              width: double.infinity,
              height: 58,

              child: ElevatedButton(
                onPressed: () async {
                  controller.hitungSkor();
                  await controller.saveSleepData();
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlue,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),

                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.analytics_rounded, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      "Lihat Hasil Tidur",
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

            /// ================= RESULT =================
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: primaryBlue.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.hotel_rounded,
                            color: primaryBlue,
                          ),
                        ),
                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Hasil Tidur Kamu",
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
                                  fontWeight: FontWeight.w600,
                                  color: primaryBlue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ...controller.rekomendasi.map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 18,
                              color: primaryBlue,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                e,
                                style: const TextStyle(
                                  fontSize: 13,
                                  height: 1.5,
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

  /// ================= QUESTION CARD =================
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
                  color: primaryBlue.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: primaryBlue),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  question,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: darkText,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Obx(
            () => Column(
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
                          ? primaryBlue.withValues(alpha: 0.10)
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: isSelected
                            ? primaryBlue
                            : Colors.transparent,
                      ),
                    ),

                    child: Row(
                      children: [
                        Icon(
                          isSelected
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: isSelected ? primaryBlue : Colors.grey,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            opt["label"],
                            style: TextStyle(
                              fontWeight: isSelected
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                              fontSize: 13,
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