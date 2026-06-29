import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_services.dart';

class EnterDetailsController extends GetxController {

  final ApiServices api = ApiServices();
  final box = GetStorage();

  late int userId;

  // ==========================
  // FORM DATA
  // ==========================

  final name = ''.obs;
  final age = ''.obs;
  final height = ''.obs;
  final weight = ''.obs;

  final gender = ''.obs;
  final alamat = ''.obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();


    userId =
        Get.arguments ??
        box.read('userId') ??
        0;


    if(userId != 0){

      box.write(
        'userId',
        userId,
      );

      print(
        "USER ID ENTER DETAILS = $userId"
      );

    }else{

      Get.snackbar(
        "Error",
        "User tidak ditemukan",
      );


      Future.delayed(
        const Duration(seconds:1),
        (){
          Get.offAllNamed('/signin');
        },
      );
    }
  }

  // ==========================
  // SAVE PROFILE
  // ==========================

  Future<Map<String, dynamic>?> saveUserProfile() async {

    final umur = int.tryParse(age.value);
    final tinggi = double.tryParse(height.value);
    final berat = double.tryParse(weight.value);

    if (name.value.isEmpty ||
        umur == null ||
        tinggi == null ||
        berat == null ||
        gender.value.isEmpty ||
        alamat.value.isEmpty) {

      Get.snackbar(
        "Error",
        "Semua data wajib diisi",
      );

      return null;
    }

    isLoading.value = true;

    try {

      final result =
          await api.saveUserProfile(
        userId: userId,
        umur: umur,
        tinggiBadan: tinggi,
        beratBadan: berat,

        jenisKelamin: gender.value,

        // default sementara
        aktivitas: "Moderate",
        tujuan: "Healthy",

        alamat: alamat.value,
      );

      isLoading.value = false;

      if (result != null &&
          result["success"] == true) {

        Get.snackbar(
          "Data Tersimpan",
          "Profil berhasil disimpan. Silakan verifikasi email untuk login.",
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 4),
        );

        Future.delayed(
          const Duration(seconds: 2),
          (){
            Get.offAllNamed('/signin');
          },
        );

        return result;
      }

      Get.snackbar(
        "Error",
        result?["message"] ??
            "Gagal menyimpan profil",
      );

      return null;

    } catch (e) {

      isLoading.value = false;

      Get.snackbar(
        "Error",
        "Terjadi kesalahan server",
      );

      return null;
    }
  }

  // ==========================
  // SETTER
  // ==========================

  void setName(String value) {
    name.value = value;
  }

  void setAge(String value) {
    age.value = value;
  }

  void setHeight(String value) {
    height.value = value;
  }

  void setWeight(String value) {
    weight.value = value;
  }

  void setGender(String value) {
    gender.value = value;
  }

  void setAddress(String value) {
    alamat.value = value;
  }
}