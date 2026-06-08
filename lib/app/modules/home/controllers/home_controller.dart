import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/models/guide_item.dart';
import '../../../data/providers/api_services.dart';

class HomeController extends GetxController {
  final ApiServices api = ApiServices();
  final box = GetStorage();

  final userName = ''.obs;
  late int userId;

  final consumedCalories = 0.obs;
  final totalCalories = 0.obs;
  
  final bmi = 0.0.obs;
  final kategori = ''.obs;
  final bodyInsight = ''.obs;

  /// ✅ AKTIVITAS
  final aktivitasKategori = ''.obs;
  final aktivitasSkor = 0.obs;

  // ================== DETAIL AKTIVITAS ==================
  final menitPerHari = 0.obs;
  final hariPerMinggu = 0.obs;
  final frekuensi = 0.obs;
  final jenis = 0.obs;
  final detail = 0.obs;
  final sedentary = 0.obs;
  final konsistensi = 0.obs;

  /// ✅ DIETARY
  final dietaryKategori = ''.obs;
  final dietaryRawScore = 0.obs; // 0-21
  final dietarySkor = 0.obs;     // 0-10

  final frekuensiMakan = 0.obs;
  final sarapan = 0.obs;
  final sayurBuah = 0.obs;
  final junkFood = 0.obs;
  final minumanManis = 0.obs;
  final airPutih = 0.obs;
  final makananLengkap = 0.obs;
  
  /// ================== STRESS ==================
  final stressKategori = ''.obs;
  final stressSkor = 0.obs;

  final frekuensiStres = 0.obs;
  final tingkatStres = 0.obs;
  final emosi = 0.obs;
  final gangguanTidur = 0.obs;
  final copingStres = 0.obs;
  final relaksasi = 0.obs;

  /// ================== SLEEP ==================
  final sleepKategori = ''.obs;
  final sleepSkor = 0.obs;

  final durasiTidur = 0.obs;
  final gangguan = 0.obs;
  final lamaTerbangun = 0.obs;
  final kualitas = 0.obs;
  final keteraturan = 0.obs;

  /// ================= REKOMENDASI =================
  final dietaryRekomendasi = <String>[].obs;
  final stressRekomendasi = <String>[].obs;

  var todayAktivitas = 0.obs;
  var todayDiet = 0.obs;
  var todayTidur = 0.obs;
  var todayStres = 0.obs;

  final historyList = <dynamic>[].obs;

  /// ================= SUBTITLE =================
  final aktivitasSubtitle = ''.obs;
  final dietarySubtitle = ''.obs;
  final sleepSubtitle = ''.obs;
  final stressSubtitle = ''.obs;

  /// =========================================================
  /// BOBOT SPK SAW
  /// =========================================================

  /// MANJEMEN STRESS = 35%
  /// TIDUR           = 30%
  /// AKTIVITAS       = 20%
  /// POLA MAKAN      = 15%

  static const double bobotMakan = 0.15;
  static const double bobotAktivitas = 0.20;
  static const double bobotTidur = 0.30;
  static const double bobotStress = 0.35;

  /// =========================================================
  /// PERHITUNGAN SAW
  /// =========================================================

  double get sawLifestyleScore {
    return
        (dietarySkor.value * bobotMakan) +
        (aktivitasSkor.value * bobotAktivitas) +
        (sleepSkor.value * bobotTidur) +
        (stressSkor.value * bobotStress);
  }

  /// =========================================================
  /// KATEGORI HASIL
  /// =========================================================

  String get sawKategori {
    final score = sawLifestyleScore;

    if (score >= 8) {
      return "Sangat Sehat";
    } else if (score >= 6) {
      return "Sehat";
    } else if (score >= 4) {
      return "Cukup";
    } else {
      return "Perlu Perbaikan";
    }
  }

  /// =========================================================
  /// STATUS UI
  /// =========================================================

  String get sawStatus {
    final score = sawLifestyleScore;

    if (score >= 8) {
      return "Lifestyle Kamu Sangat Bagus ✨";
    } else if (score >= 6) {
      return "Lifestyle Kamu Sudah Baik 💪";
    } else if (score >= 4) {
      return "Lifestyle Kamu Cukup 🌱";
    } else {
      return "Lifestyle Kamu Perlu Diperbaiki ⚠️";
    }
  }

