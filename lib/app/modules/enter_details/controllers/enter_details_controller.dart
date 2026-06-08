import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_services.dart';

class EnterDetailsController extends GetxController {

  late int userId;

  /// =====================================================
  /// TEXTFIELD
  /// =====================================================

  final name = ''.obs;
  final age = ''.obs;
  final height = ''.obs;
  final weight = ''.obs;

  /// DOMISILI
  final alamat = ''.obs;

  /// =====================================================
  /// DROPDOWN
  /// =====================================================

  final gender = 'Male'.obs;
  final activity = 'Moderate'.obs;
  final goal = 'Gain Weight'.obs;

  /// =====================================================
  /// SERVICE
  /// =====================================================

  final ApiServices api = ApiServices();
  final box = GetStorage();

  /// =====================================================
  /// INIT
  /// =====================================================

  @override
  void onInit() {
    super.onInit();

    userId = box.read('userId') ?? 0;

    if (userId == 0) {
      Get.snackbar(
        "Error",
        "User tidak ditemukan",
      );

      Future.delayed(
        const Duration(seconds: 1),
        () {
          Get.offAllNamed('/signin');
        },
      );
    }
  }

  /// =====================================================
  /// SAVE PROFILE
  /// =====================================================

  Future<Map<String, dynamic>?> saveUserProfile() async {

    final umur = int.tryParse(age.value);
    final tinggi = double.tryParse(height.value);
    final berat = double.tryParse(weight.value);

    /// VALIDASI
    if (
        name.value.isEmpty ||
        umur == null ||
        tinggi == null ||
        berat == null ||
        alamat.value.isEmpty
    ) {

      Get.snackbar(
        "Error",
        "Semua data wajib diisi",
      );

      return null;
    }

    try {

      final result = await api.saveUserProfile(

        userId: userId,

        umur: umur,

        tinggiBadan: tinggi,

        beratBadan: berat,

        jenisKelamin: gender.value,

        aktivitas: activity.value,

        tujuan: goal.value,

        /// TAMBAHAN
        alamat: alamat.value,
      );

      if (result != null) {

        Get.snackbar(
          "Berhasil",
          "Profil berhasil disimpan ✨",
        );
      }

      return result;

    } catch (e) {

      Get.snackbar(
        "Error",
        "Gagal menyimpan profil",
      );

      return null;
    }
  }

  /// =====================================================
  /// SETTER
  /// =====================================================

  void setName(String v) {
    name.value = v;
  }

  void setAge(String v) {
    age.value = v;
  }

  void setHeight(String v) {
    height.value = v;
  }

  void setWeight(String v) {
    weight.value = v;
  }

  void setGender(String v) {
    gender.value = v;
  }

  void setActivity(String v) {
    activity.value = v;
  }

  void setGoal(String v) {
    goal.value = v;
  }

  /// TAMBAHAN
  void setAddress(String v) {
    alamat.value = v;
  }
}