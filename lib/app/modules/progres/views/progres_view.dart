import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';

import '../controllers/progres_controller.dart';

class ProgresView extends GetView<ProgresController> {
  const ProgresView({super.key});

  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color lightGreen = Color(0xFFE8FFF1);

  static const Color bg = Color(0xFFF8FAFC);
  static const Color darkText = Color(0xFF0F172A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,

      body: SafeArea(
        child: RefreshIndicator(
          color: primary,
          onRefresh: () async {
            controller.loadProgress();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),

            child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ================= HEADER =================
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Evaluasi Gaya Hidup",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: darkText,
                              ),
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Pantau keseimbangan gaya hidup kamu",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [primary, secondary],
                          ),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: const Icon(
                          Icons.insights_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 26),

                  /// ================= HEALTH INSIGHT CARD (REPLACE SCORE) =================
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [primary, secondary],
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Text(
                          "Status Gaya Hidup Minggu Ini",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 10),
                                          
                        Text(
                          controller.weeklyInsight,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        Text(
                          controller.weeklyFocus,
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 16),

                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(
                            controller.motivation,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  /// ================= CHART =================
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Perkembangan Gaya Hidup Selama 7 Hari",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),

                        const SizedBox(height: 18),

                        SizedBox(
                          height: 160,
                          child: LineChart(
                            LineChartData(
                              minY: 0,
                              maxY: 1,
                              gridData: const FlGridData(show: false),
                              borderData: FlBorderData(show: false),

                              titlesData: FlTitlesData(
                                leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                
                                /// ================= FIX: PAKAI DATA CONTROLLER =================
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    reservedSize: 28,
                                    getTitlesWidget: (value, meta) {
                                      int i = value.toInt();

                                      if (i < 0 || i >= controller.weeklyDays.length) {
                                        return const SizedBox();
                                      }

                                      return Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          controller.weeklyDays[i],
                                          style: const TextStyle(
                                            fontSize: 10,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              lineBarsData: [
                                LineChartBarData(
                                  isCurved: true,
                                  barWidth: 3,
                                  color: primary,
                                  spots: List.generate(
                                    controller.weeklyProgress.length,
                                    (i) => FlSpot(
                                      i.toDouble(),
                                      controller.weeklyProgress[i],
                                    ),
                                  ),
                                  belowBarData: BarAreaData(
                                    show: true,
                                    color: primary.withOpacity(0.15),
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

                  /// ================= AKTIVITAS FISIK MINGGUAN =================

                  const Text(
                    "Progress Aktivitas Fisik",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [

                        const Icon(
                          Icons.directions_run,
                          color: Colors.green,
                          size: 42,
                        ),

                        const SizedBox(height: 12),

                        Text(
                          controller.aktivitasKategoriWHO.value,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "${controller.frekuensiAktivitas.value} Hari Aktif Minggu Ini",
                          style: const TextStyle(
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 15),

                        LinearProgressIndicator(
                          value: controller.frekuensiAktivitas.value / 7,
                          minHeight: 10,
                          borderRadius: BorderRadius.circular(10),
                          backgroundColor: Colors.grey.shade300,
                          color: Colors.green,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "${((controller.frekuensiAktivitas.value / 7) * 100).toStringAsFixed(0)}%",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          "Target WHO : Aktif 5-7 hari dalam seminggu",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  /// ================= TODAY REPORT =================
                  const Text(
                    "Hasil Evaluasi Hari Ini",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: _cardDecoration(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          controller.todayStatus.value,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Expanded(
                              child: _dailyParameterCard(
                                title: "Aktivitas Fisik",
                                value: controller.aktivitasKategori.value,
                                icon: Icons.directions_run,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _dailyParameterCard(
                                title: "Pola Tidur",
                                value: controller.tidurKategori.value,
                                icon: Icons.hotel,
                                color: Colors.indigo,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(
                              child: _dailyParameterCard(
                                title: "Pola Makan",
                                value: controller.dietKategori.value,
                                icon: Icons.restaurant,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _dailyParameterCard(
                                title: "Manajemen Stress",
                                value: controller.stresKategori.value,
                                icon: Icons.psychology,
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 20),

                        const Text(
                          "Analisis",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          controller.todayConclusion,
                        ),

                        const SizedBox(height: 18),

                        const Text(
                          "Rekomendasi",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          controller.todayRecommendation,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  /// ================= HISTORY =================
                  const Text(
                    "Laporan Gaya Hidup",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 16),

                  controller.dailyReports.isEmpty
                      ? _emptyState()
                      : Column(
                          children: controller.dailyReports.map((report) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              padding: const EdgeInsets.all(18),
                              decoration: _cardDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  /// ================= TANGGAL =================
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          report['full_label'] ?? "",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  /// ================= STATUS =================
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: _getStatusColor(report['status'])
                                          .withOpacity(0.15),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      report['status'] ?? "",
                                      style: TextStyle(
                                        color: _getStatusColor(report['status']),
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  const Text(
                                    "Hasil Evaluasi",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    report["conclusion"] ?? "-",
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      height: 1.4,
                                    ),
                                  ),

                                  const SizedBox(height: 14),

                                  const Text(
                                    "Saran Perbaikan",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  Text(
                                    report["recommendation"] ?? "-",
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _chip(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        "$label : $value",
        style: const TextStyle(
          fontSize: 11,
        ),
      ),
    );
  }

  Color _getStatusColor(String? status) {
    switch (status) {
      case "Sangat Seimbang":
        return Colors.green;

      case "Seimbang":
        return Colors.lightGreen;

      case "Cukup Seimbang":
        return Colors.orange;

      case "Perlu Perbaikan":
        return Colors.red;

      case "Belum Ada Data":
        return Colors.grey;

      default:
        return Colors.grey;
    }
  }

  Widget _dailyParameterCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w700)),
          Text(title, style: const TextStyle(fontSize: 11)),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDecoration(),
      child: const Center(
        child: Text("Belum ada laporan gaya hidup😴"),
      ),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 12,
        ),
      ],
    );
  }
}