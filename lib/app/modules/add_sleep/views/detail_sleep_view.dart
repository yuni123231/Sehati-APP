import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class DetailSleepView extends StatelessWidget {
  DetailSleepView({super.key});

  final controller = Get.find<HomeController>();

  static const Color primary = Color(0xFF6366F1);
  static const Color darkText = Color(0xFF1E293B);

  /// ================= COLOR =================

  Color getCategoryColor(String kategori) {
    switch (kategori) {
      case "Baik":
        return Colors.green;
      case "Cukup":
        return Colors.orange;
      default:
        return Colors.redAccent;
    }
  }

  /// ================= INSIGHT =================

  String getInsight(String kategori) {
    switch (kategori) {
      case "Baik":
        return "Kualitas tidurmu sudah baik dan membantu tubuh tetap fit 😴";
      case "Cukup":
        return "Tidurmu cukup baik, tapi masih bisa lebih optimal 🌙";
      default:
        return "Pola tidurmu masih kurang dan perlu diperbaiki 💤";
    }
  }

  /// ================= MAPPING =================

  String mapDurasi(int val) {
    return val == 3
        ? "7–9 jam"
        : val == 2
            ? "5–6 / >9 jam"
            : "<5 jam";
  }

  String mapGangguan(int val) {
    return val == 3
        ? "Tidak ada"
        : val == 2
            ? "1–2 kali"
            : ">2 kali";
  }

  String mapTerbangun(int val) {
    return val == 3
        ? "<15 menit"
        : val == 2
            ? "15–30 menit"
            : ">30 menit";
  }

  String mapKualitas(int val) {
    return val == 3
        ? "Nyenyak"
        : val == 2
            ? "Cukup"
            : "Tidak nyenyak";
  }

  String mapKeteraturan(int val) {
    return val == 3
        ? "Teratur"
        : val == 2
            ? "Kadang"
            : "Tidak teratur";
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
          "Laporan Tidur",
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.sleepKategori.value.isEmpty) {
          return const Center(
            child: Text("Belum ada data tidur"),
          );
        }

        final kategori = controller.sleepKategori.value;
        final skor = controller.sleepSkor.value;
        final color = getCategoryColor(kategori);

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// ================= HEADER =================

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
                        fontSize: 13,
                        height: 1.5,
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
                                "$skor / 15",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
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
                              value: skor / 15,
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

              /// ================= TITLE =================

              const Text(
                "Ringkasan Tidur",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),

              const SizedBox(height: 16),

              /// ================= REPORT ITEM =================

              _reportItem(
                "Durasi Tidur",
                mapDurasi(controller.durasiTidur.value),
              ),

              _reportItem(
                "Gangguan Tidur",
                mapGangguan(controller.gangguan.value),
              ),

              _reportItem(
                "Lama Terbangun",
                mapTerbangun(controller.lamaTerbangun.value),
              ),

              _reportItem(
                "Kualitas Tidur",
                mapKualitas(controller.kualitas.value),
              ),

              _reportItem(
                "Keteraturan Tidur",
                mapKeteraturan(controller.keteraturan.value),
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
                            Icons.bedtime_rounded,
                            color: color,
                          ),
                        ),

                        const SizedBox(width: 12),

                        const Text(
                          "Rekomendasi Tidur",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ..._getTips(kategori).map(
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

  /// ================= TIPS =================

  List<String> _getTips(String kategori) {
    if (kategori == "Baik") {
      return [
        "Pertahankan durasi tidur 7–9 jam setiap hari",
        "Jaga konsistensi jam tidur dan bangun",
        "Hindari begadang terlalu sering",
      ];
    } else if (kategori == "Cukup") {
      return [
        "Kurangi penggunaan gadget sebelum tidur",
        "Perbaiki jadwal tidur agar lebih konsisten",
        "Ciptakan suasana kamar yang nyaman",
      ];
    } else {
      return [
        "Tidur minimal 7–9 jam per hari",
        "Kurangi konsumsi kafein di malam hari",
        "Hindari bermain HP sebelum tidur",
        "Tidur dan bangun di jam yang sama setiap hari",
      ];
    }
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
            Icons.nightlight_round,
            color: primary,
            size: 22,
          ),
        ],
      ),
    );
  }
}