  String get weakestParameter {

    Map<String, double> skor = {
      "Pola Makan": dietarySkor.value.toDouble(),
      "Aktivitas Fisik": aktivitasSkor.value.toDouble(),
      "Tidur": sleepSkor.value.toDouble(),
      "Manajemen Stress": stressSkor.value.toDouble(),
    };

    return skor.entries
        .reduce((a, b) => a.value < b.value ? a : b)
        .key;
  }

  /// =========================================================
  /// MESSAGE UI
  /// =========================================================

  String get sawMessage {

    switch (weakestParameter) {

      case "Pola Makan":
        return
            "Pola makan menjadi faktor yang paling perlu diperbaiki saat ini.";

      case "Aktivitas Fisik":
        return
            "Aktivitas fisik menjadi faktor utama yang masih kurang.";

      case "Tidur":
        return
            "Kualitas tidur menjadi faktor yang paling mempengaruhi lifestyle kamu.";

      case "Manajemen Stress":
        return
            "Manajemen stress menjadi faktor yang paling perlu diperhatikan.";

      default:
        return
            "Lifestyle kamu sudah cukup baik.";
    }
  }

  /// =========================================================
  /// TIPS UI
  /// =========================================================

  String get sawTips {

    switch (weakestParameter) {

      case "Pola Makan":
        return
            "Perbanyak sayur, kurangi junk food, dan minum air putih cukup 🍽️";

      case "Aktivitas Fisik":
        return
            "Coba tambah jalan kaki atau stretching minimal 30 menit 🚶";

      case "Tidur":
        return
            "Tidur lebih teratur dan hindari begadang 😴";

      case "Manajemen Stress":
        return
            "Luangkan waktu relaksasi dan kurangi overthinking 🌿";

      default:
        return
            "Pertahankan kebiasaan sehatmu setiap hari 🔥";
    }
  }

  void generateAllSubtitles() {
    generateAktivitasSubtitle();
    generateDietarySubtitle();
    generateSleepSubtitle();
    generateStressSubtitle();
  }

  /// ================== FINAL SCORE ==================
  // final lifestyleScore = 0.obs;
  // final lifestyleKategori = ''.obs;

  final lifestyleScore = 0.0.obs;
  final lifestyleKategori = ''.obs;
  final lifestyleInsight = ''.obs;
  final lifestyleRecommendation = ''.obs;

  bool get isLifestyleComplete =>
      aktivitasKategori.value.isNotEmpty &&
      dietaryKategori.value.isNotEmpty &&
      sleepKategori.value.isNotEmpty &&
      stressKategori.value.isNotEmpty;

  @override
  void onInit() {
    super.onInit();

    userId = box.read('userId') ?? 0;

    if (userId == 0) {
      Get.offAllNamed('/signin');
      return;
    }
    

    // /// 🔥 URUTAN AMAN
    // fetchUserProfile().then((_) async {
    //   await fetchConsumedCalories();
    //   await fetchActivity();
    //   updateLifestyleIfReady();
    //   await fetchDietary();
    //   updateLifestyleIfReady();
    //   await fetchStress();
    //   updateLifestyleIfReady();
    //   await fetchSleep();
    //   updateLifestyleIfReady();
    //   // calculateLifestyleScore();
    //   // calculateXP();
    //   await fetchToday();
    //   await fetchHistory();
    //   generateDailyGuides();
    // });
    loadAllData();
  }

  Future<void> loadAllData() async {

    /// PROFILE
    await fetchUserProfile();

    generateHeroInsight();

    /// KALORI
    await fetchConsumedCalories();

    /// TRACKING
    await fetchActivity();
    await fetchDietary();
    await fetchStress();
    await fetchSleep();

    /// HITUNG LIFESTYLE
    calculateLifestyleScore();
    generateBodyInsight();

    /// TODAY & HISTORY
    await fetchToday();
    await fetchHistory();

    /// GUIDE
    generateDailyGuides();

    /// UPDATE UI
    update();
  }

