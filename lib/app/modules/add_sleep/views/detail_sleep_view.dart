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
      case "Sangat Baik":
        return Colors.green;

      case "Cukup":
        return Colors.orange;

      case "Buruk":
        return Colors.redAccent;

      default:
        return Colors.grey;
    }
  }

  /// ================= INSIGHT =================

  String getInsight(String kategori) {
    switch (kategori) {
      case "Sangat Baik":
        return "Pola tidurmu sangat baik dan mendukung kesehatan fisik maupun mental 😴";

      case "Cukup":
        return "Pola tidurmu cukup baik, tetapi masih dapat ditingkatkan 🌙";

      default:
        return "Pola tidurmu masih kurang baik dan perlu diperbaiki 💤";
    }
  }

  /// ================= MAPPING =================

  String mapDurasi(int val) {
    switch (val) {
      case 1:
        return "7–9 jam";
      case 2:
        return "5–6 jam / >9 jam";
      case 3:
        return "< 5 jam";
      default:
        return "-";
    }
  }

  String mapGangguan(int val) {
    switch (val) {
      case 1:
        return "Tidak pernah";
      case 2:
        return "Sedikit";
      case 3:
        return "Ya, sering";
      default:
        return "-";
    }
  }

  String mapKualitas(int val) {
    switch (val) {
      case 1:
        return "Nyenyak";
      case 2:
        return "Cukup nyenyak";
      case 3:
        return "Tidak nyenyak";
      default:
        return "-";
    }
  }

  String mapTerbangun(int val) {
    switch (val) {
      case 1:
        return "Tidak pernah";
      case 2:
        return "1–2 kali";
      case 3:
        return "> 2 kali";
      default:
        return "-";
    }
  }

  String mapMengantuk(int val) {
    switch (val) {
      case 1:
        return "Tidak";
      case 2:
        return "Sedikit";
      case 3:
        return "Ya";
      default:
        return "-";
    }
  }

  String mapLatensi(int val) {
    switch (val) {
      case 1:
        return "< 15 menit";
      case 2:
        return "15–30 menit";
      case 3:
        return "> 30 menit";
      default:
        return "-";
    }
  }

  String mapJadwal(int val) {
    switch (val) {
      case 1:
        return "Sebelum 22.00";
      case 2:
        return "22.00 – 23.30";
      case 3:
        return "Lewat dari 23.30";
      default:
        return "-";
    }
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
          "Pola Tidur",
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
        final skor = controller.sleepRawScore.value;
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
                                "$skor / 21",
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
                              value: skor / 21,
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
                "Ringkasan Pola Tidur",
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
                "Kualitas Tidur",
                mapKualitas(controller.kualitas.value),
              ),

              _reportItem(
                "Terbangun Malam",
                mapTerbangun(controller.lamaTerbangun.value),
              ),

              _reportItem(
                "Mengantuk Siang",
                mapMengantuk(controller.mengantukSiang.value),
              ),

              _reportItem(
                "Latensi Tidur",
                mapLatensi(controller.latensiTidur.value),
              ),

              _reportItem(
                "Jadwal Tidur",
                mapJadwal(controller.jadwalTidur.value),
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
    if (kategori == "Sangat Baik") {
      return [
        "Pertahankan durasi tidur 7-9 jam",
        "Jaga konsistensi jam tidur",
        "Pertahankan kebiasaan tidur sehat",
      ];
    }

    if (kategori == "Cukup") {
      return [
        "Kurangi penggunaan gadget sebelum tidur",
        "Perbaiki jadwal tidur",
        "Kurangi gangguan saat tidur",
      ];
    }

    return [
      "Tidur minimal 7-9 jam",
      "Kurangi konsumsi kafein malam hari",
      "Hindari bermain HP sebelum tidur",
      "Tidur dan bangun pada jam yang sama",
      "Lakukan relaksasi sebelum tidur",
    ];
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