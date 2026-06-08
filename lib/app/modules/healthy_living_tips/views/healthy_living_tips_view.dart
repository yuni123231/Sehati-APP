import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HealthyLivingTipsView extends StatelessWidget {
  const HealthyLivingTipsView({super.key});

  static const Color green = Color(0xFF1E8E6E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      /// APP BAR
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        title: const Text('Healthy Living Tips'),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),

            /// TITLE
            const Text(
              'Healthy Living Tips',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            /// SUBTITLE
            const Text(
              'Based on calorie needs, here are tips to support your weight',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 20),

            /// LIST
            Expanded(
              child: ListView.builder(
                itemCount: tips.length,
                itemBuilder: (context, index) {
                  return _TipCard(
                    title: tips[index]['title']!,
                    subtitle: tips[index]['subtitle']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// CARD ITEM
class _TipCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TipCard({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: HealthyLivingTipsView.green),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 13,
              color: HealthyLivingTipsView.green,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

/// DATA DUMMY
final List<Map<String, String>> tips = [
  {
    'title': 'Do-strength exercises',
    'subtitle': '3 times a week',
  },
  {
    'title': 'Eat balanced meals',
    'subtitle': 'Every day',
  },
  {
    'title': 'Drink enough water',
    'subtitle': '8 glasses daily',
  },
  {
    'title': 'Get enough sleep',
    'subtitle': '7–8 hours per night',
  },
  {
    'title': 'Avoid sugary drinks',
    'subtitle': 'Limit intake',
  },
];
