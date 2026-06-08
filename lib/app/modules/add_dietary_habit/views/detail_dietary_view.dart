import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class DetailDietaryView extends StatelessWidget {
  DetailDietaryView({super.key});

  final controller = Get.find<HomeController>();

  /// ================= COLOR =================

  Color getCategoryColor(String kategori) {
    switch (kategori) {
      case "Baik":
        return const Color(0xFF22C55E);

      case "Cukup":
        return const Color(0xFFF59E0B);

      default:
        return const Color(0xFFEF4444);
    }
  }

  /// ================= INSIGHT =================

  String getInsight(String kategori) {
    switch (kategori) {
      case "Baik":
        return "Pola makanmu sudah cukup baik dan seimbang hari ini.";

      case "Cukup":
        return "Kebiasaan makanmu sudah lumayan baik, tapi masih bisa diperbaiki.";

      default:
        return "Pola makanmu masih perlu diperhatikan agar tubuh tetap sehat.";
    }
  }

  /// ================= REKOMENDASI =================

  List<String> getRekomendasi() {
    List<String> tips = [];

    if (controller.frekuensiMakan.value < 3) {
      tips.add("Biasakan makan utama 3 kali sehari.");
    }

    if (controller.sarapan.value < 3) {
      tips.add("Usahakan sarapan untuk menjaga energi dan fokus.");
    }

    if (controller.sayurBuah.value < 3) {
      tips.add("Perbanyak konsumsi sayur dan buah setiap hari.");
    }

    if (controller.junkFood.value > 1) {
      tips.add("Kurangi makanan cepat saji dan tinggi lemak.");
    }

    if (controller.minumanManis.value > 1) {
      tips.add("Batasi minuman manis agar gula harian tetap terkontrol.");
    }

    if (controller.airPutih.value < 3) {
      tips.add("Perbanyak minum air putih minimal 8 gelas sehari.");
    }

    if (controller.makananLengkap.value < 3) {
      tips.add(
        "Usahakan setiap makan mengandung karbohidrat, protein, sayur, dan buah.",
      );
    }

    if (tips.isEmpty) {
      tips.add("Pertahankan pola makan sehatmu 👍");
    }

    return tips;
  }

  /// ================= MAPPING =================

  String mapFrekuensi(int val) {
    switch (val) {
      case 3:
        return "3x/hari teratur";
      case 2:
        return "2x/hari";
      default:
        return "≤1x/Tidak teratur";
    }
  }

  String mapSarapan(int val) {
    return val == 3 ? "Ya" : "Tidak";
  }

  String mapSayur(int val) {
    switch (val) {
      case 3:
        return "≥5 porsi/hari";
      case 2:
        return "2–4 porsi/hari";
      default:
        return "<2 porsi/hari";
    }
  }

  String mapJunk(int val) {
    switch (val) {
      case 3:
        return "Tidak";
      case 2:
        return "1 kali";
      default:
        return ">1 kali";
    }
  }

  String mapManis(int val) {
    switch (val) {
      case 3:
        return "Tidak";
      case 2:
        return "1 kali";
      default:
        return ">1 kali";
    }
  }
   String mapAir(int val) {
    switch (val) {
      case 3:
        return "≥ 8 gelas";
      case 2:
        return "5–7 gelas";
      default:
        return "< 5 gelas";
    }
  }
  
  String mapMakananLengkap(int val) {
    switch (val) {
      case 3:
        return "Lengkap";
      case 2:
        return "Cukup";
      default:
        return "Tidak Lengkap";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFF1E293B)),
        title: const Text(
          "Laporan Pola Makan",
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.dietaryKategori.value.isEmpty) {
          return const Center(
            child: Text("Belum ada data"),
          );
        }

        final kategori = controller.dietaryKategori.value;
        final skor = controller.dietaryRawScore.value;
        final color = getCategoryColor(kategori);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ================= HEADER REPORT =================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color,
                      color.withValues(alpha: 0.75),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        "Laporan Hari Ini",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    Text(
                      kategori,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      getInsight(kategori),
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [

                              const Text(
                                "Skor Kesehatan",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "$skor / 21",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),

                        Container(
                          width: 72,
                          height: 72,
                          decoration: BoxDecoration(
                            color:
                                Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${((skor / 21) * 100).toInt()}%",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: LinearProgressIndicator(
                        value: skor / 21,
                        minHeight: 10,
                        backgroundColor:
                            Colors.white.withValues(alpha: 0.2),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// ================= SECTION TITLE =================

              const Text(
                "Ringkasan Pola Makan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E293B),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                "Berikut hasil kebiasaan makanmu hari ini",
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 18),

              /// ================= REPORT CARD =================

              _reportItem(
                "Frekuensi Makan",
                mapFrekuensi(controller.frekuensiMakan.value),
              ),

              _reportItem(
                "Sarapan",
                mapSarapan(controller.sarapan.value),
              ),

              _reportItem(
                "Sayur & Buah",
                mapSayur(controller.sayurBuah.value),
              ),

              _reportItem(
                "Junk Food",
                mapJunk(controller.junkFood.value),
              ),

              _reportItem(
                "Minuman Manis",
                mapManis(controller.minumanManis.value),
              ),

              _reportItem(
                "Air Putih",
                mapAir(controller.airPutih.value),
              ),

              _reportItem(
                "Komposisi Makanan",
                mapMakananLengkap(
                  controller.makananLengkap.value,
                ),
              ),

              const SizedBox(height: 24),

              /// ================= REKOMENDASI =================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(26),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.tips_and_updates_rounded,
                          color: Color(0xFFF59E0B),
                        ),

                        SizedBox(width: 8),

                        Text(
                          "Rekomendasi",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    ...getRekomendasi().map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Container(
                              margin:
                                  const EdgeInsets.only(top: 6),
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                color: Color(0xFF4ADE80),
                                shape: BoxShape.circle,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.5,
                                  color:
                                      Colors.grey.shade700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  /// ================= REPORT ITEM =================

  Widget _reportItem(
    String title,
    String value,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.check_circle_rounded,
            color: Color(0xFF4ADE80),
          ),
        ],
      ),
    );
  }
}