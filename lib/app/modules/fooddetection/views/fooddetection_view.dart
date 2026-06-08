import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/fooddetection_controller.dart';

class FoodDetectionView extends GetView<FooddetectionController> {
  const FoodDetectionView({super.key});

  static const Color green = Color(0xFF1E8E6E);

  @override
  Widget build(BuildContext context) {
    // Panggil fetchTodaysMeals saat halaman dibuka
    controller.fetchTodaysMeals();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Food Detection',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),

                /// ================= IMAGE CARD =================
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(20)),
                      ),
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Select Image Source",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              const SizedBox(height: 20),
                              ListTile(
                                leading:
                                    const Icon(Icons.camera_alt, color: green),
                                title: const Text("Take Photo"),
                                onTap: () {
                                  Get.back();
                                  controller.pickImage(ImageSource.camera);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.photo_library,
                                    color: green),
                                title: const Text("Upload from Gallery"),
                                onTap: () {
                                  Get.back();
                                  controller.pickImage(ImageSource.gallery);
                                },
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 220,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F3F3),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: controller.imageFile.value == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.camera_alt, color: green, size: 40),
                              SizedBox(height: 12),
                              Text(
                                'Tap to select image',
                                textAlign: TextAlign.center,
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 13),
                              ),
                            ],
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.file(
                              controller.imageFile.value!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                /// ================= LOADING DETECTION =================
                if (controller.isDetecting.value)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: CircularProgressIndicator(),
                    ),
                  ),

                /// ================= ERROR =================
                if (controller.errorMessage.isNotEmpty)
                  Text(
                    controller.errorMessage.value,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                  ),

                /// ================= SUCCESS =================
                if (controller.successMessage.isNotEmpty)
                  Text(
                    controller.successMessage.value,
                    style: const TextStyle(color: Colors.green, fontSize: 13),
                  ),

                /// ================= RESULT =================
                if (controller.foodName.isNotEmpty && !controller.isDetecting.value) ...[
                  Text(
                    controller.foodName.value,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '${controller.caloriesPer100g.value} kcal / 100g',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Confidence ${controller.confidence.value.toStringAsFixed(1)}%',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Text('Estimated weight: ${controller.weight.value.round()} g'),
                  Slider(
                    value: controller.weight.value,
                    min: 50,
                    max: 500,
                    divisions: 9,
                    activeColor: green,
                    onChanged: (val) {
                      controller.weight.value = val;
                      controller.calculateCalories();
                    },
                  ),
                  Text(
                    'Total Calories: ${controller.totalCalories.value} kcal',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 16),

                  /// ================= BUTTON SAVE =================
                  ElevatedButton(
                    onPressed: controller.isDetecting.value
                        ? null
                        : () {
                            controller.saveDetection();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      'Save Detection',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],

                /// ================= TODAY MEALS =================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Today's Meals",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Tampilan list hari ini
                Obx(() {
                  if (controller.isFetchingMeals.value) {
                    return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2));
                  }

                  if (controller.todaysMeals.isEmpty) {
                    return const Text(
                      "No meals detected yet",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    );
                  }

                  return Column(
                    children: controller.todaysMeals.map((meal) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(meal['food_name'] ?? '-'),
                            Text(
                              '${meal['total_calories'] ?? 0} kcal',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}