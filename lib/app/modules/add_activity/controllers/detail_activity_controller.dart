import 'package:get/get.dart';

class DetailActivityController extends GetxController {
  final kategori = ''.obs;
  final skor = 0.obs;

  final menit = 0.obs;
  final hari = 0.obs;
  final frekuensi = 0.obs;
  final jenis = 0.obs;
  final detail = 0.obs;
  final sedentary = 0.obs;
  final konsistensi = 0.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};

    kategori.value = args['kategori'] ?? '-';
    skor.value = args['skor'] ?? 0;

    menit.value = args['menit'] ?? 0;
    hari.value = args['hari'] ?? 0;
    frekuensi.value = args['frekuensi'] ?? 0;
    jenis.value = args['jenis'] ?? 0;
    detail.value = args['detail'] ?? 0;
    sedentary.value = args['sedentary'] ?? 0;
    konsistensi.value = args['konsistensi'] ?? 0;
  }
}