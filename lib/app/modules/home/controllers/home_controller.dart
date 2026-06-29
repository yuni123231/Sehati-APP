import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_services.dart';

class HomeController extends GetxController {
  final ApiServices api = ApiServices();
  final box = GetStorage();

  RxBool hasNotif = false.obs;

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
  final stressRawScore = 0.obs;

  final frekuensiStres = 0.obs;
  final tingkatStres = 0.obs;
  final emosi = 0.obs;
  final gangguanTidur = 0.obs;
  final copingStres = 0.obs;
  final relaksasi = 0.obs;

  /// ================== SLEEP ==================
  final sleepKategori = ''.obs;
  final sleepSkor = 0.obs;
  final sleepRawScore = 0.obs;

  final durasiTidur = 0.obs;
  final gangguan = 0.obs;
  final lamaTerbangun = 0.obs;
  final kualitas = 0.obs;
  final keteraturan = 0.obs;
  final mengantukSiang = 0.obs;
  final latensiTidur = 0.obs;
  final jadwalTidur = 0.obs;

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

  static const double bobotMakan = 0.25;
  static const double bobotAktivitas = 0.143;
  static const double bobotTidur = 0.25;
  static const double bobotStress = 0.357;

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

    if (score >= 7.0) {
      return "Seimbang";
    } else if (score >= 5.5) {
      return "Cukup Seimbang";
    } else {
      return "Perlu Perbaikan";
    }
  }

  /// =========================================================
  /// STATUS UI
  /// =========================================================

  String get sawStatus {
    final score = sawLifestyleScore;

    if (score >= 7.0) {
      return "Gaya hidup kamu sudah seimbang ✨";
    } else if (score >= 5.5) {
      return "Gaya hidup kamu cukup baik, tetapi masih ada beberapa aspek yang perlu ditingkatkan 🌱";
    } else {
      return "Perlu perbaikan pada beberapa kebiasaan harian ⚠️";
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
  final weakestParameter = ''.obs;

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
    
    loadAllData();
  }

  Future<void> loadAllData() async {

    await fetchUserProfile();

    await fetchConsumedCalories();

    await fetchActivity();
    await fetchDietary();
    await fetchStress();
    await fetchSleep();

    await fetchToday();
    await fetchHistory();

    // calculateLifestyleScore();

    generateBodyInsight();
    generateHeroInsight();
    generateDailyGuides();

    print("Sedentary  : ${sedentary.value}");

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

  /// ================= AKTIVITAS =================
  Future<void> fetchActivity() async {
    try {
      final response = await api.getActivity(userId);

      print("===== RESPONSE ACTIVITY =====");
      print(response);

      if (response['success'] == true &&
          response['data'] != null) {

        final data = response['data'];

        print("===== DATA ACTIVITY =====");
        print(data);

        /// ================= KATEGORI =================
        aktivitasKategori.value =
            data['kategori']?.toString() ?? '';

        generateAktivitasSubtitle();

        /// ================= SKOR =================
        // int rawScore =
        //     (data['skor_total'] ?? 0) as int;
        int rawScore =
            int.tryParse( (data['skor_total'] ?? 0).toString()) ?? 0;
            
        // aktivitasSkor.value =
        //     (((rawScore / 15) * 10)
        //             .clamp(0, 10))
        //         .round();
        aktivitasSkor.value =
            (((rawScore / 15) * 10)
                .clamp(0, 10))
                .toInt();

        /// ================= DETAIL =================

        // Durasi aktivitas
        menitPerHari.value =
            (data['durasi_aktivitas'] ??
                    data['durasi'] ??
                    0)
                .toInt();

        // Frekuensi olahraga per minggu
        frekuensi.value =
            (data['frekuensi_mingguan'] ??
                    data['frekuensi'] ??
                    data['hari_per_minggu'] ??
                    0)
                .toInt();

        // Intensitas
        jenis.value =
            (data['intensitas_aktivitas'] ??
                    data['intensitas'] ??
                    0)
                .toInt();

        // Sedentary
        sedentary.value =
            (data['sedentary'] ??
                    data['sedentary_jam'] ??
                    0)
                .toInt();

        // Konsistensi
        konsistensi.value =
            frekuensi.value;

        print("===== HASIL SET =====");
        print("Kategori   : ${aktivitasKategori.value}");
        print("Skor       : ${aktivitasSkor.value}");
        print("Durasi     : ${menitPerHari.value}");
        print("Frekuensi  : ${frekuensi.value}");
        print("Intensitas : ${jenis.value}");
        print("Sedentary  : ${sedentary.value}");

        update();

      } else {

        aktivitasKategori.value = "";
        aktivitasSkor.value = 0;

        menitPerHari.value = 0;
        frekuensi.value = 0;
        jenis.value = 0;
        sedentary.value = 0;
        konsistensi.value = 0;

        update();
      }

    } catch (e) {
      print("ERROR FETCH ACTIVITY : $e");
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
    print(response);

    if (response['success'] == true &&
        response['data'] != null) {

      final data = response['data'];
      print(data);

      dietaryKategori.value =
          data['kategori'] ?? '';

      // skor asli
      dietaryRawScore.value =
          data['skor_total'] ?? 0;

      // skor normalisasi SPK
      dietarySkor.value =
          ((dietaryRawScore.value / 21) * 10)
          .toInt();

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

        stressRawScore.value =
            int.tryParse(
              (data['skor_total'] ?? 0).toString(),
            ) ?? 0;

        /// STRESS = COST
        /// makin kecil makin bagus

        stressSkor.value =
          (10 - ((stressRawScore.value / 40) * 10))
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
      print("USER ID FETCH SLEEP : $userId");

      final response = await api.getSleep(userId);

      print(response);

      if (response['success'] == true &&
          response['data'] != null) {

        final data = response['data'];

        /// ==========================
        /// DATA DETAIL
        /// ==========================

        sleepKategori.value =
            data['kategori']?.toString() ?? "";

        durasiTidur.value =
            (data['durasi_tidur'] ?? 0).toInt();

        gangguan.value =
            (data['gangguan'] ?? 0).toInt();

        kualitas.value =
            (data['kualitas_tidur'] ?? 0).toInt();

        lamaTerbangun.value =
            (data['lama_terbangun'] ?? 0).toInt();

        mengantukSiang.value =
            (data['mengantuk_siang'] ?? 0).toInt();

        latensiTidur.value =
            (data['latensi_tidur'] ?? 0).toInt();

        jadwalTidur.value =
            (data['jadwal_tidur'] ?? 0).toInt();

        /// ==========================
        /// SKOR SAW
        /// ==========================

        // switch (sleepKategori.value) {

        //   case "Sangat Baik":
        //     sleepSkor.value = 10;
        //     break;

        //   case "Cukup":
        //     sleepSkor.value = 6;
        //     break;

        //   case "Buruk":
        //     sleepSkor.value = 2;
        //     break;

        //   default:
        //     sleepSkor.value = 0;
        // }
        sleepRawScore.value =
            int.tryParse(
              (data['skor_total'] ?? 0).toString(),
            ) ?? 0;

        sleepSkor.value =
          (10 - ((sleepRawScore.value / 21) * 10))
              .clamp(0, 10)
              .round();

        print("========== HASIL HOME ==========");
        print("Kategori : ${sleepKategori.value}");
        print("Skor : ${sleepSkor.value}");
        print("Durasi : ${durasiTidur.value}");
        print("Gangguan : ${gangguan.value}");
        print("Kualitas : ${kualitas.value}");
        print("Terbangun : ${lamaTerbangun.value}");
        print("Mengantuk : ${mengantukSiang.value}");
        print("Latensi : ${latensiTidur.value}");
        print("Jadwal : ${jadwalTidur.value}");

        generateSleepSubtitle();

        update();

      } else {

        sleepKategori.value = "";
        sleepSkor.value = 0;

        durasiTidur.value = 0;
        gangguan.value = 0;
        kualitas.value = 0;
        lamaTerbangun.value = 0;
        mengantukSiang.value = 0;
        latensiTidur.value = 0;
        jadwalTidur.value = 0;

        update();
      }

    } catch (e) {
      print("ERROR FETCH SLEEP : $e");
    }
  }

  void updateLifestyleIfReady() {
    if (isLifestyleComplete) {
      calculateLifestyleScore();
    }
  }

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

    if (total >= 7.0) {
      lifestyleKategori.value = "Seimbang";
    } else if (total >= 5.5) {
      lifestyleKategori.value = "Cukup Seimbang";
    } else {
      lifestyleKategori.value = "Perlu Perbaikan";
    }

  /// =====================================================
  /// KONTRIBUSI PARAMETER (SKOR × BOBOT)
  /// =====================================================

  Map<String, double> skor = {

    "Pola Makan":
        makan,

    "Aktivitas Fisik":
        aktivitas,

    "Tidur":
        tidur,

    "Manajemen Stress":
        stress,
  };

  String weakest =
      skor.entries
        .reduce((a, b) =>
            a.value < b.value ? a : b)
        .key;

  weakestParameter.value = weakest;
  
  generateBodyInsight();
  /// =====================================================
  /// KESIMPULAN SPK
  /// =====================================================

  switch (weakest) {

    case "Pola Makan":

      lifestyleInsight.value =
          "Pola makan menjadi faktor yang paling perlu diperbaiki.";

      lifestyleRecommendation.value =
          "Usahakan makan teratur, perbanyak konsumsi sayur dan buah, serta batasi makanan cepat saji.";

      break;

    case "Aktivitas Fisik":

      lifestyleInsight.value =
          "Aktivitas fisik masih menjadi aspek yang paling memerlukan perhatian.";

      lifestyleRecommendation.value =
          "Tingkatkan aktivitas fisik ringan seperti berjalan kaki atau olahraga minimal 30 menit setiap hari.";

      break;

    case "Tidur":

      lifestyleInsight.value =
          "Kualitas tidur masih perlu diperbaiki untuk mendukung kesehatan secara keseluruhan.";

      lifestyleRecommendation.value =
          "Tidur 7-9 jam setiap malam, hindari begadang, dan batasi penggunaan gadget sebelum tidur.";

      break;

    case "Manajemen Stress":

      lifestyleInsight.value =
          "Manajemen stres merupakan aspek yang paling perlu ditingkatkan berdasarkan hasil evaluasi.";

      lifestyleRecommendation.value =
          "Luangkan waktu relaksasi, kurangi overthinking, dan istirahat sejenak.";

      break;
  }

  print("===== SAW =====");
  print("Aktivitas : $aktivitas");
  print("Makan     : $makan");
  print("Tidur     : $tidur");
  print("Stress    : $stress");
  print("Total     : $total");
  print("Kategori  : ${lifestyleKategori.value}");
  print("================");
}

  void generateBodyInsight() {

    /// BMI NORMAL
    if (kategori.value == "Normal") {

      if (lifestyleKategori.value == "Seimbang") {

        bodyInsight.value =
            "Berat badan kamu berada pada kondisi ideal dan kebiasaan harianmu sudah mendukung kesehatan. Pertahankan pola makan, aktivitas, tidur, dan pengelolaan stres yang baik.";

      } else if (lifestyleKategori.value == "Cukup Seimbang") {

        bodyInsight.value =
            "Berat badan kamu masih dalam kondisi ideal. Namun, beberapa kebiasaan harian masih bisa ditingkatkan agar kesehatan tubuh tetap optimal.";

      } else {

        bodyInsight.value =
            "Berat badan kamu masih ideal, tetapi ada kebiasaan harian yang perlu diperbaiki. Mulai dari perubahan kecil seperti lebih aktif bergerak, makan lebih seimbang, atau memperbaiki waktu istirahat.";
      }
    }


    /// BMI KURUS
    else if (kategori.value == "Kurus") {

      if (lifestyleKategori.value == "Seimbang") {

        bodyInsight.value =
            "Berat badan kamu masih di bawah ideal, tetapi kebiasaan hidup sudah cukup baik. Fokuskan pada asupan makanan bergizi untuk membantu mencapai berat badan yang lebih sehat.";

      } else {

        bodyInsight.value =
            "Berat badan kamu masih di bawah ideal dan beberapa kebiasaan harian perlu diperbaiki. Perhatikan asupan makanan, pola tidur, dan aktivitas agar tubuh lebih sehat.";
      }
    }


    /// BMI GEMUK
    else if (kategori.value == "Gemuk") {

      if (lifestyleKategori.value == "Seimbang") {

        bodyInsight.value =
            "Berat badan kamu berada di atas ideal, tetapi kebiasaan hidup sudah cukup baik. Pertahankan pola makan dan aktivitas agar berat badan tetap terkontrol.";

      } else {

        bodyInsight.value =
            "Berat badan kamu berada di atas ideal dan ada kebiasaan yang perlu diperbaiki. Tingkatkan aktivitas fisik dan mulai pilih makanan yang lebih seimbang.";
      }
    }


    /// BMI OBESITAS
    else if (kategori.value == "Obesitas") {

      if (lifestyleKategori.value == "Seimbang") {

        bodyInsight.value =
            "Kebiasaan harian kamu sudah cukup baik, namun berat badan masih perlu diperhatikan. Tetap pantau pola makan dan aktivitas fisik secara rutin.";

      } else {

        bodyInsight.value =
            "Kondisi berat badan kamu membutuhkan perhatian lebih. Mulai perbaiki kebiasaan harian secara bertahap, terutama aktivitas fisik, pola makan, dan kualitas tidur.";
      }
    }


    /// DEFAULT
    else {

      bodyInsight.value =
          "Lengkapi data kesehatanmu untuk mendapatkan insight kondisi tubuh.";
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
    if (dietaryRekomendasi.isNotEmpty) {
      dietarySubtitle.value = dietaryRekomendasi.first;
      return;
    }

    switch (dietaryKategori.value) {
      case "Buruk":
        dietarySubtitle.value =
            "Coba makan lebih sehat hari ini 🥗";
        break;

      case "Cukup":
        dietarySubtitle.value =
            "Sudah cukup baik 👍";
        break;

      case "Baik":
      case "Sangat Baik":
        dietarySubtitle.value =
            "Pertahankan pola makan sehat 🔥";
        break;

      default:
        dietarySubtitle.value =
            "Kondisimu bagus hari ini 🌟";
    }
  }

  void generateSleepSubtitle() {
    switch (sleepKategori.value) {
      case "Buruk":
        sleepSubtitle.value =
            "Yuk atur tidur lebih teratur 😴";
        break;

      case "Cukup":
        sleepSubtitle.value =
            "Perlu tingkatkan kualitas tidur";
        break;

      case "Sangat Baik":
        sleepSubtitle.value =
            "Pertahankan pola tidur sehat 🌙";
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
        menitPerHari.value *
        (konsistensi.value == 0
            ? 1
            : konsistensi.value);

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
    targetAktivitas * bobotAktivitas;

    double tidur =
        targetTidur * bobotTidur;

    double makan =
        targetAir * bobotMakan;

    double stress =
        targetStres * bobotStress;

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

// Future<void> fetchToday() async {

//   final data = await api.getToday(userId);


//   todayAktivitas.value =
//       (data['aktivitas'] ?? 0).toInt();

//   todayDiet.value =
//       (data['diet'] ?? 0).toInt();

//   todayTidur.value =
//       (data['tidur'] ?? 0).toInt();

//   todayStres.value =
//       (data['stres'] ?? 0).toInt();

// }

Future<void> fetchToday() async {

  final data = await api.getTodayReport(userId);


  if(data['success']==true){

    lifestyleScore.value =
        (data['score'] ?? 0).toDouble();


    lifestyleKategori.value =
        data['status'] ?? "";


    lifestyleInsight.value =
        data['conclusion'] ?? "";

  }

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

}