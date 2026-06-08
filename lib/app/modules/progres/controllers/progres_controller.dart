import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:async';
import '../../../data/providers/api_services.dart';

class ProgresController extends GetxController {
  final ApiServices api = ApiServices();
  final box = GetStorage();

  /// ================= LOADING =================
  final isLoading = false.obs;

  /// ================= 7 HARI DATA =================
  final weeklyProgress = List<double>.filled(7, 0.0).obs;
  final weeklyDays = <String>[].obs;

  /// ================= SCORE =================
  final healthScore = 0.obs;
  final weeklyStatus = "".obs;

  /// ================= KATEGORI HARI INI =================
  final aktivitasKategori = "".obs;
  final dietKategori = "".obs;
  final tidurKategori = "".obs;
  final stresKategori = "".obs;

  final todayStatus = "".obs;
  final todayConclusionText = "".obs;
  final todayRecommendationText = "".obs;

  /// ================= REPORT =================
  final dailyReports = <Map<String, dynamic>>[].obs;

  Timer? refreshTimer;

  @override
  void onInit() {
    super.onInit();
    loadProgress();

    /// refresh lebih aman (tidak tiap 5 detik)
    refreshTimer = Timer.periodic(
      const Duration(minutes: 10),
      (timer) => loadProgress(),
    );
  }

  /// ================= LOAD DATA =================
  Future<void> loadProgress() async {
    try {
      isLoading.value = true;

      final userId = box.read('userId');
      if (userId == null) return;

      final today = await api.getToday(userId);
      final history = await api.getHistory(userId);

      /// ================= TODAY SCORE =================
      double aktivitas = (today['aktivitas'] ?? 0).toDouble();
      double diet = (today['diet'] ?? 0).toDouble();
      double tidur = (today['tidur'] ?? 0).toDouble();
      double stres = (today['stres'] ?? 0).toDouble();

      /// ================= RESET =================
      dailyReports.clear();
      List<double> weekData = [];

      double totalScore = 0;
      int totalData = 0;

      List data = [];

      if (history['success'] == true) {
        data = history['data'];

        data.sort((a, b) => a['tanggal'].compareTo(b['tanggal']));

        DateTime now = DateTime.now();

        for (var item in data) {
          try {
            String tanggal = item['tanggal'] ?? "";
            if (tanggal.isEmpty) continue;

            DateTime parsed = DateTime.parse(tanggal);

            int diff = now.difference(parsed).inDays;

            /// hanya 7 hari terakhir
            if (diff <= 6) {
              double score = (item['score'] ?? 0).toDouble();

              if (score > 0) {
                totalScore += score;
                totalData++;
              }

              /// ================= GRAFIK 7 HARI BERURUTAN =================

              double normalized =
                  (score / 10).clamp(0.0, 1.0);

              weekData.add(normalized);

              /// ================= DAILY REPORT =================

              dailyReports.add({

                "tanggal": item["tanggal"],

                "full_label":
                    item["full_label"] ?? "",

                "score":
                    item["score"] ?? 0,

                "status":
                    item["status"] ?? "",

                "aktivitas":
                    item["aktivitas_kategori"] ?? "-",

                "diet":
                    item["diet_kategori"] ?? "-",

                "tidur":
                    item["tidur_kategori"] ?? "-",

                "stres":
                    item["stres_kategori"] ?? "-",

                "conclusion":
                    item["conclusion"] ?? "",

                "recommendation":
                    item["recommendation"] ?? "",
              });
              weeklyDays.add(
                parsed.day.toString(),
              );
            }
          } catch (e) {
            print("ERROR ITEM: $e");
          }
        }
      }

      /// ================= FINAL SCORE (KESEIMBANGAN) =================
      // healthScore.value =
      //     ((today['score'] ?? 0) as num).round();

      // /// ================= STATUS MINGGUAN =================
      // if (healthScore.value >= 8) {
      //   weeklyStatus.value = "Sangat Seimbang";
      // }
      // else if (healthScore.value >= 6) {
      //   weeklyStatus.value = "Seimbang";
      // }
      // else if (healthScore.value >= 4) {
      //   weeklyStatus.value = "Kurang Seimbang";
      // }
      // else {
      //   weeklyStatus.value = "Tidak Seimbang";
      // }

      weeklyStatus.value =
          today['status'] ?? "Belum Ada Data";      

      weeklyProgress.value = weekData;

      if (data.isNotEmpty) {
        final todayData = data.last;

        todayStatus.value =
            todayData["status"] ?? "Belum Ada Data";

        todayConclusionText.value =
            todayData["conclusion"] ?? "";

        todayRecommendationText.value =
            todayData["recommendation"] ?? "";

        aktivitasKategori.value =
            todayData["aktivitas_kategori"] ?? "-";

        dietKategori.value =
            todayData["diet_kategori"] ?? "-";

        tidurKategori.value =
            todayData["tidur_kategori"] ?? "-";

        stresKategori.value =
            todayData["stres_kategori"] ?? "-";
      }

    } catch (e) {
      print("ERROR LOAD: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= UTIL =================
  String _getDayName(int weekday) {
    const days = [
      "Senin",
      "Selasa",
      "Rabu",
      "Kamis",
      "Jumat",
      "Sabtu",
      "Minggu"
    ];
    return days[weekday - 1];
  }

  /// ================= INSIGHT =================
  String get weeklyInsight {

    switch (weeklyStatus.value) {

      case "Sangat Seimbang":
        return "Sangat Seimbang";

      case "Seimbang":
        return "Seimbang";

      case "Kurang Seimbang":
        return "Kurang Seimbang";

      case "Tidak Seimbang":
        return "Tidak Seimbang";

      default:
        return "Belum Ada Data";
    }
  }

  String get weeklyFocus {
    List<String> focus = [];

    if (aktivitasKategori.value.contains("Kurang")) {
      focus.add("aktivitas fisik");
    }
    if (dietKategori.value.contains("Buruk")) {
      focus.add("pola makan");
    }
    if (
      tidurKategori.value.contains("Buruk") ||
      tidurKategori.value.contains("Kurang")
    ) {
      focus.add("pola tidur");
    }
    if (
      stresKategori.value.contains("Sedang") ||
      stresKategori.value.contains("Tinggi")
    ) {
      focus.add("manajemen stres");
    }

    return focus.isEmpty
        ? "Pertahankan gaya hidup sehat kamu 🔥"
        : "Fokus minggu ini: ${focus.join(", ")}";
  }

  String get motivation {
    if (healthScore.value >= 8) return "Keren banget 🔥";
    if (healthScore.value >= 6) return "Udah bagus 👍";
    return "Yuk perbaiki pelan-pelan 🌱";
  }

  String get todayConclusion {
    return todayConclusionText.value;
  }

  String get todayRecommendation {
    return todayRecommendationText.value;
  }

  @override
  void onClose() {
    refreshTimer?.cancel();
    super.onClose();
  }
}