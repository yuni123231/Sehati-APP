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
          "Laporan Stress",
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
                                  value: skor / 18,
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
                "Kondisi Emosional",
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
                        "Luangkan 1 menit untuk mengatur napas agar tubuh lebih rileks dan pikiran menjadi lebih tenang 🌿",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          height: 1.6,
                        ),
                      ),

                      const SizedBox(height: 20),

                      GestureDetector(
                        onTap: () {
                          Get.dialog(
                            Dialog(
                              backgroundColor: Colors.transparent,
                              child: _BreathingDialog(),
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

class _BreathingDialog extends StatefulWidget {
  @override
  State<_BreathingDialog> createState() =>
      _BreathingDialogState();
}

class _BreathingDialogState
    extends State<_BreathingDialog>
    with SingleTickerProviderStateMixin {

  late AnimationController animationController;

  String phase = "Tarik";
  String subtitle = "Tarik napas perlahan";

  int seconds = 4;

  bool isRunning = true;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
      lowerBound: 0.82,
      upperBound: 1.05,
    );

    animationController.repeat(reverse: true);

    startCycle();
  }

  Future<void> startCycle() async {
    while (mounted && isRunning) {

      for (int i = 4; i >= 1; i--) {
        if (!mounted) return;

        setState(() {
          phase = "Tarik";
          subtitle = "Tarik napas melalui hidung";
          seconds = i;
        });

        await Future.delayed(
          const Duration(seconds: 1),
        );
      }

      for (int i = 7; i >= 1; i--) {
        if (!mounted) return;

        setState(() {
          phase = "Tahan";
          subtitle = "Tahan napas";
          seconds = i;
        });

        await Future.delayed(
          const Duration(seconds: 1),
        );
      }

      for (int i = 8; i >= 1; i--) {
        if (!mounted) return;

        setState(() {
          phase = "Hembuskan";
          subtitle = "Hembuskan perlahan melalui mulut";
          seconds = i;
        });

        await Future.delayed(
          const Duration(seconds: 1),
        );
      }
    }
  }

  @override
  void dispose() {
    isRunning = false;
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 20,
      ),
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(
            maxWidth: 380,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 28,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(34),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              /// ================= TITLE =================
              const Text(
                "Meditasi\nNapas 🌿",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E293B),
                  height: 1.2,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 26),

              /// ================= ANIMATION =================
              AnimatedBuilder(
                animation: animationController,
                builder: (_, child) {
                  return Transform.scale(
                    scale: animationController.value,
                    child: Container(
                      width: 165,
                      height: 165,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF4ADE80),
                            Color(0xFF60A5FA),
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF60A5FA,
                            ).withValues(alpha: 0.22),
                            blurRadius: 28,
                            spreadRadius: 4,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment:
                            MainAxisAlignment.center,
                        children: [

                          Text(
                            phase,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            "$seconds",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 34,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 26),

              /// ================= INFO =================
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F7FB),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF4ADE80,
                        ).withValues(alpha: 0.15),
                        borderRadius:
                            BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Color(0xFF4ADE80),
                        size: 18,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Text(
                        "Latihan pernapasan membantu tubuh lebih rileks dan pikiran menjadi lebih tenang.",
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.6,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              /// ================= BUTTON =================
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    isRunning = false;
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF4ADE80),
                    elevation: 0,
                    padding:
                        const EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    "Selesai",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
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
}
