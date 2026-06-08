import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/providers/api_services.dart';
import '../../home/controllers/home_controller.dart';
import 'detail_stress_controller.dart';

class AddMoodController extends GetxController {
  final api = ApiServices();
  final box = GetStorage();

  /// ================= INPUT =================
  final q1 = (-1).obs;
  final q2 = (-1).obs;
  final q3 = (-1).obs;
  final q4 = (-1).obs;
  final q5 = (-1).obs;
  final q6 = (-1).obs;
  final q7 = (-1).obs;
  final q8 = (-1).obs;
  final q9 = (-1).obs;
  final q10 = (-1).obs;

  /// ================= OUTPUT =================
  final skor = 0.obs;
  final kategori = ''.obs;
  final insight = ''.obs;
  final rekomendasi = <String>[].obs;

  late int userId;

  @override
  void onInit() {
    super.onInit();
    userId = box.read('userId') ?? 0;
  }

  /// ================= VALIDASI =================
  bool isValid() {
    return [
      q1,
      q2,
      q3,
      q4,
      q5,
      q6,
      q7,
      q8,
      q9,
      q10,
    ].every((e) => e.value != -1);
  }

  /// ================= HITUNG SKOR =================
  Future<void> hitungSkor() async {
    if (!isValid()) {
      Get.snackbar(
        "Peringatan",
        "Semua pertanyaan wajib diisi",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    /// ================= REVERSE SCORE =================
    int reverse(int val) {
      return 4 - val;
    }

    final total =
        q1.value +
        q2.value +
        q3.value +
        reverse(q4.value) +
        reverse(q5.value) +
        q6.value +
        reverse(q7.value) +
        q8.value +
        q9.value +
        reverse(q10.value);

    skor.value = total;

    /// ================= KATEGORI =================
    if (total <= 13) {
      kategori.value = "Rendah";
    } else if (total <= 26) {
      kategori.value = "Sedang";
    } else {
      kategori.value = "Tinggi";
    }

    generateInsight();
    generateRekomendasi();

    await saveToDatabase();
  }

  /// ================= INSIGHT =================
  void generateInsight() {
    if (kategori.value == "Rendah") {
      insight.value =
          "Kondisi stresmu masih tergolong baik 😌";
    } else if (kategori.value == "Sedang") {
      insight.value =
          "Kamu mulai mengalami tekanan emosional ⚠️";
    } else {
      insight.value =
          "Tingkat stresmu cukup tinggi ❤️";
    }
  }

  /// ================= REKOMENDASI =================
  void generateRekomendasi() {
    rekomendasi.clear();

    if (kategori.value == "Rendah") {
      rekomendasi.addAll([
        "Pertahankan pola hidup sehat",
        "Luangkan waktu relaksasi",
        "Olahraga ringan secara rutin",
      ]);
    } else if (kategori.value == "Sedang") {
      rekomendasi.addAll([
        "Coba meditasi atau latihan pernapasan",
        "Kurangi overthinking sebelum tidur",
        "Ceritakan masalah ke orang terpercaya",
        "Jika stres berlanjut, pertimbangkan konsultasi ke psikolog",
      ]);
    } else {
      rekomendasi.addAll([
        "Prioritaskan kesehatan mentalmu",
        "Kurangi tekanan aktivitas berlebihan",
        "Lakukan meditasi dan relaksasi rutin",
        "Disarankan konsultasi dengan psikolog profesional",
      ]);
    }
  }

  /// ================= SAVE DATABASE =================
  Future<void> saveToDatabase() async {
    final response = await api.saveStress(
      userId: userId,

      kontrolDiri: q1.value,
      bebanPikiran: q2.value,
      stresHarian: q3.value,
      percayaDiri: q4.value,
      kepuasanHidup: q5.value,
      emosi: q6.value,
      coping: q7.value,
      overthinking: q8.value,
      kewalahan: q9.value,
      kendaliSituasi: q10.value,

      skorTotal: skor.value,
      kategori: kategori.value,
    );

    if (response['success'] == true) {
      Get.put(DetailStressController());
      Get.snackbar(
        "Sukses",
        "Data stres berhasil disimpan",
      );

      final home = Get.find<HomeController>();
      await home.fetchStress();
      home.updateLifestyleIfReady();
    } else {
      Get.snackbar(
        "Error",
        response['message'] ?? "Gagal simpan",
      );
    }
  }
}