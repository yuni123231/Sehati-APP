import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class DetailActivityView extends StatelessWidget {
  DetailActivityView({super.key});

  final controller = Get.find<HomeController>();

  static const Color primary = Color(0xFF4ADE80);
  static const Color darkText = Color(0xFF1E293B);

  /// ================= COLOR =================

  Color getCategoryColor(String kategori) {
    switch (kategori) {
      case "Aktif Tinggi":
        return Colors.green;
      case "Cukup Aktif":
        return Colors.orange;
      default:
        return Colors.redAccent;
    }
  }

  /// ================= INSIGHT =================

  String getInsight(String kategori) {
    switch (kategori) {
      case "Aktif Tinggi":
        return "Aktivitas fisikmu sangat baik dan tubuhmu cukup aktif setiap hari 💪";
      case "Cukup Aktif":
        return "Aktivitasmu sudah lumayan baik, tapi masih bisa ditingkatkan 🚀";
      default:
        return "Aktivitas fisikmu masih kurang dan perlu lebih banyak gerak ❤️";
    }
  }

  /// ================= REKOMENDASI =================

  List<String> getRekomendasi(String kategori) {
    if (kategori == "Aktif Tinggi") {
      return [
        "Pertahankan pola olahraga secara konsisten",
        "Variasikan aktivitas agar tubuh tetap bugar",
        "Jangan lupa recovery dan tidur cukup",
      ];
    } else if (kategori == "Cukup Aktif") {
      return [
        "Tambah aktivitas ringan setiap hari",
        "Kurangi duduk terlalu lama",
        "Coba olahraga rutin minimal 30 menit",
      ];
    } else {
      return [
        "Mulai dari jalan kaki 20–30 menit/hari",
        "Kurangi rebahan terlalu lama",
        "Gunakan tangga atau aktivitas kecil sehari-hari",
        "Targetkan olahraga minimal 150 menit/minggu",
      ];
    }
  }

  /// ================= MAPPING =================

  String mapFrekuensi(int val) {
    return val == 3
        ? "≥ 3x/minggu"
        : val == 2
            ? "1–2x/minggu"
            : "Jarang";
  }

  String mapJenis(int val) {
    return val == 3
        ? "Berat"
        : val == 2
            ? "Sedang"
            : "Ringan";
  }

  String mapSedentary(int val) {
    return val == 3
        ? "< 6 jam"
        : val == 2
            ? "6–8 jam"
            : "> 8 jam";
  }

  String mapKonsistensi(int val) {
    return val == 3
        ? "Rutin"
        : val == 2
            ? "Kadang"
            : "Jarang";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: darkText),
        title: const Text(
          "Laporan Aktivitas",
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.aktivitasKategori.value.isEmpty) {
          return const Center(
            child: Text("Belum ada data aktivitas"),
          );
        }

        final kategori = controller.aktivitasKategori.value;
        final skor = controller.aktivitasSkor.value;
        final color = getCategoryColor(kategori);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ================= REPORT HEADER =================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color,
                      color.withValues(alpha: 0.75),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Laporan Hari Ini",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      kategori,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      getInsight(kategori),
                      style: const TextStyle(
                        color: Colors.white,
                        height: 1.5,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [

                              const Text(
                                "Skor",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 11,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "$skor",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: LinearProgressIndicator(
                              value: (skor / 3000).clamp(0.0, 1.0),
                              minHeight: 10,
                              backgroundColor:
                                  Colors.white.withValues(alpha: 0.25),
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// ================= SECTION TITLE =================

              const Text(
                "Ringkasan Aktivitas",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),

              const SizedBox(height: 16),

              /// ================= REPORT ITEM =================

              _reportItem(
                "Durasi Aktivitas",
                "${controller.menitPerHari.value} menit per hari",
              ),

              _reportItem(
                "Hari Aktivitas",
                "${controller.hariPerMinggu.value} hari per minggu",
              ),

              _reportItem(
                "Frekuensi Olahraga",
                mapFrekuensi(controller.frekuensi.value),
              ),

              _reportItem(
                "Intensitas Aktivitas",
                mapJenis(controller.jenis.value),
              ),

              _reportItem(
                "Waktu Duduk",
                mapSedentary(controller.sedentary.value),
              ),

              _reportItem(
                "Konsistensi",
                mapKonsistensi(controller.konsistensi.value),
              ),

              const SizedBox(height: 24),

              /// ================= REKOMENDASI =================

              Container(
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

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Row(
                      children: [

                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Icon(
                            Icons.tips_and_updates_rounded,
                            color: color,
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Text(
                          "Rekomendasi",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ...getRekomendasi(kategori).map(
                      (e) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Container(
                              margin: const EdgeInsets.only(top: 6),
                              width: 7,
                              height: 7,
                              decoration: BoxDecoration(
                                color: color,
                                shape: BoxShape.circle,
                              ),
                            ),

                            const SizedBox(width: 10),

                            Expanded(
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.6,
                                  color: Colors.grey.shade700,
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

  Widget _reportItem(String title, String value) {
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
            offset: const Offset(0, 6),
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
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.insights_rounded,
            color: primary,
            size: 22,
          ),
        ],
      ),
    );
  }
}