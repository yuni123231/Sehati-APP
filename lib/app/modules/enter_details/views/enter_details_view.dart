import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/enter_details_controller.dart';

class EnterDetailsView extends StatelessWidget {
  EnterDetailsView({Key? key}) : super(key: key);

  final controller = Get.put(EnterDetailsController());

  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 8),

            const Text(
              'Enter Your Details',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1E293B),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              "Let's create your health profile ✨",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 24),

            /// =====================================================
            /// CARD
            /// =====================================================

            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 14,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// ================= NAME =================

                  const Text(
                    'Name',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    onChanged: controller.setName,
                    decoration: _inputStyle(
                      'Enter your name',
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// ================= AGE + GENDER =================

                  Row(
                    children: [

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            const Text(
                              'Age',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 8),

                            TextField(
                              keyboardType:
                                  TextInputType.number,

                              onChanged:
                                  controller.setAge,

                              decoration: _inputStyle(
                                'Years',
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [

                            const Text(
                              'Gender',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Obx(
                              () => DropdownButtonFormField<
                                  String>(
                                value:
                                    controller.gender.value,

                                items: const [
                                  DropdownMenuItem(
                                    value: 'Male',
                                    child: Text('Male'),
                                  ),
                                  DropdownMenuItem(
                                    value: 'Female',
                                    child: Text('Female'),
                                  ),
                                ],

                                onChanged: (val) {
                                  controller.setGender(
                                    val!,
                                  );
                                },

                                decoration:
                                    _inputStyle(''),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  /// ================= ADDRESS =================

                  const Text(
                    'Domisili',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Obx(
                    () => DropdownButtonFormField<String>(
                      value: controller.alamat.value.isEmpty
                          ? null
                          : controller.alamat.value,

                      items: const [

                        DropdownMenuItem(
                          value: 'Tegal',
                          child: Text('Tegal'),
                        ),

                        DropdownMenuItem(
                          value: 'Slawi',
                          child: Text('Slawi'),
                        ),

                        DropdownMenuItem(
                          value: 'Brebes',
                          child: Text('Brebes'),
                        ),
                      ],

                      onChanged: (val) {
                        controller.setAddress(val!);
                      },

                      decoration: _inputStyle(
                        'Pilih domisili',
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// ================= HEIGHT =================

                  const Text(
                    'Height (cm)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    keyboardType: TextInputType.number,

                    onChanged: controller.setHeight,

                    decoration: _inputStyle(
                      'Enter your height',
                    ),
                  ),

                  const SizedBox(height: 18),

                  /// ================= WEIGHT =================

                  const Text(
                    'Weight (kg)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 8),

                  TextField(
                    keyboardType: TextInputType.number,

                    onChanged: controller.setWeight,

                    decoration: _inputStyle(
                      'Enter your weight',
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// ================= ACTIVITY =================

                  const Text(
                    'Activity Level',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    'Select your activity level',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 14),

                  Column(
                    children: [

                      _activityCard(
                        title: 'Light',
                        subtitle: 'Rarely exercise',
                        icon: Icons.directions_walk,
                        color: Colors.orange,
                      ),

                      _activityCard(
                        title: 'Moderate',
                        subtitle:
                            'Exercise 1-3 times/week',
                        icon: Icons.directions_run,
                        color: Colors.green,
                      ),

                      _activityCard(
                        title: 'Active',
                        subtitle:
                            'Exercise 4+ times/week',
                        icon: Icons.fitness_center,
                        color: Colors.blue,
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  /// ================= GOALS =================

                  const Text(
                    'Goals',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Column(
                    children: [

                      _goalCard('Gain Weight'),

                      _goalCard('Lose Weight'),

                      _goalCard('Maintain'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            /// =====================================================
            /// BUTTON
            /// =====================================================

            SizedBox(
              width: double.infinity,
              height: 58,

              child: ElevatedButton(
                onPressed: () async {

                  final result =
                      await controller.saveUserProfile();

                  if (result != null) {

                    print("BMI: ${result['bmi']}");
                    print("TDEE: ${result['tdee']}");

                    Get.offAllNamed('/home');
                  }
                },

                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  elevation: 0,

                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                ),

                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  /// =====================================================
  /// INPUT STYLE
  /// =====================================================

  InputDecoration _inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,

      filled: true,
      fillColor: const Color(0xFFF4F7FB),

      contentPadding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 16,
      ),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: primary,
          width: 1.5,
        ),
      ),
    );
  }

  /// =====================================================
  /// ACTIVITY CARD
  /// =====================================================

  Widget _activityCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Obx(() {

      bool selected =
          controller.activity.value == title;

      return GestureDetector(
        onTap: () => controller.setActivity(title),

        child: Container(
          margin: const EdgeInsets.only(bottom: 12),

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: selected
                ? color.withValues(alpha: 0.10)
                : Colors.grey.shade100,

            borderRadius: BorderRadius.circular(18),

            border: Border.all(
              color: selected
                  ? color
                  : Colors.transparent,
              width: 2,
            ),
          ),

          child: Row(
            children: [

              Container(
                width: 48,
                height: 48,

                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius:
                      BorderRadius.circular(14),
                ),

                child: Icon(
                  icon,
                  color: color,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,

                  children: [

                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              if (selected)
                Icon(
                  Icons.check_circle,
                  color: color,
                ),
            ],
          ),
        ),
      );
    });
  }

  /// =====================================================
  /// GOAL CARD
  /// =====================================================

  Widget _goalCard(String title) {
    return Obx(() {

      bool selected =
          controller.goal.value == title;

      return GestureDetector(
        onTap: () => controller.setGoal(title),

        child: Container(
          margin: const EdgeInsets.only(bottom: 12),

          padding: const EdgeInsets.all(16),

          decoration: BoxDecoration(
            color: selected
                ? primary.withValues(alpha: 0.10)
                : Colors.grey.shade100,

            borderRadius: BorderRadius.circular(18),

            border: Border.all(
              color: selected
                  ? primary
                  : Colors.transparent,
              width: 2,
            ),
          ),

          child: Row(
            children: [

              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              if (selected)
                const Icon(
                  Icons.check_circle,
                  color: primary,
                ),
            ],
          ),
        ),
      );
    });
  }
}