import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/providers/api_services.dart';

class ProgresController extends GetxController {
  final ApiServices api = ApiServices();
  final box = GetStorage();

  Map<String, dynamic>? todayHistory;

  /// ================= LOADING =================
  final isLoading = false.obs;

  /// ================= GRAPH =================
  final weeklyProgress = List<double>.filled(7, 0.0).obs;
  final weeklyDays = <String>[].obs;
  final aktivitasProgress = List<double>.filled(7, 0.0).obs;

  /// ================= WHO =================
  final frekuensiAktivitas = 0.obs;
  final aktivitasKategoriWHO = "".obs;

  /// ================= SCORE =================
  final healthScore = 0.obs;
  final weeklyStatus = "".obs;
  
  /// ================= PARAMETER NORMALISASI =================
  final aktivitasScoreNormal = 0.0.obs;
  final dietScoreNormal = 0.0.obs;
  final tidurScoreNormal = 0.0.obs;
  final stresScoreNormal = 0.0.obs;

  /// ================= TODAY =================
  final aktivitasKategori = "".obs;
  final dietKategori = "".obs;
  final tidurKategori = "".obs;
  final stresKategori = "".obs;

  final todayStatus = "".obs;
  final todayConclusionText = "".obs;
  final todayRecommendationText = "".obs;

  /// ================= DATA ASLI PARAMETER =================

  final aktivitasAsli = 0.0.obs;
  final dietAsli = 0.obs;
  final tidurAsli = 0.obs;
  final stressAsli = 0.obs;

  /// ================= REPORT =================
  final dailyReports = <Map<String, dynamic>>[].obs;
  final hasTodayData = false.obs;

  Timer? refreshTimer;

  @override
  void onInit() {
    super.onInit();
    loadProgress();
  }

  @override
  void onReady() {
    super.onReady();
    loadProgress();
  }

  @override
  void onClose() {
    refreshTimer?.cancel();
    super.onClose();
  }

  /// ================= WHO =================
  void hitungAktivitasWHO() {
    final value = frekuensiAktivitas.value;

    if (value >= 5) {
      aktivitasKategoriWHO.value = "Memenuhi Rekomendasi WHO";
    } else if (value >= 3) {
      aktivitasKategoriWHO.value = "Hampir Memenuhi";
    } else if (value >= 1) {
      aktivitasKategoriWHO.value = "Kurang Aktif";
    } else {
      aktivitasKategoriWHO.value = "Tidak Aktif";
    }
  }

  /// ================= RESET DATA =================
  void resetData() {
    dailyReports.clear();

    todayHistory = null;

    weeklyProgress.value = List.filled(7, 0.0);
    aktivitasProgress.value = List.filled(7, 0.0);

    hasTodayData.value = false;
    todayStatus.value = "Belum Ada Data";
    todayConclusionText.value = "";
    todayRecommendationText.value = "";

    aktivitasKategori.value = "-";
    dietKategori.value = "-";
    tidurKategori.value = "-";
    stresKategori.value = "-";

    frekuensiAktivitas.value = 0;
  }

