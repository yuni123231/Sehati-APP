import 'package:get/get.dart';

class DetailDietaryController extends GetxController {

  final kategori = ''.obs;
  final skor = 0.obs;

  final frekuensi = 0.obs;
  final sarapan = 0.obs;
  final sayurBuah = 0.obs;
  final junkFood = 0.obs;
  final minumanManis = 0.obs;
  final airPutih = 0.obs;
  final makananLengkap = 0.obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};

    kategori.value = args["kategori"] ?? "";
    skor.value = args["skor"] ?? 0;

    frekuensi.value = args["frekuensi"] ?? 0;
    sarapan.value = args["sarapan"] ?? 0;
    sayurBuah.value = args["sayur_buah"] ?? 0;
    junkFood.value = args["junk_food"] ?? 0;
    minumanManis.value = args["minuman_manis"] ?? 0;
    airPutih.value = args["air_putih"] ?? 0;
    makananLengkap.value = args["makanan_lengkap"] ?? 0;
  }
}