import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_dietary_habit_controller.dart';

class AddDietaryHabitView extends GetView<AddDietaryHabitController> {
  const AddDietaryHabitView({super.key});

  /// ================= THEME RED =================
  static const Color primaryRed = Color(0xFFEF4444);
  static const Color secondaryRed = Color(0xFFF87171);
  static const Color bgColor = Color(0xFFF8FAFC);
  static const Color darkText = Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    Get.put(AddDietaryHabitController());

    return Scaffold(
      backgroundColor: bgColor,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: bgColor,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkText),
        title: const Text(
          "Pola Makan",
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
                    primaryRed,
                    secondaryRed,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),

                boxShadow: [
                  BoxShadow(
                    color: primaryRed.withValues(alpha: 0.25),
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
                      Icons.restaurant_rounded,
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
                          "Yuk cek pola makanmu 🍽️",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          "Isi kebiasaan makan harian biar kesehatanmu tetap terjaga",
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
              "Kebiasaan Makan",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: darkText,
              ),
            ),

            const SizedBox(height: 16),

            _questionCard("Berapa kali kamu makan hari ini?", controller.q1, [
              {"label": "3x sehari (teratur)", "value": 3},
              {"label": "2x sehari", "value": 2},
              {"label": "≤ 1x sehari (tidak teratur)", "value": 1},
            ]),

            _questionCard("Apakah kamu sarapan hari ini?", controller.q2, [
              {"label": "Ya, sarapan bergizi", "value": 3},
              {"label": "Hanya ngemil / minum teh/kopi", "value": 2},
              {"label": "Tidak sarapan sama sekali", "value": 1},
            ]),

            _questionCard("Apakah hari ini kamu makan buah dan sayur?", controller.q3, [
              {"label": "Banyak (Tiap kali makan ada)", "value": 3},
              {"label": "Sedikit (Hanya 1x makan ada)", "value": 2},
              {"label": "Tidak makan sama sekali", "value": 1},
            ]),

            _questionCard("Apakah hari ini kamu makan fast food/gorengan?", controller.q4, [
              {"label": "Tidak", "value": 3},
              {"label": "1 kali", "value": 2},
              {"label": ">1 kali", "value": 1},
            ]),

            _questionCard("Berapa kali kamu minum minuman manis hari ini (boba, soda, dll)?", controller.q5, [
              {"label": "Tidak", "value": 3},
              {"label": "1 kali", "value": 2},
              {"label": ">1 kali", "value": 1},
            ]),

            _questionCard("Berapa gelas air putih yang kamu minum hari ini?", controller.q6, [
              {"label": "≥ 8 gelas", "value": 3},
              {"label": "5–7 gelas", "value": 2},
              {"label": "< 5 gelas", "value": 1},
            ]),

            _questionCard("Apakah hari ini makananmu mengandung karbohidrat, protein, sayur, dan buah?", controller.q7, [
              {"label": "Lengkap", "value": 3},
              {"label": "Cukup", "value": 2},
              {"label": "Tidak Lengkap", "value": 1},
            ]),

            const SizedBox(height: 26),

            /// ================= BUTTON =================
            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton(
                onPressed: controller.hitungDanSimpan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryRed,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
                child: const Text(
                  "Simpan & Lihat Hasil",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 15,
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
                            color: primaryRed.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.restaurant_menu_rounded,
                            color: primaryRed,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const Text(
                                "Hasil Pola Makan",
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
                                  color: primaryRed,
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
                              color: primaryRed,
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
            question,
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
                            ? primaryRed.withValues(alpha: 0.10)
                            : const Color(0xFFF8FAFC),

                        borderRadius: BorderRadius.circular(16),

                        border: Border.all(
                          color: isSelected
                              ? primaryRed
                              : Colors.transparent,
                        ),
                      ),

                      child: Row(
                        children: [

                          Icon(
                            isSelected
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color:
                                isSelected ? primaryRed : Colors.grey,
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
}