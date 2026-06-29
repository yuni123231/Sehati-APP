import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controllers/home_controller.dart';

class DetailActivityView extends StatelessWidget {
  DetailActivityView({super.key});

  final HomeController controller =
    Get.find<HomeController>();

  static const Color primary = Color(0xFF4ADE80);
  static const Color darkText = Color(0xFF1E293B);

  Color getCategoryColor(String kategori) {
    switch (kategori) {
      case "Aktif (Baik)":
        return Colors.green;

      case "Cukup Aktif":
        return Colors.orange;

      default:
        return Colors.red;
    }
  }

  String getInsight(String kategori) {
    switch (kategori) {
      case "Aktif (Baik)":
        return "Aktivitas fisikmu sudah memenuhi pedoman WHO untuk remaja 💪";

      case "Cukup Aktif":
        return "Aktivitas fisikmu cukup baik tetapi masih perlu ditingkatkan 🚀";

      default:
        return "Aktivitas fisikmu masih kurang dari rekomendasi WHO ❤️";
    }
  }

  List<String> getRekomendasi(String kategori) {
    if (kategori == "Aktif (Baik)") {
      return [
        "Pertahankan aktivitas minimal 60 menit setiap hari",
        "Lakukan olahraga intensitas sedang hingga berat",
        "Kurangi waktu duduk terlalu lama",
      ];
    }

    if (kategori == "Cukup Aktif") {
      return [
        "Tambahkan durasi aktivitas hingga 60 menit per hari",
        "Usahakan aktif minimal 5 hari dalam seminggu",
        "Kurangi waktu bermain gadget terlalu lama",
      ];
    }

    return [
      "Mulai aktivitas fisik minimal 30 menit",
      "Targetkan 60 menit aktivitas setiap hari",
      "Kurangi duduk atau rebahan lebih dari 8 jam",
      "Lakukan olahraga minimal 5 hari per minggu",
    ];
  }

  String mapSedentary(int value) {
    switch (value) {
      case 3:
        return "< 4 jam";

      case 2:
        return "4 - 8 jam";

      default:
        return "> 8 jam";
    }
  }

  String mapFrekuensi(int value) {
    if (value >= 5) {
      return "$value hari/minggu (Baik)";
    } else if (value >= 3) {
      return "$value hari/minggu";
    } else {
      return "$value hari/minggu (Kurang)";
    }
  }

  String mapDurasi(int value) {
    switch (value) {
      case 3:
        return "> 60 menit/hari";

      case 2:
        return "30 - 60 menit/hari";

      default:
        return "< 30 menit/hari";
    }
  }

  String mapIntensitas(int value) {
    switch (value) {
      case 3:
        return "Berat (Lari, futsal, basket, gym)";

      case 2:
        return "Sedang (Jalan cepat, sepeda santai)";

      default:
        return "Ringan (Jalan santai / banyak diam)";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xFFF5F7FB),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme:
            const IconThemeData(color: darkText),
        title: const Text(
          "Aktivitas Fisik",
          style: TextStyle(
            color: darkText,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Obx(() {
        if (controller
            .aktivitasKategori.value.isEmpty) {
          return const Center(
            child: Text(
                "Belum ada data aktivitas"),
          );
        }

        final kategori =
            controller.aktivitasKategori.value;

        final skor =
            controller.aktivitasSkor.value;

        final color =
            getCategoryColor(kategori);

        return SingleChildScrollView(
          padding:
              const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [

              /// HEADER

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      color,
                      color.withValues(
                          alpha: 0.7),
                    ],
                  ),
                  borderRadius:
                      BorderRadius.circular(28),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Hasil Aktivitas",
                      style: TextStyle(
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(
                        height: 12),

                    Text(
                      kategori,
                      style:
                          const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                        height: 10),

                    Text(
                      getInsight(kategori),
                      style:
                          const TextStyle(
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),

                    const SizedBox(
                        height: 20),

                    Row(
                      children: [

                        Container(
                          padding:
                              const EdgeInsets.all(14),
                          decoration:
                              BoxDecoration(
                            color: Colors.white
                                .withValues(
                                    alpha:
                                        0.2),
                            borderRadius:
                                BorderRadius
                                    .circular(
                                        16),
                          ),
                          child: Text(
                            "$skor / 12",
                            style:
                                const TextStyle(
                              color:
                                  Colors.white,
                              fontSize: 22,
                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),
                        ),

                        const SizedBox(
                            width: 14),

                        Expanded(
                          child:
                              LinearProgressIndicator(
                            value: (skor / 15)
                                .clamp(
                                    0.0, 1.0),
                            minHeight: 10,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                "Ringkasan Aktivitas Fisik",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 18),

              _item(
                "Durasi Aktivitas",
                mapDurasi(
                  controller.menitPerHari.value,
                ),
              ),

              _item(
                "Frekuensi Mingguan",
                mapFrekuensi(
                    controller
                        .frekuensi.value),
              ),

              _item(
                "Intensitas Aktivitas",
                mapIntensitas(
                    controller
                        .jenis.value),
              ),

              _item(
                "Waktu Duduk",
                mapSedentary(
                    controller
                        .sedentary.value),
              ),

              const SizedBox(height: 24),

              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(
                          24),
                ),

                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [

                    const Text(
                      "Rekomendasi",
                      style: TextStyle(
                        fontWeight:
                            FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),

                    const SizedBox(
                        height: 18),

                    ...getRekomendasi(
                            kategori)
                        .map(
                      (e) => Padding(
                        padding:
                            const EdgeInsets
                                .only(
                                    bottom:
                                        10),
                        child: Row(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [

                            Icon(
                              Icons
                                  .check_circle,
                              color: color,
                              size: 18,
                            ),

                            const SizedBox(
                                width: 10),

                            Expanded(
                              child: Text(
                                e,
                                style:
                                    const TextStyle(
                                  height:
                                      1.5,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _item(
      String title,
      String value,
      ) {
    return Container(
      margin:
          const EdgeInsets.only(bottom: 14),
      padding:
          const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(20),
      ),

      child: Row(
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: TextStyle(
                    color:
                        Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(
                    height: 5),

                Text(
                  value,
                  style:
                      const TextStyle(
                    fontWeight:
                        FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.insights,
            color: primary,
          )
        ],
      ),
    );
  }
}