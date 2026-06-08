import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get_storage/get_storage.dart';
import '../../../data/providers/api_services.dart';

class FooddetectionController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  final ApiServices _api = ApiServices();
  final box = GetStorage();

  // ================= STATE =================
  Rx<File?> imageFile = Rx<File?>(null);
  RxString foodName = ''.obs;
  RxInt caloriesPer100g = 0.obs;
  RxDouble confidence = 0.0.obs;
  RxDouble weight = 100.0.obs;
  RxInt totalCalories = 0.obs;

  RxBool isDetecting = false.obs;      // untuk deteksi food
  RxBool isFetchingMeals = false.obs;  // untuk fetch today's meals
  RxString errorMessage = ''.obs;
  RxString successMessage = ''.obs;

  // ================= USER =================
  RxInt userId = 0.obs;

  // ================= TODAY'S MEALS =================
  RxList<Map<String, dynamic>> todaysMeals = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    final storedId = box.read('userId');
    if (storedId != null) {
      userId.value = storedId;
      fetchTodaysMeals();
    }
  }

  // ================= PILIH GAMBAR =================
  Future<void> pickImage(ImageSource source) async {
    final XFile? photo = await _picker.pickImage(source: source);
    if (photo != null) {
      imageFile.value = File(photo.path);
      await detectFood();
    }
  }

  // ================= DETECT =================
  Future<void> detectFood() async {
    if (imageFile.value == null) return;

    isDetecting.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    try {
      final result = await _api.detectFood(imageFile.value!);

      if (result['success'] == true) {
        foodName.value = result['food_name'] ?? 'Unknown';
        caloriesPer100g.value = (result['calories_per_100g'] ?? 0).toInt();
        confidence.value = (result['confidence_percent'] ?? 0).toDouble();
        calculateCalories();
      } else {
        errorMessage.value = result['message'] ?? 'Gagal mendeteksi';
        foodName.value = '';
      }
    } catch (e) {
      errorMessage.value = 'Error saat detect: $e';
      foodName.value = '';
    } finally {
      isDetecting.value = false;
    }
  }

  // ================= HITUNG TOTAL =================
  void calculateCalories() {
    totalCalories.value = ((caloriesPer100g.value / 100) * weight.value).round();
  }

  void reset() {
    imageFile.value = null;
    foodName.value = '';
    caloriesPer100g.value = 0;
    totalCalories.value = 0;
    confidence.value = 0;
    weight.value = 100;
    errorMessage.value = '';
    successMessage.value = '';
  }

  // ================= SAVE DETECTION =================
  Future<void> saveDetection() async {
    if (userId.value == 0) {
      errorMessage.value = "User belum login";
      return;
    }

    if (foodName.value.isEmpty || imageFile.value == null) {
      errorMessage.value = "Tidak ada hasil deteksi untuk disimpan";
      return;
    }

    isDetecting.value = true;
    errorMessage.value = '';
    successMessage.value = '';

    try {
      final result = await _api.saveDetection(
        userId: userId.value,
        foodName: foodName.value,
        caloriesPer100g: caloriesPer100g.value,
        weightGram: weight.value,
        totalCalories: totalCalories.value,
        confidence: confidence.value,
        imagePath: imageFile.value!.path,
      );

      if (result['success'] == true) {
        successMessage.value = "Hasil deteksi berhasil disimpan!";
        await fetchTodaysMeals(); // refresh Today's Meals
      } else {
        errorMessage.value = result['message'] ?? "Gagal menyimpan";
      }
    } catch (e) {
      errorMessage.value = "Error saat menyimpan: $e";
    } finally {
      isDetecting.value = false;
    }
  }

  // ================= FETCH TODAY'S MEALS =================
  Future<void> fetchTodaysMeals() async {
    if (userId.value == 0) return;

    isFetchingMeals.value = true;

    try {
      final result = await _api.getTodaysDetections(userId.value);
      if (result['success'] == true) {
        todaysMeals.value = List<Map<String, dynamic>>.from(result['data']);
      } else {
        todaysMeals.value = [];
      }
    } catch (e) {
      todaysMeals.value = [];
    } finally {
      isFetchingMeals.value = false;
    }
  }
}