  /// ================= PROFILE =================
  Future<void> fetchUserProfile() async {
    final profile = await api.getUserProfile(userId);

    // print("========== DATA PROFILE ==========");
    // print(profile);

    if (profile == null) return;

    userName.value = profile['nama']?.toString() ?? '';

    final kalori = profile['kebutuhan_kalori'];
    final tdee = profile['tdee'];

    if (kalori is int && kalori > 0) {
      totalCalories.value = kalori;
    } else if (kalori is double && kalori > 0) {
      totalCalories.value = kalori.toInt();
    } else if (kalori is String &&
        int.tryParse(kalori) != null &&
        int.parse(kalori) > 0) {
      totalCalories.value = int.parse(kalori);
    } else if (tdee is int) {
      totalCalories.value = tdee;
    } else if (tdee is double) {
      totalCalories.value = tdee.toInt();
    } else {
      totalCalories.value = 0;
    }

    // final bmiValue = profile['bmi'];

    // if (bmiValue is double) {
    //   bmi.value = bmiValue;
    // } else if (bmiValue is int) {
    //   bmi.value = bmiValue.toDouble();
    // } else {
    //   bmi.value = 0;
    // }

    final bmiValue = profile['bmi'];

    if (bmiValue is double) {
      bmi.value = bmiValue;
    } else if (bmiValue is int) {
      bmi.value = bmiValue.toDouble();
    } else if (bmiValue is String && double.tryParse(bmiValue) != null) {
      bmi.value = double.parse(bmiValue);
    } else {
      bmi.value = 0;
    }

    kategori.value = profile['kategori'] ?? '';
  }

  /// ================= KALORI =================
  Future<void> fetchConsumedCalories() async {
    try {
      final response = await api.getTodaysDetections(userId);

      if (response['success'] == true) {
        final List<dynamic> data = response['data'];

        final total = data.fold<num>(
            0, (sum, item) => sum + (item['total_calories'] ?? 0));

        consumedCalories.value = total.toInt();
      } else {
        consumedCalories.value = 0;
      }
    } catch (e) {
      consumedCalories.value = 0;
    }
  }

  /// ================= AKTIVITAS (FIX UTAMA) =================
  // Future<void> fetchActivity() async {
  //   try {
  //     final response = await api.getActivity(userId);

  //     print("RESPONSE ACTIVITY: $response");

  //     if (response['success'] == true && response['data'] != null) {
  //       final data = response['data'];

  //       // ✅ AMBIL SESUAI NAMA BACKEND
  //       aktivitasKategori.value = data['kategori'] ?? '';
  //       aktivitasSkor.value = data['skor_total'] ?? 0;

  //       menitPerHari.value = data['menit_per_hari'] ?? 0;
  //       hariPerMinggu.value = data['hari_per_minggu'] ?? 0;
  //       frekuensi.value = data['frekuensi_olahraga'] ?? 0;
  //       jenis.value = data['jenis_aktivitas'] ?? 0;
  //       detail.value = data['detail_aktivitas'] ?? 0;
  //       sedentary.value = data['sedentary_jam'] ?? 0;
  //       konsistensi.value = data['konsistensi_hari'] ?? 0;

  //       print("SET BERHASIL:");
  //       print("Kategori: ${aktivitasKategori.value}");
  //       print("Skor: ${aktivitasSkor.value}");
  //       print("Menit: ${menitPerHari.value}");
  //     } else {
  //       aktivitasKategori.value = '';
  //       aktivitasSkor.value = 0;
  //     }
  //   } catch (e) {
  //     print("ERROR FETCH ACTIVITY: $e");
  //   }
  // }
  /// ================= AKTIVITAS =================
  Future<void> fetchActivity() async {
    try {
      final response = await api.getActivity(userId);

      if (response['success'] == true &&
          response['data'] != null) {

        final data = response['data'];

        aktivitasKategori.value =
            data['kategori'] ?? '';

        generateAktivitasSubtitle();

        int raw =
            data['skor_total'] ?? 0;

        /// RANGE 5–15
        aktivitasSkor.value =
            (((raw / 15) * 10)
            .clamp(0, 10))
            .round();

        hariPerMinggu.value =
            data['hari_per_minggu'] ?? 0;

        menitPerHari.value =
            data['durasi_aktivitas'] ?? 0;

        frekuensi.value =
            data['frekuensi_olahraga'] ?? 0;

        jenis.value =
            data['intensitas_aktivitas'] ?? 0;

        detail.value =
            data['aktivitas_harian'] ?? 0;

        sedentary.value =
            data['sedentary'] ?? 0;

      } else {
        aktivitasKategori.value = '';
        aktivitasSkor.value = 0;
      }
    } catch (e) {
      print("ERROR ACTIVITY: $e");
    }
  }

