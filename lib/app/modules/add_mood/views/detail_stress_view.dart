import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/detail_stress_controller.dart';

class DetailStressView extends StatelessWidget {
  DetailStressView({super.key});

  // final controller = Get.find<HomeController>();
  // final controller = Get.put(DetailStressController());
  final controller = Get.find<DetailStressController>();
  
  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color darkText = Color(0xFF1E293B);

  /// ================= COLOR =================
  Color getCategoryColor(String kategori) {
    switch (kategori) {
      case "Rendah":
        return Colors.green;

      case "Sedang":
        return Colors.orange;

      default:
        return Colors.red;
    }
  }

  /// ================= INSIGHT =================
  
  String getInsight(String kategori) {
    switch (kategori) {
      case "Rendah":
        return "Kondisi emosimu cukup baik dan stabil 😌";

      case "Sedang":
        return "Kamu mulai mengalami tekanan mental dari aktivitas sehari-hari ⚠️";

      default:
        return "Tingkat stresmu cukup tinggi dan perlu perhatian lebih ❤️";
    }
  }

  /// ================= STATUS =================
  
  String getStatus(String kategori) {
    switch (kategori) {
      case "Rendah":
        return "Kondisi Stabil";

      case "Sedang":
        return "Perlu Relaksasi";

      default:
        return "Butuh Dukungan";
    }
  }

