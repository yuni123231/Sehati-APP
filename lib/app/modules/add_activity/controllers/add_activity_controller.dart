import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/providers/api_services.dart';
import '../../home/controllers/home_controller.dart';

class AddActivityController extends GetxController {
  final api = ApiServices();
  final box = GetStorage();

  /// ================= INPUT =================

  /// 1. Durasi aktivitas
  var durasiAktivitas = 0.obs;

  /// 2. Frekuensi olahraga
  var frekuensiOlahraga = 0.obs;

  /// 3. Intensitas
  var intensitasAktivitas = 0.obs;

  /// 4. Aktivitas harian
  var aktivitasHarian = 0.obs;

  /// 5. Sedentary
  var sedentary = 0.obs;

  /// ================= OUTPUT =================
  var kategori = "".obs;
  var skorTotal = 0.obs;

  var rekomendasi = <String>[].obs;

  /// ================= GET USER =================
  int getUserId() => box.read('userId') ?? 0;

  /// ================= HITUNG =================
  Future<void> hitungDanSimpan() async {
    int userId = getUserId();

    if (userId == 0) {
      Get.snackbar("Error", "User belum login");
      return;
    }

    /// VALIDASI
    if (durasiAktivitas.value == 0 ||
        frekuensiOlahraga.value == 0 ||
        intensitasAktivitas.value == 0 ||
        aktivitasHarian.value == 0 ||
        sedentary.value == 0) {
      Get.snackbar("Error", "Semua pertanyaan wajib diisi");
      return;
    }

    /// ================= TOTAL SKOR =================
    int total =
        durasiAktivitas.value +
        frekuensiOlahraga.value +
        intensitasAktivitas.value +
        aktivitasHarian.value +
        sedentary.value;

    skorTotal.value = total;

    /// ================= KATEGORI =================
    if (total >= 13) {
      kategori.value = "Aktif (Baik)";
    } else if (total >= 9) {
      kategori.value = "Cukup Aktif";
    } else {
      kategori.value = "Kurang Aktif";
    }

    /// ================= REKOMENDASI =================
    rekomendasi.clear();

    if (kategori.value == "Aktif (Baik)") {
      rekomendasi.add("Aktivitas fisik kamu sudah sangat baik 👍");
      rekomendasi.add("Pertahankan pola hidup aktif setiap hari");
      rekomendasi.add("Tetap imbangi dengan tidur dan nutrisi yang cukup");
    }

    else if (kategori.value == "Cukup Aktif") {
      rekomendasi.add("Aktivitas kamu cukup baik, tapi masih bisa ditingkatkan");
      rekomendasi.add("Coba tambah durasi olahraga hingga 60 menit/hari");
      rekomendasi.add("Kurangi terlalu lama duduk atau rebahan");
    }

    else {
      rekomendasi.add("Aktivitas fisik kamu masih kurang");
      rekomendasi.add("Mulai biasakan bergerak minimal 30 menit/hari");
      rekomendasi.add("Kurangi waktu duduk terlalu lama");
      rekomendasi.add("Coba olahraga ringan seperti jalan kaki atau stretching");
    }

    /// ================= SAVE API =================
    final result = await api.saveActivity(
      userId: userId,

      durasiAktivitas: durasiAktivitas.value,
      frekuensiOlahraga: frekuensiOlahraga.value,
      intensitasAktivitas: intensitasAktivitas.value,
      aktivitasHarian: aktivitasHarian.value,
      sedentary: sedentary.value,

      skorTotal: skorTotal.value,
      kategori: kategori.value,
    );

    /// ================= RESPONSE =================
    if (result['success']) {
      final home = Get.find<HomeController>();

      await home.fetchActivity();
      home.updateLifestyleIfReady();

      Get.snackbar("Berhasil", "Data aktivitas berhasil disimpan");
    } else {
      Get.snackbar(
        "Error",
        result['message'] ?? "Gagal menyimpan",
      );
    }
  }
}