  final heroInsight = ''.obs;

  void generateHeroInsight() {
    final insights = [
      "Sedikit gerak hari ini lebih baik daripada tidak sama sekali 🏃",
      "Tidur cukup = mood lebih stabil besok 😴",
      "Minum air bisa bantu fokus kamu meningkat 💧",
      "Kesehatan itu dibangun, bukan instan 🔥",
      "Progress kecil tetap progress 💪",
    ];

    insights.shuffle();
    heroInsight.value = insights.first;

    print("HERO INSIGHT = ${heroInsight.value}");
  }

 Future<void> fetchDietary() async {
  try {
    final response = await api.getDietary(userId);

    if (response['success'] == true &&
        response['data'] != null) {

      final data = response['data'];

      dietaryKategori.value =
          data['kategori'] ?? '';

      // skor asli
      dietaryRawScore.value =
          data['skor_total'] ?? 0;

      // skor normalisasi SPK
      dietarySkor.value =
          ((dietaryRawScore.value / 21) * 10)
          .round();

      frekuensiMakan.value =
          data['frekuensi_makan'] ?? 0;

      sarapan.value =
          data['sarapan'] ?? 0;

      sayurBuah.value =
          data['sayur_buah'] ?? 0;

      junkFood.value =
          data['junk_food'] ?? 0;

      minumanManis.value =
          data['minuman_manis'] ?? 0;

      airPutih.value =
          data['air_putih'] ?? 0;

      makananLengkap.value =
          data['makanan_lengkap'] ?? 0;

      generateDietarySubtitle();

      update();
    }
  } catch (e) {
    print("ERROR FETCH DIETARY: $e");
  }
}
   /// ================= STRESS (🔥 FIX UTAMA) =================
  Future<void> fetchStress() async {
    try {
      final response = await api.getStress(userId);

      if (response['success'] == true &&
          response['data'] != null) {

        final data = response['data'];

        stressKategori.value =
            data['kategori'] ?? '';

        generateStressSubtitle();

        int raw =
            data['skor_total'] ?? 0;

        /// STRESS = COST
        /// makin kecil makin bagus

        stressSkor.value =
            (10 - ((raw / 40) * 10))
            .clamp(0, 10)
            .round();

        if (stressSkor.value < 0) {
          stressSkor.value = 0;
        }

      } else {
        stressKategori.value = '';
        stressSkor.value = 0;
      }
    } catch (e) {
      print("ERROR FETCH STRESS: $e");
    }
  }

  /// ================= SLEEP =================
  Future<void> fetchSleep() async {
    try {
      final response = await api.getSleep(userId);

      if (response['success'] == true &&
          response['data'] != null) {

        final data = response['data'];

        sleepKategori.value =
            data['kategori'] ?? '';

        generateSleepSubtitle();

        int raw =
            data['skor_total'] ?? 0;

        /// RANGE 6–18
        sleepSkor.value =
            (((raw / 18) * 10)
            .clamp(0, 10))
            .round();
        durasiTidur.value =
            data['durasi_tidur'] ?? 0;

        gangguan.value =
            data['gangguan'] ?? 0;

        lamaTerbangun.value =
            data['lama_terbangun'] ?? 0;

        kualitas.value =
            data['kualitas_tidur'] ?? 0;

        keteraturan.value =
            data['keteraturan'] ?? 0;

      } else {
        sleepKategori.value = '';
        sleepSkor.value = 0;
      }
    } catch (e) {
      print("ERROR FETCH SLEEP: $e");
    }
  }

  void updateLifestyleIfReady() {
    if (isLifestyleComplete) {
      calculateLifestyleScore();
    }
  }

