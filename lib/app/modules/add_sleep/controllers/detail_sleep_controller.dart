import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class DetailSleepController extends GetxController {

  final home = Get.find<HomeController>();

  /// ================= DATA =================
  RxString kategori = ''.obs;
  RxInt skor = 0.obs;

  RxInt durasiTidur = 0.obs;
  RxInt gangguan = 0.obs;
  RxInt kualitas = 0.obs;
  RxInt lamaTerbangun = 0.obs;
  RxInt mengantukSiang = 0.obs;
  RxInt latensiTidur = 0.obs;
  RxInt jadwalTidur = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadData();
  }

  void loadData() {
    kategori.value = home.sleepKategori.value;
    skor.value = home.sleepRawScore.value;

    durasiTidur.value = home.durasiTidur.value;
    gangguan.value = home.gangguan.value;
    kualitas.value = home.kualitas.value;
    lamaTerbangun.value = home.lamaTerbangun.value;
    mengantukSiang.value = home.mengantukSiang.value;
    latensiTidur.value = home.latensiTidur.value;
    jadwalTidur.value = home.jadwalTidur.value;
  }

  /// OPTIONAL: refresh manual
  Future<void> refreshData() async {
    await home.fetchSleep();
    loadData();
  }
}