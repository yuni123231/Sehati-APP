import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class TargetController extends GetxController {
  final home = Get.find<HomeController>();

  /// ================= TARGET =================
  final targetAktivitas = 30; // menit/hari
  final targetTidurMin = 7;
  final targetAir = 8;

  /// ================= PROGRESS =================
  double get aktivitasProgress {
    int user = home.menitPerHari.value;
    return (user / targetAktivitas).clamp(0, 1);
  }

  double get tidurProgress {
    int user = home.durasiTidur.value;
    return (user / targetTidurMin).clamp(0, 1);
  }

  double get airProgress {
    int user = home.airPutih.value;
    return (user / targetAir).clamp(0, 1);
  }

  /// ================= STATUS =================
  bool get aktivitasTercapai => aktivitasProgress >= 1;
  bool get tidurTercapai => tidurProgress >= 1;
  bool get airTercapai => airProgress >= 1;
}