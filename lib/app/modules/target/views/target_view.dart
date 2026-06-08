import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/target_controller.dart';

class TargetView extends StatelessWidget {
  TargetView({super.key});

  final controller = Get.put(TargetController());

  static const Color primaryGreen = Color(0xFF3FAF8F);
  static const Color lightGreen = Color(0xFFE8F5F1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Target Harian"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      backgroundColor: Colors.grey[100],

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            _targetCard(
              "Aktivitas",
              Icons.directions_run,
              controller.aktivitasProgress,
              "${controller.home.menitPerHari.value} / 30 menit",
              controller.aktivitasTercapai,
            ),

            _targetCard(
              "Tidur",
              Icons.bed,
              controller.tidurProgress,
              "${controller.home.durasiTidur.value} / 7 jam",
              controller.tidurTercapai,
            ),

            _targetCard(
              "Air Putih",
              Icons.water_drop,
              controller.airProgress,
              "${controller.home.airPutih.value} / 8 gelas",
              controller.airTercapai,
            ),
          ],
        ),
      ),
    );
  }

  Widget _targetCard(
    String title,
    IconData icon,
    double progress,
    String value,
    bool done,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Icon(icon, color: primaryGreen),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                done ? "✔ Tercapai" : "Belum",
                style: TextStyle(
                  color: done ? Colors.green : Colors.red,
                  fontSize: 12,
                ),
              )
            ],
          ),

          const SizedBox(height: 10),

          Text(value),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: primaryGreen,
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}