import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  static const Color primary = Color(0xFF4ADE80);
  static const Color secondary = Color(0xFF60A5FA);
  static const Color darkText = Color(0xFF1E293B);
  static const Color bgColor = Color(0xFFF7FAFC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          /// BACKGROUND DECORATION
          Positioned(
            top: -80,
            right: -60,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: primary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Positioned(
            bottom: -100,
            left: -80,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: secondary.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: Column(
                children: [
                  /// TOP LOGO
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [primary, secondary],
                        ),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: const Icon(
                        Icons.favorite_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),

                  const Spacer(),

                  /// IMAGE
                  Image.asset(
                    'assets/images/remaja.png',
                    width: 280,
                    height: 280,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 28),

                  /// TITLE
                  const Text(
                    "Sehat Hari Ini,\nLebih Baik Nanti",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      height: 1.2,
                      color: darkText,
                    ),
                  ),

                  const SizedBox(height: 14),

                  /// DESCRIPTION
                  const Text(
                    "Mulai langkah kecil untuk hidup lebih sehat.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),

                  const Spacer(),

                  const SizedBox(height: 24),

                  /// BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAllNamed(Routes.SIGNIN);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.zero,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [primary, secondary],
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: const Text(
                            "Mulai",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: active ? 20 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: active ? primary : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }
}