  /// ================= LOAD PROGRESS =================
  Future<void> loadProgress() async {
    try {
      isLoading.value = true;

      final userId = box.read('userId');
      if (userId == null) return;

      final history = await api.getHistory(userId);
      final today = await api.getTodayReport(userId);

      resetData();

      final now = DateTime.now();
      final todayDate = now.toIso8601String().substring(0, 10);

      Map<String, double> scoreMap = {};
      Map<String, double> aktivitasMap = {};
      // Map<String, dynamic>? todayHistory;
      todayHistory = null;

      /// ================= HISTORY =================
      if (history["success"] == true) {
        List data = history["data"];

        data.sort((a, b) => a["tanggal"].compareTo(b["tanggal"]));

        for (var item in data) {
          final tanggal = (item["tanggal"] ?? "").toString();
          if (tanggal.isEmpty) continue;

          final date = tanggal.substring(0, 10);

          if (date == todayDate) {
            todayHistory = item;
          }

          final parsedDate = DateTime.parse(tanggal);
          final diff = now.difference(parsedDate).inDays;

          if (diff <= 6) {
            final score = (item["score"] ?? 0).toDouble();
            final freq = (item["frekuensi_mingguan"] ?? 0).toDouble();

            scoreMap[date] = (score / 10).clamp(0.0, 1.0);
            aktivitasMap[date] = (freq / 7).clamp(0.0, 1.0);
          }

          dailyReports.add({
            "tanggal": item["tanggal"],
            "full_label": item["full_label"] ?? "",
            "score": item["score"] ?? 0,
            "status": item["status"] ?? "",
            "aktivitas_score": item["aktivitas"] ?? 0,
            "diet_score": item["diet"] ?? 0,
            "tidur_score": item["tidur"] ?? 0,
            "stres_score": item["stres"] ?? 0,
            "aktivitas_kategori": item["aktivitas_kategori"] ?? "-",
            "diet_kategori": item["diet_kategori"] ?? "-",
            "tidur_kategori": item["tidur_kategori"] ?? "-",
            "stres_kategori": item["stres_kategori"] ?? "-",
            "conclusion": item["conclusion"] ?? "",
            "recommendation": item["recommendation"] ?? "",
          });
        }
      }

      //// ================= TODAY STATUS =================

      if(today["success"] == true){
        healthScore.value =
            (today["score"] ?? 0).round();
        weeklyStatus.value =
            today["status"] ?? "Belum Ada Data";
      }

      /// ================= GRAPH SCORE =================
      weeklyProgress.value = List.generate(7, (i) {
        final day = now.subtract(Duration(days: 6 - i));
        final key = day.toIso8601String().substring(0, 10);
        return scoreMap[key] ?? 0.0;
      });

      /// ================= GRAPH LABEL =================
      const dayNames = ["Min", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab"];

      weeklyDays.value = List.generate(7, (i) {
        final day = now.subtract(Duration(days: 6 - i));
        return dayNames[day.weekday % 7];
      });

      /// ================= GRAPH AKTIVITAS =================
      aktivitasProgress.value = List.generate(7, (i) {
        final day = now.subtract(Duration(days: 6 - i));
        final key = day.toIso8601String().substring(0, 10);
        return aktivitasMap[key] ?? 0.0;
      });

      /// ================= TODAY DETAIL =================

      if(todayHistory != null &&
        today["success"] == true){
        hasTodayData.value = true;

        todayStatus.value =
            today["status"] ?? "Belum Ada Data";

        todayConclusionText.value =
            today["conclusion"] ?? "";

        aktivitasKategori.value =
            todayHistory!["aktivitas_kategori"] ?? "-";

        dietKategori.value =
            todayHistory!["diet_kategori"] ?? "-";

        tidurKategori.value =
            todayHistory!["tidur_kategori"] ?? "-";

        stresKategori.value =
            todayHistory!["stres_kategori"] ?? "-";

        aktivitasScoreNormal.value =
            ((todayHistory!["aktivitas"] ?? 0) as num)
            .toDouble();

        dietScoreNormal.value =
            ((todayHistory!["diet"] ?? 0) as num)
            .toDouble();

        tidurScoreNormal.value =
            ((todayHistory!["tidur"] ?? 0) as num)
            .toDouble();

        stresScoreNormal.value =
            ((todayHistory!["stres"] ?? 0) as num)
            .toDouble();

        frekuensiAktivitas.value =
            todayHistory!["frekuensi_mingguan"] ?? 0;
         
        // todayRecommendationText.value =
        //     weeklyFocus;

        // todayRecommendationText.value =
        //     combinedRecommendation;
        todayRecommendationText.value =
            todayHistory?["recommendation"] ?? "";
      }

      /// ================= UPDATE REPORT TODAY =================

for(var report in dailyReports){

  if(report["tanggal"]
      .toString()
      .substring(0,10) == todayDate){


    report["status"] =
        today["status"] ?? "";


    report["conclusion"] =
        today["conclusion"] ?? "";


    // report["recommendation"] =
    //     shortLifestyleReport;
    report["recommendation"] =
        report["recommendation"];

  }

}

      hitungAktivitasWHO();

      weeklyProgress.refresh();
      aktivitasProgress.refresh();
      dailyReports.refresh();
    } catch (e) {
      print("ERROR LOAD: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// ================= INSIGHT =================
  String get weeklyInsight => weeklyStatus.value;

//   String get weeklyFocus {

//   final weakest = progressWeakestParameter;

//   switch(weakest){
//     case "Aktivitas Fisik":
//     return
//       "Fokus minggu ini: tingkatkan aktivitas fisik 🚶";
//     case "Pola Makan":
//     return
//       "Fokus minggu ini: perbaiki pola makan 🥗";
//     case "Pola Tidur":
//     return
//       "Fokus minggu ini: perbaiki kualitas tidur 😴";
//     case "Manajemen Stress":
//     return
//       "Fokus minggu ini: kelola stres lebih baik 🌿";
//     default:
//     return
//       "Pertahankan gaya hidup sehat kamu 🔥";
//   }
// }

  String get weeklyFocus {

    Map<String,double> nilai = {
      
      "Aktivitas Fisik":
        aktivitasScoreNormal.value,

      "Pola Makan":
        dietScoreNormal.value,

      "Pola Tidur":
        tidurScoreNormal.value,

      "Manajemen Stress":
        stresScoreNormal.value,
    };

    final prioritas =
      nilai.entries.reduce(
        (a,b)=>
        a.value < b.value ? a:b
      );

    switch(prioritas.key){
      case "Aktivitas Fisik":
      return
        "Prioritas minggu ini: tingkatkan aktivitas fisik dengan lebih rutin bergerak 🚶";
      case "Pola Makan":
      return
        "Prioritas minggu ini: perbaiki pola makan agar lebih seimbang 🥗";
      case "Pola Tidur":
      return
        "Prioritas minggu ini: tingkatkan kualitas tidur dan atur waktu istirahat 😴";
      case "Manajemen Stress":
      return
        "Prioritas minggu ini: kelola stres dengan relaksasi dan istirahat cukup 🌿";
      default:
      return "";
    }
  }

  String get categoryIssue {

    List<String> hasil = [];


    if (
      aktivitasKategori.value.toLowerCase().contains("kurang") ||
      aktivitasKategori.value.toLowerCase().contains("tidak")
    ) {
      hasil.add(
        "🚶 Aktivitas fisik kamu masih kurang. Coba tambah gerakan harian seperti berjalan kaki, naik tangga, atau olahraga ringan."
      );
    }


    if (
      dietKategori.value.toLowerCase().contains("cukup")
    ) {
      hasil.add(
        "🥗 Pola makan sudah cukup baik, tetapi masih bisa diperbaiki dengan memilih makanan lebih seimbang dan mengurangi makanan kurang sehat."
      );
    }


    if (
      tidurKategori.value.toLowerCase().contains("cukup")
    ) {
      hasil.add(
        "😴 Waktu tidur sudah cukup, tetapi usahakan tidur lebih teratur agar tubuh lebih segar."
      );
    }


    if (
      stresKategori.value.toLowerCase().contains("sedang")
    ) {
      hasil.add(
        "🌿 Tingkat stres masih perlu diperhatikan. Coba luangkan waktu untuk relaksasi, istirahat, atau aktivitas yang membuat lebih tenang."
      );
    }


    if(hasil.isEmpty){
      return "💚 Semua kebiasaan sehat kamu sudah berjalan baik. Tetap pertahankan rutinitas ini.";
    }


    return hasil.join("\n\n");
  }

    String get priorityIssue {

      Map<String,double> skor = {

        "aktivitas fisik":
          aktivitasScoreNormal.value,

        "pola makan":
          dietScoreNormal.value,

        "pola tidur":
          tidurScoreNormal.value,

        "manajemen stres":
          stresScoreNormal.value,

      };


      final prioritas =
          skor.entries.reduce(
            (a,b)=>a.value < b.value ? a : b
          );


      switch(prioritas.key){

        case "aktivitas fisik":
          return
          "Minggu ini fokuslah untuk lebih aktif bergerak. Mulai dari target kecil seperti berjalan kaki 20–30 menit atau melakukan aktivitas ringan setiap hari.";

        case "pola makan":
          return
          "Minggu ini fokuslah memperbaiki pola makan. Usahakan makan lebih teratur dan pilih makanan dengan gizi yang lebih seimbang.";

        case "pola tidur":
          return
          "Minggu ini fokuslah memperbaiki kualitas tidur. Coba tidur dan bangun pada waktu yang lebih konsisten.";

        case "manajemen stres":
          return
          "Minggu ini fokuslah mengelola stres. Sisihkan waktu untuk istirahat, relaksasi, atau aktivitas yang membuat pikiran lebih tenang.";

        default:
          return
          "Pertahankan kebiasaan sehat kamu agar tetap konsisten.";
      }
  }

  String get priorityName {

    final skor = {

      "aktivitas fisik":
          aktivitasScoreNormal.value,

      "pola makan":
          dietScoreNormal.value,

      "pola tidur":
          tidurScoreNormal.value,

      "manajemen stres":
          stresScoreNormal.value,

    };

    return skor.entries
        .reduce(
          (a, b) =>
              a.value < b.value
                  ? a
                  : b,
        )
        .key;
  }

  String get combinedRecommendation {
    return
      "Perlu perhatian minggu ini:\n\n"
          "$categoryIssue\n\n\n"
      "Fokus dan langkah yang bisa dilakukan:\n\n"
          "$priorityIssue";
  }

  String get motivation {
    if (weeklyStatus.value == "Seimbang") {
      return "Kebiasaan sehatmu sudah seimbang dan konsisten, pertahankan ya! 🔥";
    }

    if (weeklyStatus.value == "Cukup Seimbang") {
      return "Gaya hidupmu cukup baik, namun masih ada aspek yang bisa ditingkatkan 🌱";
    }

    return "Perlu perhatian lebih pada kebiasaan harianmu, ayo mulai perbaiki perlahan 💪";
  }

  String get progressWeakestParameter {


  Map<String,double> skor = {


    "Aktivitas Fisik":
        _getAktivitasScore(),


    "Pola Makan":
        _getDietScore(),


    "Pola Tidur":
        _getTidurScore(),


    "Manajemen Stress":
        _getStressScore(),

  };


  return skor.entries
      .reduce((a,b)=>
          a.value < b.value ? a:b)
      .key;

}

String get shortLifestyleReport {

  final fokus = priorityName;

  switch(fokus){

    case "aktivitas fisik":
      return "Fokus: tambah aktivitas fisik harian 🚶";

    case "pola makan":
      return "Fokus: perbaiki pola makan agar lebih seimbang 🥗";

    case "pola tidur":
      return "Fokus: tingkatkan kualitas tidur 😴";

    case "manajemen stres":
      return "Fokus: kelola stres dan beri waktu untuk relaksasi 🌿";

    default:
      return "Pertahankan kebiasaan sehat 💚";
  }
}

double _getAktivitasScore(){

  if(todayHistory == null) return 0;

  return 
  ((todayHistory!["aktivitas"] ?? 0)
      as num)
      .toDouble();

}



double _getDietScore(){

  if(todayHistory == null) return 0;

  return 
  ((todayHistory!["diet"] ?? 0)
      as num)
      .toDouble();

}



double _getTidurScore(){

  if(todayHistory == null) return 0;

  return 
  ((todayHistory!["tidur"] ?? 0)
      as num)
      .toDouble();

}



double _getStressScore(){

  if(todayHistory == null) return 0;

  return 
  ((todayHistory!["stres"] ?? 0)
      as num)
      .toDouble();

}

  String get todayConclusion => todayConclusionText.value;
  String get todayRecommendation => todayRecommendationText.value;
}