  //  /// ================= HITUNG FINAL =================
  // void calculateLifestyleScore() {
  //   if (!isLifestyleComplete) return;

  //   int bmiScore = mapBmiScore(kategori.value);

  //   int total = bmiScore +
  //       aktivitasSkor.value +
  //       dietarySkor.value +
  //       sleepSkor.value +
  //       stressSkor.value;

  //   lifestyleScore.value = total;

  //   if (total >= 40) {
  //     lifestyleKategori.value = "Sangat Sehat";
  //   } else if (total >= 30) {
  //     lifestyleKategori.value = "Sehat";
  //   } else if (total >= 20) {
  //     lifestyleKategori.value = "Cukup";
  //   } else {
  //     lifestyleKategori.value = "Perlu Perbaikan";
  //   }
  // }

  /// =======================================================
/// SPK LIFESTYLE SCORE
/// =======================================================

void calculateLifestyleScore() {

  if (!isLifestyleComplete) return;

  /// ================= NORMALISASI =================
  /// semua skor sudah 0–10

  double makan = dietarySkor.value.toDouble();
  double aktivitas = aktivitasSkor.value.toDouble();
  double tidur = sleepSkor.value.toDouble();
  double stress = stressSkor.value.toDouble();

  /// ================= HITUNG SPK =================

  double total =
      (makan * bobotMakan) +
      (aktivitas * bobotAktivitas) +
      (tidur * bobotTidur) +
      (stress * bobotStress);

  lifestyleScore.value = total;

  /// ================= KATEGORI =================

  if (total >= 8) {
    lifestyleKategori.value = "Sangat Seimbang";
  } else if (total >= 6) {
    lifestyleKategori.value = "Seimbang";
  } else if (total >= 4) {
    lifestyleKategori.value = "Kurang Seimbang";
  } else {
    lifestyleKategori.value = "Tidak Seimbang";
  }

  /// =====================================================
  /// KONTRIBUSI PARAMETER (SKOR × BOBOT)
  /// =====================================================

  Map<String, double> kontribusi = {

    "Pola Makan":
        makan * bobotMakan,

    "Aktivitas Fisik":
        aktivitas * bobotAktivitas,

    "Tidur":
        tidur * bobotTidur,

    "Manajemen Stress":
        stress * bobotStress,
  };

  /// CARI KONTRIBUSI TERENDAH

  String weakest =
      kontribusi.entries
        .reduce((a, b) =>
            a.value < b.value ? a : b)
        .key;
  /// =====================================================
  /// KESIMPULAN SPK
  /// =====================================================

  switch (weakest) {

    case "Pola Makan":

      lifestyleInsight.value =
          "Pola makan menjadi faktor yang paling perlu diperbaiki.";

      lifestyleRecommendation.value =
          "Perbaiki jadwal makan, kurangi junk food, dan perbanyak sayur serta air putih.";

      break;

    case "Aktivitas Fisik":

      lifestyleInsight.value =
          "Aktivitas fisik menjadi faktor utama yang masih kurang.";

      lifestyleRecommendation.value =
          "Coba tambah aktivitas ringan seperti jalan kaki atau stretching minimal 30 menit.";

      break;

    case "Tidur":

      lifestyleInsight.value =
          "Kualitas tidurmu masih belum optimal.";

      lifestyleRecommendation.value =
          "Tidur lebih teratur dan hindari begadang agar tubuh bisa recovery lebih baik.";

      break;

    case "Manajemen Stress":

      lifestyleInsight.value =
          "Stress menjadi faktor yang paling mempengaruhi lifestyle kamu.";

      lifestyleRecommendation.value =
          "Luangkan waktu relaksasi, kurangi overthinking, dan istirahat sejenak.";

      break;
  }
}

void generateBodyInsight() {
  final bmiKategori = kategori.value;
  final lifestyle = lifestyleKategori.value;

  if (bmiKategori == "Kurus") {

    if (lifestyle == "Sangat Seimbang" ||
        lifestyle == "Seimbang") {

      bodyInsight.value =
          "Status tubuhmu masih di bawah ideal, tetapi gaya hidupmu sudah cukup baik untuk membantu mencapai berat badan sehat.";

    } else {

      bodyInsight.value =
          "Status tubuhmu masih di bawah ideal dan beberapa kebiasaan harian perlu diperbaiki agar berat badan sehat lebih mudah dicapai.";
    }

  } else if (bmiKategori == "Normal") {

    if (lifestyle == "Sangat Seimbang" ||
        lifestyle == "Seimbang") {

      bodyInsight.value =
          "Status tubuhmu berada pada rentang ideal dan didukung oleh gaya hidup yang baik.";

    } else {

      bodyInsight.value =
          "Status tubuhmu masih ideal, tetapi beberapa kebiasaan perlu diperbaiki agar tetap terjaga.";
    }

  } else if (bmiKategori == "Gemuk") {

    bodyInsight.value =
        "Status tubuhmu berada di atas rentang ideal. Perbaikan gaya hidup dapat membantu menjaga berat badan.";

  } else if (bmiKategori == "Obesitas") {

    bodyInsight.value =
        "Status tubuhmu menunjukkan risiko kesehatan yang lebih tinggi sehingga perubahan gaya hidup sangat dianjurkan.";
  }
}

