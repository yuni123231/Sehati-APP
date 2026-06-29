import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/providers/notification_service.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color darkText = Color(0xFF1E293B);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// ================= HEADER =================
              _buildHeader(),

              const SizedBox(height: 24),

              /// ================= HERO =================
              _heroCard(),

              const SizedBox(height: 18),

              /// ================= QUICK ACTION =================
              _sectionHeader(
                title: "Aktivitas Hari Ini",
                subtitle: "Pantau aktivitas sehatmu ✨",
              ),

              const SizedBox(height: 16),

              _dailyStatusCard(),

              const SizedBox(height: 16),

              _quickActions(),

              const SizedBox(height: 28),

              /// ================= SUMMARY =================
              _sectionHeader(
                title: "Catatan Kebiasaan Hari Ini",
                subtitle: "Lihat hasil pencatatan aktivitas harianmu ✨",
              ),

              const SizedBox(height: 16),

              _lifestyleSummary(),

              const SizedBox(height: 28),

               /// ================= LIFESTYLE BALANCE ==================

              _sectionHeader(
                title: "Gaya Hidup Kamu",
                subtitle: "Lihat pola gaya hidupmu ✨",
              ),

              const SizedBox(height: 16),

              _lifestyleBalanceCard(),

              const SizedBox(height: 16),

              /// ================= BMI =================
              _sectionHeader(
                title: "Status Tubuh",
                subtitle: "Pantau kondisi tubuhmu ✨",
              ),

              const SizedBox(height: 16),

              _bmiCard(),
            ],
          ),
        ),
      ),
    );
  }

  /// =========================================================
  /// HEADER
  /// =========================================================

  Widget _buildHeader() {
    return Obx(
      () => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hai, ${controller.userName.value} 👋",
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                    color: darkText,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  _getGreeting(),
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF4ADE80),
                  Color(0xFF60A5FA),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF60A5FA).withValues(alpha: 0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                Center(
                  child: IconButton(
                    onPressed: () {
                      Get.toNamed('/notifikasi');
                    },
                    icon: const Icon(
                      Icons.notifications_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),

                Obx(() => controller.hasNotif.value
                    ? Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Colors.redAccent,
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    : const SizedBox()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// =========================================================
  /// SECTION HEADER
  /// =========================================================

  Widget _sectionHeader({
    required String title,
    required String subtitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: darkText,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          subtitle,
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade600,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// =========================================================
  /// HERO
  /// =========================================================
Widget _heroCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(22, 28, 22, 22),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        // colors: [primary, secondary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF4ADE80),
          Color(0xFF60A5FA),
        ],
      ),
      borderRadius: BorderRadius.circular(30),
      boxShadow: [
        BoxShadow(
          color: secondary.withValues(alpha: 0.15),
          blurRadius: 25,
          offset: const Offset(0, 12),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// TOP ROW
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            _todayDate(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(height: 18),

        /// MAIN TEXT
        const Text(
          "Mulai kebiasaan sehat\nsedikit demi sedikit 🌱",
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            height: 1.3,
            fontWeight: FontWeight.w800,
          ),
        ),

        const SizedBox(height: 12),

        Obx(
          () => Text(
            controller.heroInsight.value,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              height: 1.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}
  /// =========================================================
  /// QUICK ACTIONS
  /// =========================================================

  Widget _quickActions() {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 0.78,
      children: [
        _QuickItem(
          icon: Icons.restaurant_rounded,
          label: "Makan",
          color: Colors.redAccent,
          onTap: () => Get.toNamed('/add-dietary-habit'),
        ),

        _QuickItem(
          icon: Icons.directions_run_rounded,
          label: "Aktivitas",
          color: Colors.green,
          onTap: () => Get.toNamed('/add-activity'),
        ),

        _QuickItem(
          icon: Icons.nightlight_round,
          label: "Tidur",
          color: Colors.indigo,
          onTap: () => Get.toNamed('/add-sleep'),
        ),

        _QuickItem(
          icon: Icons.self_improvement_rounded,
          label: "Stress",
          color: Colors.orange,
          onTap: () => Get.toNamed('/add-mood'),
        ),
      ],
    );
  }

  /// =========================================================
  /// SUMMARY
  /// =========================================================

  Widget _lifestyleSummary() {
    return Column(
      children: [
        Obx(
          () => _summaryItem(
            icon: Icons.restaurant_menu_rounded,
            title: "Pola Makan",
            subtitle: controller.dietarySubtitle.value,
            score: controller.dietarySkor.value,
            color: Colors.redAccent,
            onTap: () => Get.toNamed('/detail-dietary'),
          ),
        ),

        const SizedBox(height: 14),

        Obx(
          () => _summaryItem(
            icon: Icons.directions_run_rounded,
            title: "Aktivitas Fisik",
            subtitle: controller.aktivitasSubtitle.value,
            score: controller.aktivitasSkor.value,
            color: Colors.green,
            onTap: () => Get.toNamed('/detail-activity'),
          ),
        ),

        const SizedBox(height: 14),

        Obx(
          () => _summaryItem(
            icon: Icons.nightlight_round,
            title: "Pola Tidur",
            subtitle: controller.sleepSubtitle.value,
            score: controller.sleepSkor.value,
            color: Colors.indigo,
            onTap: () => Get.toNamed('/detail-sleep'),
          ),
        ),

        const SizedBox(height: 14),

        Obx(
          () => _summaryItem(
            icon: Icons.self_improvement_rounded,
            title: "Manajemen Stress",
            subtitle: controller.stressSubtitle.value,
            score: controller.stressSkor.value,
            color: Colors.orange,
            onTap: () => Get.toNamed(
              '/detail-stress',
              arguments: {
                "kategori": controller.stressKategori.value,
                "skor_total": controller.stressRawScore.value,
                "kontrol_diri": controller.emosi.value,
                "beban_pikiran": controller.copingStres.value,
                "stres_harian": controller.frekuensiStres.value,
                "percaya_diri": controller.relaksasi.value,
                "kepuasan_hidup": controller.tingkatStres.value,
                "emosi": controller.emosi.value,
                "coping": controller.copingStres.value,
                "overthinking": controller.tingkatStres.value,
                "kewalahan": controller.tingkatStres.value,
                "kendali_situasi": controller.relaksasi.value,
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _summaryItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required int score,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        decoration: _cardDecoration(),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle.isEmpty
                        ? "Belum ada catatan hari ini"
                        : subtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.3,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 6),

                  Text(
                    score >= 8
                        ? "Kondisimu bagus hari ini ✨"
                        : score >= 5
                            ? "Tetap lanjut jaga kebiasaan sehat 💪"
                            : "Yuk mulai pelan-pelan 🌱",
                    style: TextStyle(
                      fontSize: 11,
                      color: color,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 10),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: Colors.grey,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// =========================================================
  /// BMI
  /// =========================================================

  Widget _bmiCard() {
    return Obx(() {
      final bmi = controller.bmi.value;
      final kategori = controller.kategori.value;

      return Container(
        padding: const EdgeInsets.all(18),
        decoration: _cardDecoration(),
        child: Row(
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  bmi.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: primary,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kategori,
                    style: TextStyle(
                      color: _getBmiColor(kategori),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    controller.bodyInsight.value,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  /// =========================================================
  /// DECORATION
  /// =========================================================

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(26),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  /// =========================================================
  /// LOGIC
  /// =========================================================
  
    String _getGreeting() {
      final hour = DateTime.now().hour;

      if (hour >= 4 && hour < 11) {
        return "Selamat pagi 🌞 jangan lupa sarapan ya";
      } else if (hour >= 11 && hour < 15) {
        return "Selamat siang ☀️ tetap semangat hari ini";
      } else if (hour >= 15 && hour < 18) {
        return "Selamat sore 🌤️ jangan lupa istirahat";
      } else if (hour >= 18 && hour < 22) {
        return "Selamat malam 🌙 waktunya rehat pelan-pelan";
      } else {
        return "Masih belum tidur? jangan begadang ya 😴";
      }
    }

  String _getMotivation(double persen) {
    if (persen >= 80) {
      return "🔥 Gila sih, kamu lagi on fire! Keep it up!";
    } else if (persen >= 50) {
      return "💪 Mantap, udah setengah jalan. Sedikit lagi!";
    } else {
      return "🌱 Gapapa pelan dulu, yang penting mulai hari ini!";
    }
  }

  Color _getBmiColor(String kategori) {
    if (kategori.contains("Normal")) return Colors.green;
    if (kategori.contains("Kurus")) return Colors.orange;
    return Colors.redAccent;
  }

  Color _getLifestyleColor(String kategori) {
    switch (kategori) {
      case "Sangat Baik":
        return Colors.green;

      case "Baik":
        return Colors.lightGreen;

      case "Cukup":
        return Colors.orange;

      case "Perlu Perbaikan":
      case "Buruk":
        return Colors.redAccent;

      default:
        return Colors.grey;
    }
  }

  String _getBmiMessage(double bmi) {
    if (bmi < 18.5) {
      return "Berat badanmu masih di bawah ideal";
    } else if (bmi < 25) {
      return "Berat badanmu berada di rentang ideal";
    } else {
      return "Berat badanmu di atas rentang ideal";
    }
  }
  
Widget _dailyStatusCard() {
  return Obx(() {

    bool makan = controller.dietaryKategori.value.isNotEmpty;
    bool aktivitas = controller.aktivitasKategori.value.isNotEmpty;
    bool tidur = controller.sleepKategori.value.isNotEmpty;
    bool stress = controller.stressKategori.value.isNotEmpty;

    int filled = [makan, aktivitas, tidur, stress]
        .where((e) => e)
        .length;

    int remaining = 4 - filled;

    String reminder = "";
    IconData icon = Icons.favorite_rounded;

    /// ================= REMINDER =================

    if (!makan) {
      reminder = "Isi pola makan dulu 🍽️";
      icon = Icons.restaurant_rounded;

    } else if (!aktivitas) {
      reminder = "Yuk isi aktivitas hari ini 👟";
      icon = Icons.directions_run_rounded;

    } else if (!tidur) {
      reminder = "Isi pola tidur yuk 😴";
      icon = Icons.nightlight_round;

    } else if (!stress) {
      reminder = "Mood kamu gimana? 👀";
      icon = Icons.self_improvement_rounded;

    } else {
      reminder = "Tracking hari ini lengkap 🔥";
      icon = Icons.verified_rounded;
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Row(
        children: [

          /// ICON
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  primary.withValues(alpha: 0.16),
                  secondary.withValues(alpha: 0.12),
                ],
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: primary,
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          /// TEXT
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Text(
                  reminder,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: darkText,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  remaining == 0
                      ? "Semua lengkap ✨"
                      : "Masih ada $remaining lagi 👀",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                /// MINI PROGRESS
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    minHeight: 6,
                    value: filled / 4,
                    backgroundColor: Colors.grey.shade200,
                    valueColor:
                        const AlwaysStoppedAnimation(primary),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  });
}

  String _todayDate() {
    final now = DateTime.now();

  final days = [
    "Senin",
    "Selasa",
    "Rabu",
    "Kamis",
    "Jumat",
    "Sabtu",
    "Minggu",
  ];

  final months = [
    "Januari",
    "Februari",
    "Maret",
    "April",
    "Mei",
    "Juni",
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember",
  ];

  return "${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}";
  }

String _getHeroInsight() {
  final insights = [
    "Sedikit gerak hari ini lebih baik daripada tidak sama sekali 🏃",
    "Tidur cukup = mood lebih stabil besok 😴",
    "Minum air bisa bantu fokus kamu meningkat 💧",
    "Kesehatan itu dibangun, bukan instan 🔥",
    "Progress kecil tetap progress 💪",
  ];

  insights.shuffle();
  return insights.first;
}

/// =========================================================
/// LIFESTYLE BALANCE
/// =========================================================

Widget _lifestyleBalanceCard() {
  return Obx(() {

    bool makan = controller.dietaryKategori.value.isNotEmpty;
    bool aktivitas = controller.aktivitasKategori.value.isNotEmpty;
    bool tidur = controller.sleepKategori.value.isNotEmpty;
    bool stress = controller.stressKategori.value.isNotEmpty;

    int filled = [makan, aktivitas, tidur, stress]
        .where((e) => e)
        .length;

    bool completed = filled == 4;

    // final score = controller.sawLifestyleScore;
    final score = controller.lifestyleScore.value;

    Color color;

    if (score >= 8) {
      color = Colors.green;
    } else if (score >= 6) {
      color = Colors.blue;
    } else if (score >= 4) {
      color = Colors.orange;
    } else {
      color = Colors.redAccent;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// ================= TITLE =================

          Row(
            children: [

              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF4ADE80),
                      Color(0xFF60A5FA),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.white,
                  size: 28,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Ringkasan Gaya Hidup",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: darkText,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      completed
                          ? "Semua kebiasaan hari ini sudah tercatat ✨"
                          : "Lengkapi pencatatan kebiasaan harianmu",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          /// ================= MINI STATUS =================

          Row(
            children: [

              _miniStatus(
                "Makan",
                makan,
                Colors.redAccent,
              ),

              const SizedBox(width: 8),

              _miniStatus(
                "Aktivitas",
                aktivitas,
                Colors.green,
              ),

              const SizedBox(width: 8),

              _miniStatus(
                "Tidur",
                tidur,
                Colors.indigo,
              ),

              const SizedBox(width: 8),

              _miniStatus(
                "Stress",
                stress,
                Colors.orange,
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// ================= PROGRESS =================

          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: filled / 4,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation(primary),
            ),
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "$filled dari 4 indikator sudah diisi",
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 18),

          /// ================= RESULT =================

          if (!completed)

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(18),
              ),

              child: Row(
                children: [

                  const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.orange,
                    size: 20,
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "Lengkapi semua indikator agar hasil panduan gaya hidup menjadi lebih akurat ✨",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.orange.shade800,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            )

          else

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [

                  Icon(
                    Icons.verified_rounded,
                    color: color,
                    size: 26,
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          controller.lifestyleKategori.value,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                            color: color,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          completed
                              ? controller.lifestyleInsight.value
                              : "Lengkapi semua kebiasaan harian agar sistem dapat memberikan panduan yang lebih akurat.",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  });
}

  Widget _miniStatus(
  String label,
  bool done,
  Color color,
) {
  return Expanded(
    child: Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: done
            ? color.withValues(alpha: 0.12)
            : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [

          Icon(
            done
                ? Icons.check_circle_rounded
                : Icons.radio_button_unchecked_rounded,
            color: done ? color : Colors.grey,
            size: 18,
          ),

          const SizedBox(height: 4),

          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: done ? color : Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
}
/// =========================================================
/// QUICK ITEM
/// =========================================================

class _QuickItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickItem({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(22),
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),

          const SizedBox(height: 8),

          Flexible(
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),),
            ),
          ),
        ],
      ),
    );
  }
}