  /// ================= DASS SCALE =================
  String mapSkala(int val) {
    switch (val) {
      case 0:
        return "Tidak pernah";
      case 1:
        return "Hampir tidak pernah";
      case 2:
        return "Kadang-kadang";
      case 3:
        return "Cukup sering";
      case 4:
        return "Sangat sering";
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
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Manajemen Stress",
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: Obx(() {
        if (controller.kategori.value.isEmpty) {
          return const Center(
            child: Text("Belum ada data"),
          );
        }

        final kategori = controller.kategori.value;
        final skor = controller.skorTotal.value;
        final color = getCategoryColor(kategori);

        return SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// =====================================================
              /// HEADER REPORT
              /// =====================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      color,
                      color.withValues(alpha: 0.75),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.18),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    /// ================= TOP INFO =================
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [

                        /// LABEL
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Row(
                            children: [

                              Icon(
                                Icons.analytics_rounded,
                                color: Colors.white,
                                size: 14,
                              ),

                              SizedBox(width: 6),

                              Text(
                                "Laporan Hari Ini",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// SCORE
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "Skor $skor / 40",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                              Text(
                                kategori,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                getStatus(kategori),
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 13,
                                ),
                              ),

                              const SizedBox(height: 12),

                              ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(20),
                                child: LinearProgressIndicator(
                                  value: skor / 40,
                                  minHeight: 8,
                                  backgroundColor:
                                      Colors.white24,
                                  color: Colors.white,
                                ),
                              ),

                    const SizedBox(height: 18),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        children: [

                          const Icon(
                            Icons.lightbulb_rounded,
                            color: Colors.white,
                            size: 20,
                          ),

                          const SizedBox(width: 10),

                          Expanded(
                            child: Text(
                              getInsight(kategori),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              

              const SizedBox(height: 28),

              /// =====================================================
              /// TITLE
              /// =====================================================

              const Text(
                "Ringkasan Manajemen Stress",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: darkText,
                ),
              ),

              const SizedBox(height: 16),

              /// =====================================================
              /// REPORT ITEMS
              /// =====================================================

              _reportItem(
                "Sulit Mengontrol Diri",
                mapSkala(controller.kontrolDiri.value),
                Icons.self_improvement,
              ),

              _reportItem(
                "Beban Pikiran",
                mapSkala(controller.bebanPikiran.value),
                Icons.psychology_rounded,
              ),

              _reportItem(
                "Tekanan Harian",
                mapSkala(controller.stresHarian.value),
                Icons.warning_amber_rounded,
              ),

              _reportItem(
                "Kurang Percaya Diri",
                mapSkala(controller.percayaDiri.value),
                Icons.sentiment_dissatisfied_rounded,
              ),

              _reportItem(
                "Kepuasan Hidup",
                mapSkala(controller.kepuasanHidup.value),
                Icons.favorite_rounded,
              ),

              _reportItem(
                "Emosi Tidak Stabil",
                mapSkala(controller.emosi.value),
                Icons.mood_bad_rounded,
              ),

              _reportItem(
                "Kesulitan Coping",
                mapSkala(controller.coping.value),
                Icons.spa_rounded,
              ),

              _reportItem(
                "Overthinking",
                mapSkala(controller.overthinking.value),
                Icons.psychology_alt_rounded,
              ),

              _reportItem(
                "Merasa Kewalahan",
                mapSkala(controller.kewalahan.value),
                Icons.crisis_alert_rounded,
              ),

              _reportItem(
                "Sulit Mengendalikan Situasi",
                mapSkala(controller.kendaliSituasi.value),
                Icons.track_changes_rounded,
              ),

              const SizedBox(height: 28),

              /// =====================================================
              /// RECOMMENDATION
              /// =====================================================

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withValues(alpha: 0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Row(
                      children: [

                        Icon(
                          Icons.favorite_rounded,
                          color: primary,
                        ),

                        SizedBox(width: 8),

                        Text(
                          "Rekomendasi Hari Ini",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    ..._getTips(kategori).map(
                      (e) => Padding(
                        padding:
                            const EdgeInsets.only(bottom: 14),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            Container(
                              margin:
                                  const EdgeInsets.only(top: 6),
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: primary,
                                shape: BoxShape.circle,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Text(
                                e,
                                style: TextStyle(
                                  fontSize: 13,
                                  color:
                                      Colors.grey.shade700,
                                  height: 1.6,
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

              const SizedBox(height: 20),

               /// =====================================================
              /// SARAN PSIKOLOG
              /// =====================================================

              if (kategori == "Sedang" ||
                  kategori == "Tinggi")
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color:
                            Colors.black.withValues(alpha: 0.03),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
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
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(
                                alpha: 0.12,
                              ),
                              borderRadius:
                                  BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              Icons.local_hospital_rounded,
                              color: Colors.red,
                            ),
                          ),

                          const SizedBox(width: 12),

                          const Expanded(
                            child: Text(
                              "Saran Bantuan Profesional",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                    FontWeight.bold,
                                color: darkText,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Text(
                        "Tingkat stresmu menunjukkan bahwa kamu mungkin membutuhkan dukungan profesional agar kondisi emosional lebih terjaga 💙",
                        style: TextStyle(
                          fontSize: 13,
                          height: 1.6,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 22),

                      ...controller.rekomendasiPsikolog.map(
                        (item) => _psikologItem(
                          item.tempat,
                          item.dokter,
                          item.url,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 20),

              /// =====================================================
              /// BREATHING SECTION
              /// =====================================================

              if (kategori == "Sedang" || kategori == "Tinggi")
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        primary,
                        secondary,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Row(
                        children: [

                          Icon(
                            Icons.air_rounded,
                            color: Colors.white,
                          ),

                          SizedBox(width: 8),

                          Text(
                            "Meditasi Pernapasan",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      const Text(
                        "Gunakan teknik pernapasan 4-7-8 untuk membantu menurunkan ketegangan, memperlambat detak jantung, dan membuat pikiran lebih tenang 🌿",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: () {
                          controller.mulaiMeditasi();
                          Get.dialog(
                            Dialog(
                              backgroundColor: Colors.transparent,
                              child: _BreathingDialog(
                                controller: controller,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Center(
                            child: Text(
                              "Mulai Atur Napas",
                              style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),    
            ],
          ),
        );
      }),
    );
  }

  /// =====================================================
  /// REPORT ITEM
  /// =====================================================

  Widget _reportItem(
    String title,
    String value,
    IconData icon,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [

          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: primary,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// =====================================================
  /// TIPS
  /// =====================================================

   List<String> _getTips(String kategori) {
    if (kategori == "Rendah") {
      return [
        "Pertahankan kebiasaan positif setiap hari",
        "Lakukan relaksasi ringan secara rutin",
        "Jaga pola tidur dan aktivitas fisik",
      ];
    } else if (kategori == "Sedang") {
      return [
        "Coba latihan pernapasan atau meditasi",
        "Kurangi aktivitas yang terlalu padat",
        "Luangkan waktu untuk refreshing",
        "Cerita ke orang terpercaya",
      ];
    } else {
      return [
        "Istirahatkan tubuh dan pikiranmu",
        "Kurangi tekanan aktivitas harian",
        "Lakukan teknik relaksasi secara rutin",
        "Pertimbangkan konsultasi profesional",
      ];
    }
  }

  /// =====================================================
  /// ITEM PSIKOLOG
  /// =====================================================

  Widget _psikologItem(
    String rumahSakit,
    String dokter,
    String url,
  ) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),

      onTap: () {
        controller.openDokterUrl(url);
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(20),
        ),

        child: Row(
          children: [

            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF4ADE80)
                    .withValues(alpha: 0.12),

                borderRadius: BorderRadius.circular(16),
              ),

              child: const Icon(
                Icons.person_rounded,
                color: Color(0xFF4ADE80),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,

                children: [

                  Text(
                    dokter,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF1E293B),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    rumahSakit,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.all(8),

              decoration: BoxDecoration(
                color: const Color(0xFF4ADE80)
                    .withValues(alpha: 0.10),

                borderRadius: BorderRadius.circular(12),
              ),

              child: const Icon(
                Icons.open_in_new_rounded,
                size: 18,
                color: Color(0xFF4ADE80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// =====================================================
/// BREATHING DIALOG
/// =====================================================
/// =====================================================
/// BREATHING DIALOG ANIMATED
/// =====================================================

class _BreathingDialog extends StatefulWidget {
  final DetailStressController controller;

  const _BreathingDialog({
    required this.controller,
  });

  @override
  State<_BreathingDialog> createState() => _BreathingDialogState();
}

class _BreathingDialogState extends State<_BreathingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color darkText = Color(0xFF1E293B);

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0.85,
      upperBound: 1.15,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.80,
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 12),
          child: Container(
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 28),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Obx(() {
              final fase = controller.faseNapasan.value;
              final detik = controller.detik.value;
              final siklus = controller.siklusSekarang.value;
              final selesai = controller.meditasiSelesai.value;

              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  /// ICON
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.air_rounded,
                      color: primary,
                      size: 26,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// TITLE
                  const Text(
                    "Meditasi\nPernapasan 🌿",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// SUBTITLE
                  Text(
                    "Ikuti irama napas di bawah ini",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// CIRCLE ANIMATION
                  AnimatedBuilder(
                    animation: animationController,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: animationController.value,
                        child: Container(
                          width: 145,
                          height: 145,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              colors: [primary, secondary],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: primary.withValues(alpha: 0.35),
                                blurRadius: 28,
                                spreadRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                fase.isEmpty ? "Tarik Napas" : fase,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                "$detik",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 18),

                  /// SIKLUS
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      "Siklus $siklus / 4",
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// INSTRUKSI
                  Text(
                    selesai
                        ? "Sesi relaksasi selesai ❤️"
                        : "Tarik 4 detik • Tahan 7 detik • Buang 8 detik",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),

                  const SizedBox(height: 22),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                          vertical: 14,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Selesai",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}