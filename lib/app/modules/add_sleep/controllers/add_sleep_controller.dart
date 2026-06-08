import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_services.dart';
import '../../home/controllers/home_controller.dart';

class AddSleepController extends GetxController {

  /// ================== STATE ==================
  var q1 = 0.obs; // durasi tidur
  var q2 = 0.obs; // gangguan
  var q3 = 0.obs; // lama terbangun
  var q4 = 0.obs; // kualitas tidur
  var q5 = 0.obs; // keteraturan

  var kategori = "".obs;
  var rekomendasi = <String>[].obs;
  var insight = "".obs;
  var skor = 0.obs;

  final api = ApiServices();
  final box = GetStorage();

  /// ================== RESET FORM ==================
  @override
  void onInit() {
    super.onInit();
    resetForm();
  }

  void resetForm() {
    q1.value = 0;
    q2.value = 0;
    q3.value = 0;
    q4.value = 0;
    q5.value = 0;

    kategori.value = "";
    rekomendasi.clear();
    insight.value = "";
    skor.value = 0;
  }

  /// ================== HITUNG SKOR (PSQI ADAPTASI) ==================
  void hitungSkor() {

    if (q1.value == 0 ||
        q2.value == 0 ||
        q3.value == 0 ||
        q4.value == 0 ||
        q5.value == 0) {

      Get.snackbar("Error", "Semua pertanyaan harus diisi");
      return;
    }

    /// 🔥 PSQI → makin besar = makin buruk
    int total = (4 - q1.value) +
        (4 - q2.value) +
        (4 - q3.value) +
        (4 - q4.value) +
        (4 - q5.value);

    skor.value = total;

    /// ================== KATEGORI ==================
    if (total <= 4) {
      kategori.value = "Baik";
    } else if (total <= 7) {
      kategori.value = "Cukup";
    } else {
      kategori.value = "Buruk";
    }

    generateRekomendasi();
    generateInsight();
  }

  /// ================== REKOMENDASI ==================
  void generateRekomendasi() {
    rekomendasi.clear();

    if (kategori.value == "Buruk") {
      rekomendasi.add("Tidur 7–9 jam per hari");
      rekomendasi.add("Hindari gadget sebelum tidur");
      rekomendasi.add("Kurangi kafein di malam hari");
      rekomendasi.add("Buat jadwal tidur konsisten");
    } 
    else if (kategori.value == "Cukup") {
      rekomendasi.add("Perbaiki konsistensi tidur");
      rekomendasi.add("Kurangi gangguan saat tidur");
      rekomendasi.add("Coba relaksasi sebelum tidur");
    } 
    else {
      rekomendasi.add("Pertahankan pola tidur sehat");
    }
  }

  /// ================== INSIGHT ==================
  void generateInsight() {
    if (kategori.value == "Buruk") {
      insight.value =
          "Kualitas tidur Anda rendah dan perlu diperbaiki.";
    } 
    else if (kategori.value == "Cukup") {
      insight.value =
          "Tidur cukup, namun masih bisa ditingkatkan.";
    } 
    else {
      insight.value =
          "Kualitas tidur Anda sudah baik.";
    }
  }

  /// ================== SAVE ==================
  Future<void> saveSleepData() async {

    int userId = box.read('userId') ?? 0;

    if (userId == 0) {
      Get.snackbar("Error", "User belum login");
      return;
    }

    final result = await api.saveSleep(
      userId: userId,
      durasi: q1.value,
      gangguan: q2.value,
      terbangun: q3.value,
      kualitas: q4.value,
      keteraturan: q5.value,
      skorTotal: skor.value,
      kategori: kategori.value,
    );

    if (result['success']) {

      Get.snackbar("Sukses", "Data tidur berhasil disimpan");

      final home = Get.find<HomeController>();
      await home.fetchSleep();
      home.updateLifestyleIfReady();

      Get.back();

    } else {
      Get.snackbar("Error", result['message'] ?? "Gagal menyimpan data");
    }
  }
}