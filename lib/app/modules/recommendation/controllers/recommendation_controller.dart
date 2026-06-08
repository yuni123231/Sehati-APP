import 'package:get/get.dart';
import '../../../data/providers/api_services.dart';
import 'package:get_storage/get_storage.dart';

class RecommendationController extends GetxController {
  final ApiServices api = ApiServices();
  final box = GetStorage();

  var recommendedFoods = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;
  var sisaKalori = 0.obs;

  late int userId;

  @override
  void onInit() {
    super.onInit();
    userId = box.read('userId') ?? 0;
    if (userId != 0) {
      loadRecommendations();
    }
  }

  Future<void> loadRecommendations() async {
    try {
      isLoading.value = true;

      final response = await api.getRecommendations(userId);

      if (response['success'] == true) {
        sisaKalori.value = response['sisa_kalori'];
        recommendedFoods.value =
            List<Map<String, dynamic>>.from(response['data']);
      } else {
        recommendedFoods.clear();
      }

    } catch (e) {
      recommendedFoods.clear();
      print("Recommendation Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String get statusText {
    if (sisaKalori.value > 500) {
      return "You still need ${sisaKalori.value} kcal today!";
    } else if (sisaKalori.value > 0) {
      return "Almost there! ${sisaKalori.value} kcal remaining";
    } else {
      return "Daily calorie target achieved 🎉";
    }
  }
}