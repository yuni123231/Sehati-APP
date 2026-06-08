import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_services.dart';
import '../../home/controllers/home_controller.dart';

class AddDietaryHabitController extends GetxController {
  final api = ApiServices();
  final box = GetStorage();

  /// ================= INPUT =================
  var q1 = 0.obs; // frekuensi makan
  var q2 = 0.obs; // sarapan
  var q3 = 0.obs; // sayur buah
  var q4 = 0.obs; // junk food (NEGATIF)
  var q5 = 0.obs; // minuman manis (NEGATIF)
  var q6 = 0.obs; // air putih
  var q7 = 0.obs; //keberagaman makanan

  /// ================= OUTPUT =================
  var kategori = "".obs;
  var rekomendasi = <String>[].obs;
  var skor = 0.obs;

  int getUserId() => box.read('userId') ?? 0;

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
    q6.value = 0;
    q7.value = 0;

    kategori.value = "";
    rekomendasi.clear();
    skor.value = 0;
  }

  /// ================= HITUNG =================
  Future<void> hitungDanSimpan() async {
    int userId = getUserId();

    if (userId == 0) {
      Get.snackbar("Error", "User belum login");
      return;
    }

    if (q1.value == 0 ||
        q2.value == 0 ||
        q3.value == 0 ||
        q4.value == 0 ||
        q5.value == 0 ||
        q6.value == 0 ||
        q7.value == 0) {
      Get.snackbar("Error", "Semua pertanyaan harus diisi");
      return;
    }

    /// 🔥 SCORING ILMIAH
    int total =
    q1.value +
    q2.value +
    q3.value +
    q4.value +
    q5.value +
    q6.value +
    q7.value;
    skor.value = total;

    /// 🔥 KATEGORI (adaptasi WHO)
    if (total >= 18) {
      kategori.value = "Baik";
    } else if (total >= 12) {
      kategori.value = "Cukup";
    } else {
      kategori.value = "Buruk";
    }

    generateRekomendasi();

    /// ================= SAVE =================
    final result = await api.saveDietary(
      userId: userId,
      frekuensiMakan: q1.value,
      sarapan: q2.value,
      sayurBuah: q3.value,
      junkFood: q4.value,
      minumanManis: q5.value,
      airPutih: q6.value,
      makananLengkap: q7.value,
      skorTotal: skor.value,
      kategori: kategori.value,
    );

    if (result['success']) {
      Get.snackbar("Sukses", "Data pola makan tersimpan");

      final home = Get.find<HomeController>();
      await home.fetchDietary();
      home.updateLifestyleIfReady();

      Get.back();
    } else {
      Get.snackbar("Error", result['message'] ?? "Gagal");
    }
  }

  /// ================= REKOMENDASI =================
  void generateRekomendasi() {
    rekomendasi.clear();

    if (q1.value < 3) {
      rekomendasi.add("Biasakan makan utama 3x sehari");
    }

    if (q2.value < 3) {
      rekomendasi.add("Sarapan penting untuk energi harian");
    }

    if (q3.value < 3) {
      rekomendasi.add("Konsumsi ≥5 porsi sayur & buah/hari");
    }

    if (q4.value > 1) {
      rekomendasi.add("Kurangi fast food & makanan tinggi lemak");
    }

    if (q5.value > 1) {
      rekomendasi.add("Batasi gula <50 gram/hari (WHO)");
    }

    if (q6.value < 3) {
      rekomendasi.add("Minum air putih minimal 8 gelas/hari");
    }

    if (rekomendasi.isEmpty) {
      rekomendasi.add("Pola makan sudah optimal 👍");
    }
  }
}