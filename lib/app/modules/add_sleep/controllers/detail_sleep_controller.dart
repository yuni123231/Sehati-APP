import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class DetailSleepController extends GetxController {

  final home = Get.find<HomeController>();

  /// ================= DATA =================
  RxString kategori = ''.obs;
  RxInt skor = 0.obs;

  RxInt durasiTidur = 0.obs;
  RxInt gangguan = 0.obs;
  RxInt lamaTerbangun = 0.obs;
  RxInt kualitas = 0.obs;
  RxInt keteraturan = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    kategori.value = home.sleepKategori.value;
    skor.value = home.sleepSkor.value;

    durasiTidur.value = home.durasiTidur.value;
    gangguan.value = home.gangguan.value;
    lamaTerbangun.value = home.lamaTerbangun.value;
    kualitas.value = home.kualitas.value;
    keteraturan.value = home.keteraturan.value;
  }

  /// OPTIONAL: refresh manual
  Future<void> refreshData() async {
    await home.fetchSleep();
    loadData();
  }
}