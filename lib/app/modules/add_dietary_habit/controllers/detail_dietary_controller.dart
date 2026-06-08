import 'package:get/get.dart';

class DetailDietaryController extends GetxController {
  final kategori = ''.obs;
  final skor = 0.obs;

  final frekuensi = 0.obs;
  final sarapan = 0.obs;
  final sayur = 0.obs;
  final junk = 0.obs;
  final manis = 0.obs;
  final air = 0.obs;
  final makananLengkap = 0.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};

    kategori.value = args['kategori'] ?? '-';
    skor.value = args['skor'] ?? 0;

    frekuensi.value = args['frekuensi'] ?? 0;
    sarapan.value = args['sarapan'] ?? 0;
    sayur.value = args['sayur'] ?? 0;
    junk.value = args['junk'] ?? 0;
    manis.value = args['manis'] ?? 0;
    air.value = args['air'] ?? 0;
    makananLengkap.value = args['makanan_lengkap'] ?? 0;
  }
}