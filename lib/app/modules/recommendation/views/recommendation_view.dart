import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/nutrition_helper.dart';
import '../controllers/recommendation_controller.dart';

class RecommendationView extends StatelessWidget {
  RecommendationView({super.key});
  static const Color green = Color(0xFF1E8E6E);

  final controller = Get.put(RecommendationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Recommendation'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// STATUS CARD
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.local_fire_department, color: green),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        controller.statusText,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text(
                "Recommended Menu",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              /// LIST REKOMENDASI DINAMIS
              if (controller.recommendedFoods.isEmpty)
                const Text("No recommendation available")
              else
                ...controller.recommendedFoods.map((food) {
                  final calories = food['kalori'] ?? 0;
                  final description = food['description'] ?? food['nama'] ?? "-";
                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(description, style: const TextStyle(fontSize: 14))),
                        Text("$calories kcal", style: const TextStyle(fontSize: 14, color: Colors.black54)),
                      ],
                    ),
                  );
                }).toList(),

              const SizedBox(height: 30),

              /// HEALTHY TIPS
              const Text('Healthy Living Tips', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: green),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Do strength exercises', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                    SizedBox(height: 6),
                    Text('3 times a week', style: TextStyle(fontSize: 13, color: green)),
                  ],
                ),
              ),

              const SizedBox(height: 80),
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) Get.toNamed('/home');
          if (index == 1) Get.toNamed('/menu');
          if (index == 2) Get.toNamed('/profile');
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: "Menu's"),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}