  int mapBmiScore(String kategori) {
    switch (kategori) {
      case "Normal":
        return 10;
      case "Kurus":
      case "Gemuk":
        return 7;
      case "Obesitas":
        return 5;
      default:
        return 0;
    }
  }

  /// ================= SUBTITLE =================
  void generateAktivitasSubtitle() {

    final kategori =
        aktivitasKategori.value.toLowerCase();

    if (kategori.contains("kurang")) {

      aktivitasSubtitle.value =
          "Yuk mulai gerak ringan hari ini 🚶";

    } else if (
        kategori.contains("cukup") ||
        kategori.contains("sedang")) {

      aktivitasSubtitle.value =
          "Tingkatkan aktivitas secara rutin 💪";

    } else if (
        kategori.contains("aktif") ||
        kategori.contains("baik") ||
        kategori.contains("tinggi")) {

      aktivitasSubtitle.value =
          "Aktivitas kamu sudah bagus 🔥";

    } else {

      aktivitasSubtitle.value =
          "Aktivitas berhasil dicatat ✨";
    }
  }
  
  void generateDietarySubtitle() {
    /// PRIORITAS: dari API
    if (dietaryRekomendasi.isNotEmpty) {
      dietarySubtitle.value = dietaryRekomendasi.first;
      return;
    }

    /// fallback
    switch (dietaryKategori.value) {
      case "Buruk":
        dietarySubtitle.value = "Coba makan lebih sehat hari ini 🥗";
        break;
      case "Cukup":
        dietarySubtitle.value = "Sudah cukup baik";
        break;
      case "Baik":
        dietarySubtitle.value = "Pertahankan pola makan";
        break;
      default:
        dietarySubtitle.value = "";
    }
  }

  void generateSleepSubtitle() {
    switch (sleepKategori.value) {
      case "Buruk":
        sleepSubtitle.value = "Yuk atur tidur lebih teratur 😴";
        break;
      case "Cukup":
        sleepSubtitle.value = "Perlu tingkatkan kualitas tidur";
        break;
      case "Baik":
        sleepSubtitle.value = "Tidur sudah optimal";
        break;
      default:
        sleepSubtitle.value = "";
    }
  }

 void generateStressSubtitle() {
  if (stressRekomendasi.isNotEmpty) {
    stressSubtitle.value = stressRekomendasi.first;
    return;
  }

  switch (stressKategori.value) {
    case "Tinggi":
      stressSubtitle.value = "Tenangkan pikiran sebentar 🌿";
      break;
    case "Sedang":
      stressSubtitle.value = "Coba relaksasi & kurangi beban";
      break;
    case "Rendah":
      stressSubtitle.value = "Stres masih terkendali";
      break;
    case "Normal":
      stressSubtitle.value = "Kondisi mental stabil";
      break;
    default:
      stressSubtitle.value = "";
  }
}

/// ================== TARGET HARIAN (WHO BASED) ==================

