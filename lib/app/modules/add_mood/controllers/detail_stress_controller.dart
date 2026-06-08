import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/providers/api_services.dart';

/// ================= MODEL PSIKOLOG =================
class PsikologModel {
  final String tempat;
  final String dokter;
  final String url;

  PsikologModel({
    required this.tempat,
    required this.dokter,
    required this.url,
  });
}

class DetailStressController extends GetxController {

  /// ================= RESULT =================
  final kategori = ''.obs;
  final skorTotal = 0.obs;

  /// ================= QUESTION =================
  final kontrolDiri = 0.obs;
  final bebanPikiran = 0.obs;
  final stresHarian = 0.obs;
  final percayaDiri = 0.obs;
  final kepuasanHidup = 0.obs;
  final emosi = 0.obs;
  final coping = 0.obs;
  final overthinking = 0.obs;
  final kewalahan = 0.obs;
  final kendaliSituasi = 0.obs;

  final box = GetStorage();
  final rekomendasiPsikolog = <PsikologModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments ?? {};
    print("=== DEBUG ARGS ===");
    print(args);

    kategori.value = args['kategori'] ?? '-';
    skorTotal.value = args['skor_total'] ?? 0;

    kontrolDiri.value = args['kontrol_diri'] ?? 0;
    bebanPikiran.value = args['beban_pikiran'] ?? 0;
    stresHarian.value = args['stres_harian'] ?? 0;
    percayaDiri.value = args['percaya_diri'] ?? 0;
    kepuasanHidup.value = args['kepuasan_hidup'] ?? 0;
    emosi.value = args['emosi'] ?? 0;
    coping.value = args['coping'] ?? 0;
    overthinking.value = args['overthinking'] ?? 0;
    kewalahan.value = args['kewalahan'] ?? 0;
    kendaliSituasi.value = args['kendali_situasi'] ?? 0;

    loadPsikologByLocation();
  }

  /// FUNCTION BUKA LINK
  void openDokterUrl(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw "Tidak bisa membuka link";
    }
  }

  void saveAndReturn() {
    Get.back(result: {
      "kategori": kategori.value,
      "skor_total": skorTotal.value,
      "kontrol_diri": kontrolDiri.value,
      "beban_pikiran": bebanPikiran.value,
      "stres_harian": stresHarian.value,
      "percaya_diri": percayaDiri.value,
      "kepuasan_hidup": kepuasanHidup.value,
      "emosi": emosi.value,
      "coping": coping.value,
      "overthinking": overthinking.value,
      "kewalahan": kewalahan.value,
      "kendali_situasi": kendaliSituasi.value,
    });
  }

  Future<void> loadPsikologByLocation() async {
    final userId = box.read('userId');

    final profile = await ApiServices().getUserProfile(userId);

    final alamat = (profile?['alamat'] ?? '')
        .toString()
        .toLowerCase();

    print("ALAMAT USER: $alamat");

    final res = await ApiServices().getPsikolog(alamat);

    if (res['success'] == true) {
      final data = res['data'] as List;

      rekomendasiPsikolog.assignAll(
        data.map((e) => PsikologModel(
          dokter: e['dokter'],
          tempat: e['tempat'],
          url: e['url'],
        )).toList(),
      );
    } else {
      rekomendasiPsikolog.clear();
    }
  }
}