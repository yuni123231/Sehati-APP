import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/providers/api_services.dart';
import '../../home/controllers/home_controller.dart';
import '../../progres/controllers/progres_controller.dart';

class AddActivityController extends GetxController {

  final api = ApiServices();
  final box = GetStorage();

  /// ================= INPUT =================

  var durasiAktivitas = 0.obs;
  var intensitasAktivitas = 0.obs;
  var sedentary = 0.obs;
  var frekuensiMingguan = 0.obs;

  /// ================= OUTPUT =================

  var kategori = "".obs;
  var skorTotal = 0.obs;
  var insight = "".obs;
  var rekomendasi = <String>[].obs;

  /// ================= GET USER =================

  int getUserId() => box.read('userId') ?? 0;

  /// ================= HITUNG =================

  Future<void> hitungDanSimpan() async {

    int userId = getUserId();

    if (userId == 0) {
      Get.snackbar(
        "Error",
        "User belum login",
      );
      return;
    }

    /// VALIDASI

    if (durasiAktivitas.value == 0 ||
        intensitasAktivitas.value == 0 ||
        sedentary.value == 0) {

      Get.snackbar(
        "Error",
        "Semua pertanyaan wajib diisi",
      );

      return;
    }

    /// ================= SKOR =================

    int total =
        durasiAktivitas.value +
        intensitasAktivitas.value +
        sedentary.value +
        frekuensiMingguan.value;

    skorTotal.value = total;

    /// ================= KATEGORI =================

    if (total >= 9) {
      kategori.value = "Aktif (Baik)";
    }
    else if (total >= 6) {
      kategori.value = "Cukup Aktif";
    }
    else {
      kategori.value = "Kurang Aktif";
    }

    generateRekomendasi();
    generateInsight();

    /// ================= SAVE API =================

    final result = await api.saveActivity(
      userId: userId,

      durasiAktivitas: durasiAktivitas.value,
      
      intensitasAktivitas: intensitasAktivitas.value,
      sedentary: sedentary.value,

      skorTotal: skorTotal.value,
      kategori: kategori.value,
    );

    /// ================= RESPONSE =================

    if (result['success']) {

      final home = Get.find<HomeController>();

      await home.fetchActivity();
      home.updateLifestyleIfReady();

      await home.loadAllData();

      // REFRESH REPORT
      if (Get.isRegistered<ProgresController>()) {
        final progres = Get.find<ProgresController>();
        await progres.loadProgress();
      }

      // Get.back();

    } else {

      Get.snackbar(
        "Error",
        result['message'] ?? "Gagal menyimpan",
      );

    }

  }

  /// ================= REKOMENDASI =================

  void generateRekomendasi() {

    rekomendasi.clear();

    if (kategori.value == "Aktif (Baik)") {

      rekomendasi.add(
          "Pertahankan aktivitas fisik minimal 60 menit setiap hari.");
      rekomendasi.add(
          "Lanjutkan kebiasaan mengurangi waktu duduk terlalu lama.");

    }
    else if (kategori.value == "Cukup Aktif") {

      rekomendasi.add(
          "Tambahkan durasi aktivitas fisik setiap hari.");
      rekomendasi.add(
          "Kurangi waktu sedentary seperti bermain HP atau duduk terlalu lama.");
      rekomendasi.add(
          "Lakukan olahraga intensitas sedang minimal 5 hari dalam seminggu.");

    }
    else {

      rekomendasi.add(
          "Usahakan aktif bergerak minimal 60 menit setiap hari.");
      rekomendasi.add(
          "Kurangi waktu duduk atau rebahan terlalu lama.");
      rekomendasi.add(
          "Tambahkan aktivitas fisik intensitas sedang hingga berat.");
      rekomendasi.add(
          "Buat jadwal olahraga yang konsisten.");

    }

  }
  /// ================= INSIGHT =================

  void generateInsight() {

    if (kategori.value == "Aktif (Baik)") {

      insight.value =
          "Aktivitas fisikmu sudah baik dan mendukung kesehatan tubuh. Pertahankan kebiasaan ini.";

    }
    else if (kategori.value == "Cukup Aktif") {

      insight.value =
          "Aktivitas fisikmu sudah cukup baik, tetapi masih dapat ditingkatkan agar lebih optimal.";

    }
    else {

      insight.value =
          "Aktivitas fisikmu masih kurang dan perlu diperbaiki agar kesehatan tubuh tetap terjaga.";

    }

  }

}