  /// 🎯 TARGET AKTIVITAS (150 menit/minggu)
  int get targetAktivitas {

    /// BELUM ISI
    if (aktivitasKategori.value.isEmpty) return 0;

    int totalMenit =
        menitPerHari.value * hariPerMinggu.value;

    if (totalMenit >= 150) return 10;
    if (totalMenit >= 90) return 7;
    if (totalMenit >= 30) return 4;

    return 1;
  }

  /// 😴 TARGET TIDUR (7-9 jam)
  int get targetTidur {

    if (sleepKategori.value.isEmpty) return 0;

    if (durasiTidur.value >= 7 &&
        durasiTidur.value <= 9) {
      return 10;
    }

    if (durasiTidur.value >= 6) return 7;
    if (durasiTidur.value >= 5) return 4;

    return 1;
  }

  /// 💧 TARGET AIR (8 gelas)
  int get targetAir {

    if (dietaryKategori.value.isEmpty) return 0;

    if (airPutih.value >= 8) return 10;
    if (airPutih.value >= 6) return 7;
    if (airPutih.value >= 4) return 4;

    return 1;
  }

  /// 😌 TARGET STRES
  int get targetStres {

    if (stressKategori.value.isEmpty) return 0;

    if (stressSkor.value >= 8) return 10;
    if (stressSkor.value >= 6) return 7;
    if (stressSkor.value >= 4) return 4;

    return 1;
  }

  /// 🎯 PERSENTASE TARGET TOTAL
  
  double get lifestyleTargetScore {

    double aktivitas =
        targetAktivitas * 0.20;

    double tidur =
        targetTidur * 0.30;

    double makan =
        targetAir * 0.15;

    double stress =
        targetStres * 0.35;

    double total =
        aktivitas +
        tidur +
        makan +
        stress;

    return (total / 10) * 100;
  }

  bool get isAnyTrackingFilledToday {
    return aktivitasKategori.value.isNotEmpty ||
        dietaryKategori.value.isNotEmpty ||
        sleepKategori.value.isNotEmpty ||
        stressKategori.value.isNotEmpty;
  }

  Future<void> fetchToday() async {
    final data = await api.getToday(userId);

    todayAktivitas.value = data['aktivitas'] ?? 0;
    todayDiet.value = data['diet'] ?? 0;
    todayTidur.value = data['tidur'] ?? 0;
    todayStres.value = data['stres'] ?? 0;
  }

  Future<void> fetchHistory() async {
    try {
      final response = await api.getHistory(userId);

      if (response['success'] == true) {
        historyList.value = response['data'];
      }
    } catch (e) {
      print("ERROR HISTORY: $e");
    }
  }

/// ================== DAILY GUIDE ==================
final dailyGuides = <String>[].obs;

void generateDailyGuides() {

  dailyGuides.clear();

  /// RULE 1
  if (kategori.value == "Kurus" &&
      sleepKategori.value == "Buruk") {

    dailyGuides.add(
      "😴 Tidur 7-9 jam setiap malam"
    );

    dailyGuides.add(
      "🥗 Tambahkan makanan bergizi tinggi protein"
    );

    return;
  }

  /// RULE 2
  if (kategori.value == "Obesitas" &&
      aktivitasKategori.value == "Kurang Aktif") {

    dailyGuides.add(
      "🚶 Jalan kaki 20-30 menit"
    );

    dailyGuides.add(
      "🥤 Kurangi minuman manis"
    );

    return;
  }

  /// RULE 3
  if (stressKategori.value == "Tinggi" &&
      sleepKategori.value == "Buruk") {

    dailyGuides.add(
      "🧘 Lakukan latihan napas 5 menit"
    );

    dailyGuides.add(
      "📱 Hindari gadget sebelum tidur"
    );

    return;
  }

  dailyGuides.add(
      "🔥 Pertahankan kebiasaan sehatmu");
}

// double get lifestyleTargetScore {
//   final aktivitas = targetAktivitas; // 0–10
//   final tidur = targetTidur;         // 0–10
//   final air = targetAir;             // 0–10
//   final stress = targetStres;        // 0–10

//   return ((aktivitas + tidur + air + stress) / 40) * 100;
// }

// double get guideProgress {
//   if (dailyGuides.isEmpty) return 0;

//   int done = dailyGuides.where((e) => e.isDone.value).length;
//   return (done / dailyGuides.length) * 100;
// }
  
}