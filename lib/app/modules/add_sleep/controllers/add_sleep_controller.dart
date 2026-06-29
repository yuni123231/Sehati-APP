import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_services.dart';
import '../../home/controllers/home_controller.dart';
import '../../progres/controllers/progres_controller.dart';

class AddSleepController extends GetxController {

  /// ================== STATE ==================
  var q1 = 0.obs;
  var q2 = 0.obs;
  var q3 = 0.obs;
  var q4 = 0.obs;
  var q5 = 0.obs;
  var q6 = 0.obs;
  var q7 = 0.obs;

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
    q6.value = 0;
    q7.value = 0;

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
        q5.value == 0 ||
        q6.value == 0 ||
        q7.value == 0) {

      Get.snackbar("Error", "Semua pertanyaan harus diisi");
      return;
    }

    /// 🔥 PSQI → makin besar = makin buruk
    int total =
        q1.value +
        q2.value +
        q3.value +
        q4.value +
        q5.value +
        q6.value +
        q7.value;

    skor.value = total;

    /// ================== KATEGORI ==================
    if (total >= 16) {
      kategori.value = "Buruk";
    } else if (total >= 11) {
      kategori.value = "Cukup";
    } else if (total >= 7) {
      kategori.value = "Sangat Baik";
    }

    print("===== HITUNG SLEEP =====");
    print("Q1 : ${q1.value}");
    print("Q2 : ${q2.value}");
    print("Q3 : ${q3.value}");
    print("Q4 : ${q4.value}");
    print("Q5 : ${q5.value}");
    print("Q6 : ${q6.value}");
    print("Q7 : ${q7.value}");
    print("TOTAL : $total");
    print("KATEGORI : ${kategori.value}");
    print("========================");

    generateRekomendasi();
    generateInsight();
  }

  /// ================== REKOMENDASI ==================
  void generateRekomendasi() {
    rekomendasi.clear();

    if (kategori.value == "Buruk") {
      rekomendasi.add("Tidur 7–9 jam setiap malam");
      rekomendasi.add("Kurangi penggunaan gadget sebelum tidur");
      rekomendasi.add("Hindari kafein pada malam hari");
      rekomendasi.add("Buat jadwal tidur yang konsisten");
      rekomendasi.add("Lakukan relaksasi sebelum tidur");
    } 
    else if (kategori.value == "Cukup") {
      rekomendasi.add("Pertahankan pola tidur yang sudah baik");
      rekomendasi.add("Usahakan tidur dan bangun pada jam yang sama");
      rekomendasi.add("Kurangi gangguan saat tidur");
    } 
    else {
      rekomendasi.add("Pola tidur Anda sangat baik");
      rekomendasi.add("Pertahankan kebiasaan tidur sehat");
    }
  }

  /// ================== INSIGHT ==================
  void generateInsight() {

    if (kategori.value == "Buruk") {
      insight.value =
          "Pola tidur Anda kurang baik dan perlu diperbaiki agar kesehatan dan konsentrasi tetap optimal.";
    } 
    else if (kategori.value == "Cukup") {
      insight.value =
          "Pola tidur Anda cukup baik, namun masih ada beberapa aspek yang dapat ditingkatkan.";
    } 
    else {
      insight.value =
          "Pola tidur Anda sangat baik dan mendukung kesehatan fisik maupun mental.";
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
      kualitas: q3.value,
      terbangun: q4.value,
      mengantuk: q5.value,
      latensi: q6.value,
      jadwal: q7.value,
      skorTotal: skor.value,
      kategori: kategori.value,
    );

    if (result['success']) {

      Get.snackbar("Sukses", "Data tidur berhasil disimpan");

      print("===== DATA KIRIM =====");
      print("Skor : ${skor.value}");
      print("Kategori : ${kategori.value}");
      print("======================");

      final home = Get.find<HomeController>();
      await home.fetchSleep();
      home.updateLifestyleIfReady();

      // REFRESH REPORT
      if (Get.isRegistered<ProgresController>()) {
        final progres = Get.find<ProgresController>();
        await progres.loadProgress();
      }

      Get.back();

    } else {
      Get.snackbar("Error", result['message'] ?? "Gagal menyimpan data");
    }
  }
}