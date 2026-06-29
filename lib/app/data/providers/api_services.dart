import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  // Ganti dengan IP lokal atau URL backend kamu
  final String baseUrl = 'http://192.168.18.8:5000';  //WFI LAPTOP
  // final String baseUrl = 'http://192.168.43.24:5000'; // WFI HP
  // final String baseUrl = 'http://192.168.141.230:5000'; // WFI PERPUS
  //  final String baseUrl = 'http://192.168.110.2:5000'; // WFI CAFE
   
  // ================== SIGNUP ==================
  Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/signup'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        // Mengembalikan success + user_id
        return {
          'success': true,
          'user_id': data['user_id'],
          'message': data['message'] ?? 'Silahkan cek email',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Terjadi kesalahan saat signup',
        };
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal terhubung ke server");
      return {'success': false, 'message': 'Server tidak dapat diakses'};
    }
  }

// ===================== SIGN IN =====================
  Future<Map<String, dynamic>> signin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/signin'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'user_id': data['user_id'],
          'nama': data['nama'],
          'message': 'Login berhasil',
        };
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Login gagal',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Server error',
      };
    }
  }

  Future<Map<String,dynamic>> googleLogin(
    String idToken
    
    ) async {
      
    try{
      final response = await http.post(
      Uri.parse(
      '$baseUrl/api/google-login'
    ),
      headers:{
      'Content-Type':
      'application/json'
    },
    body:jsonEncode({
      'id_token':idToken
      })
    );
    final data =
      jsonDecode(response.body);
      return data;
      }catch(e){
      return {
        "success":false,
        "message":
        "Server error"
      };
    }
  }

  // ================== SIGN IN WITH GOOGLE ===================
  Future<Map<String, dynamic>> signinGoogle(String email) async {

    final response = await http.post(
      Uri.parse(
        '$baseUrl/api/signin-google'
      ),
      headers: {
        "Content-Type": "application/json"
      },
      body: jsonEncode({
        "email": email
      }),
    );
    return jsonDecode(response.body);
  }

  // ================== FORGOT PASSWORD ==================
  Future<Map<String, dynamic>> forgotPassword(String email) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/forgot-password"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
      }),
    );

    return jsonDecode(response.body);
  }

  Future<Map<String, dynamic>> resetPassword(
    String email,
    String otp,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse("$baseUrl/api/reset-password"),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "email": email,
        "otp": otp,
        "password": password,
      }),
    );

    return jsonDecode(response.body);
  }

  // ================== SAVE USER PROFILE ==================
  Future<Map<String, dynamic>?> saveUserProfile({
    required int userId,
    required int umur,
    required double tinggiBadan,
    required double beratBadan,
    required String jenisKelamin,
    required String aktivitas,
    required String tujuan,
    required String alamat,
  }) async {

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/user_profile'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "user_id": userId,
          "umur": umur,
          "tinggi_badan": tinggiBadan,
          "berat_badan": beratBadan,
          "jenis_kelamin": jenisKelamin,
          "aktivitas": aktivitas,
          "tujuan": tujuan,
          "alamat": alamat,
        }),
      );

      /// ================= DEBUG =================
    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE BODY: ${response.body}");

      /// ================= CEK RESPONSE =================
      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        return jsonDecode(response.body);

      } else {

        return {
          "success": false,
          "message": "Server Error ${response.statusCode}"
        };
      }

    } catch (e) {

      print("ERROR SAVE PROFILE: $e");

      return {
        "success": false,
        "message": e.toString(),
      };
    }
  }

// ================== GET USER PROFILE ==================
  Future<Map<String, dynamic>?> getUserProfile(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/user_profile/$userId'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // return data['profile'];
        if(data['profile'] != null){

          return Map<String,dynamic>.from(
            data['profile']
          );
        }
      }
      return null;
    } catch (e) {
      Get.snackbar("Error", "Gagal terhubung ke server");
      return null;
    }
  }

  Future<Map<String, dynamic>> updateUserProfile({
    required int userId,
    required String name,
    required String email,
    required int umur,
    required double tinggiBadan,
    required double beratBadan,
    required String jenisKelamin,
    required String aktivitas,
    required String tujuan,
    required String alamat,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/user_profile'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'name': name,
          'email': email,
          'umur': umur,
          'tinggi_badan': tinggiBadan,
          'berat_badan': beratBadan,
          'jenis_kelamin': jenisKelamin,
          'aktivitas': aktivitas,
          'tujuan': tujuan,
          "alamat": alamat,
        }),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 201) {
        return data;
      } else {
        Get.snackbar("Error", data['message'] ?? "Gagal update profil");
        return {'success': false};
      }
    } catch (e) {
      Get.snackbar("Error", "Gagal terhubung ke server");
      return {'success': false};
    }
  }

  Future<bool> updateUserProfileBasic({
    required int userId,
    required String name,
    required String email,
    String? password,
  }) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/api/user_account/$userId'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'name': name,
          'email': email,
          if (password != null && password.isNotEmpty)
            'password': password,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        Get.snackbar('Error', data['message'] ?? 'Gagal update profile');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Tidak terhubung dengan server');
      return false;
    }
  }

  // ================= FOOD DETECTION =================
  Future<Map<String, dynamic>> detectFood(File imageFile) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/api/food-detection'),
      );

      request.files.add(
        await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
        ),
      );

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        return jsonDecode(responseBody);
      } else {
        return {
          'success': false,
          'message': 'Server error ${response.statusCode}'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal terhubung ke server'
      };
    }
  }

  // ================= SAVE DETECTION =================
  Future<Map<String, dynamic>> saveDetection({
    required int userId,
    required String foodName,
    required int caloriesPer100g,
    required double weightGram,
    required int totalCalories,
    required double confidence,
    required String imagePath,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/save-detection'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": userId,
          "food_name": foodName,
          "calories_per_100g": caloriesPer100g,
          "weight_gram": weightGram,
          "total_calories": totalCalories,
          "confidence": confidence,
          "image_path": imagePath,
        }),
      );

      if (response.statusCode == 201) {
        return jsonDecode(response.body);
      } else {
        return {"success": false, "message": "Server error ${response.statusCode}"};
      }
    } catch (e) {
      return {"success": false, "message": "Gagal terhubung ke server"};
    }
  }

  // ================== GET TODAY'S DETECTIONS =================
  Future<Map<String, dynamic>> getTodaysDetections(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/todays-detections/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // data['data'] diasumsikan berisi list deteksi hari ini
        return {
          'success': true,
          'data': data['data'] ?? [],
        };
      } else {
        return {
          'success': false,
          'message': 'Server error ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal terhubung ke server',
      };
    }
  }

  Future<Map<String, dynamic>> getRecommendations(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/recommendations/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return {
          'success': false,
          'message': 'Server error ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal terhubung ke server',
      };
    }
  }

  Future<Map<String, dynamic>> addActivity({
    required int userId,
    required String name,
    required int calories,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/add-activity'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": userId,
          "name": name,
          "calories": calories,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, ...data};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal tambah aktivitas'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal terhubung ke server'
      };
    }
  }

  Future<Map<String, dynamic>> addSleep({
    required int userId,
    required double hours,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/add-sleep'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": userId,
          "hours": hours,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, ...data};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal simpan sleep'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal terhubung ke server'
      };
    }
  }

  Future<Map<String, dynamic>> addMood({
    required int userId,
    required String mood,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/add-mood'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": userId,
          "mood": mood,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, ...data};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal simpan mood'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Gagal terhubung ke server'
      };
    }
  }

  // =================== SAVE POLA HIDUP SEHAT ==================
  
   // ======== AKTIVITAS ===========
    Future<Map<String, dynamic>> saveActivity({
      required int userId,

      required int durasiAktivitas,
      required int intensitasAktivitas,
      required int sedentary,

      required int skorTotal,
      required String kategori,
    }) async {
      try {
        final response = await http.post(
          Uri.parse('$baseUrl/api/save-activity'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "user_id": userId,
            "durasi_aktivitas": durasiAktivitas,
            "intensitas_aktivitas": intensitasAktivitas,
            "sedentary": sedentary,
            "skor_total": skorTotal,
            "kategori": kategori,
          }),
        );

        final data = jsonDecode(response.body);

        if (response.statusCode == 200 ||
            response.statusCode == 201) {
          return {
            'success': true,
            ...data,
          };
        } else {
          return {
            'success': false,
            'message': data['message'],
          };
        }
      } catch (e) {
        print("ERROR SAVE ACTIVITY: $e");

        return {
          'success': false,
          'message': 'Gagal koneksi',
        };
      }
    }

    Future<Map<String, dynamic>> getActivity(
      int userId,
    ) async {
      try {
        final response = await http.get(
          Uri.parse('$baseUrl/api/get-activity/$userId'),
        );

        final data = jsonDecode(response.body);

        if (response.statusCode == 200 &&
            data['success']) {
          return data;
        } else {
          return {
            'success': false,
            'message': data['message'],
          };
        }
      } catch (e) {
        return {
          'success': false,
          'message': 'Gagal koneksi',
        };
      }
    }

  // ======== 2. POLA MAKAN ==========
  Future<Map<String, dynamic>> saveDietary({
    required int userId,
    required int frekuensiMakan,
    required int sarapan,
    required int sayurBuah,
    required int junkFood,
    required int minumanManis,
    required int airPutih,
    required int makananLengkap,
    required int skorTotal,
    required String kategori,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/save-dietary'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": userId,
          "frekuensi_makan": frekuensiMakan,
          "sarapan": sarapan,
          "sayur_buah": sayurBuah,
          "junk_food": junkFood,
          "minuman_manis": minumanManis,
          "air_putih": airPutih,
          'makanan_lengkap': makananLengkap,
          "skor_total": skorTotal,
          "kategori": kategori,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, ...data};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Gagal simpan dietary'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Tidak terhubung ke server'
      };
    }
  }

  Future<Map<String, dynamic>> getDietary(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/get-dietary/$userId'),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        return data;
      } else {
        return {'success': false};
      }
    } catch (e) {
      return {'success': false};
    }
  }

  // ======== POLA TIDUR ==========
  Future<Map<String, dynamic>> saveSleep({
    required int userId,
    required int durasi,
    required int gangguan,
    required int kualitas,
    required int terbangun,
    required int mengantuk,
    required int latensi,
    required int jadwal,
    required int skorTotal,
    required String kategori,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/save-sleep'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": userId,
          "durasi_tidur": durasi,
          "gangguan": gangguan,
          "kualitas_tidur": kualitas,
          "lama_terbangun": terbangun,
          "mengantuk_siang": mengantuk,
          "latensi_tidur": latensi,
          "jadwal_tidur": jadwal,
          "skor_total": skorTotal,
          "kategori": kategori
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, ...data};
      } else {
        return {'success': false};
      }
    } catch (e) {
      return {'success': false};
    }
  }

  Future<Map<String, dynamic>> getSleep(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/get-sleep/$userId'),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success']) {
        return data;
      } else {
        return {'success': false};
      }
    } catch (e) {
      return {'success': false};
    }
  }

 // ======== STRESS PSS ==========
Future<Map<String, dynamic>> saveStress({
  required int userId,

  required int kontrolDiri,
  required int bebanPikiran,
  required int stresHarian,
  required int percayaDiri,
  required int kepuasanHidup,
  required int emosi,
  required int coping,
  required int overthinking,
  required int kewalahan,
  required int kendaliSituasi,

  required int skorTotal,
  required String kategori,
}) async {
  try {
    final response = await http.post(
      Uri.parse('$baseUrl/api/save-stress'),
      headers: {
        'Content-Type': 'application/json',
      },

      body: jsonEncode({

        "user_id": userId,

        "kontrol_diri": kontrolDiri,
        "beban_pikiran": bebanPikiran,
        "stres_harian": stresHarian,
        "percaya_diri": percayaDiri,
        "kepuasan_hidup": kepuasanHidup,
        "emosi": emosi,
        "coping": coping,
        "overthinking": overthinking,
        "kewalahan": kewalahan,
        "kendali_situasi": kendaliSituasi,

        "skor_total": skorTotal,
        "kategori": kategori,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 ||
        response.statusCode == 201) {

      return {
        'success': true,
        ...data,
      };

    } else {

      return {
        'success': false,
        'message':
            data['message'] ??
            'Gagal simpan data stres',
      };
    }

  } catch (e) {

    return {
      'success': false,
      'message': 'Tidak terhubung ke server',
    };
  }
}

Future<Map<String, dynamic>> getStress(
  int userId,
) async {

  try {

    final response = await http.get(
      Uri.parse(
        '$baseUrl/api/get-stress/$userId',
      ),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 &&
        data['success']) {

      return data;

    } else {

      return {
        'success': false,
      };
    }

  } catch (e) {

    return {
      'success': false,
    };
  }
}

  // ============ PERHITUNGAN REKOMENDASI =========
  Future<Map<String, dynamic>> saveLifestyle({
    required int userId,
    required String aktivitasKategori,
    required String dietKategori,
    required String tidurKategori,
    required String stresKategori,
    required int skorTotal,
    required String kategoriAkhir,
    required String rekomendasi,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/save-lifestyle'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "user_id": userId,
          "aktivitas_kategori": aktivitasKategori,
          "diet_kategori": dietKategori,
          "tidur_kategori": tidurKategori,
          "stres_kategori": stresKategori,
          "skor_total": skorTotal,
          "kategori_akhir": kategoriAkhir,
          "rekomendasi": rekomendasi,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {'success': true, ...data};
      } else {
        return {'success': false, 'message': data['message']};
      }
    } catch (e) {
      return {'success': false, 'message': 'Gagal koneksi'};
    }
  }

  Future<Map<String,dynamic>> getToday(
    int userId,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/today/$userId'),
      );

      final json = jsonDecode(response.body);

      if (response.statusCode == 200 &&
          json['success'] == true) {
        // return data;
        final data = json['data'] ?? {};
        return {
          "success":true,
          "aktivitas": data['aktivitas'] ?? 0,
          "diet": data['diet'] ?? 0,
          "tidur": data['tidur'] ?? 0,
          "stres": data['stres'] ?? 0,
        };
      }

      return {
        'success': false,
        'aktivitas': 0,
        'diet': 0,
        'tidur': 0,
        'stres': 0,
      };
    } catch (e) {
      print("ERROR GET TODAY: $e");

      return {
        'success': false,
        'aktivitas': 0,
        'diet': 0,
        'tidur': 0,
        'stres': 0,
      };
    }
  }

  // ================= TODAY REPORT =================

  Future<Map<String, dynamic>> getTodayReport(
    int userId,
  ) async {

    try {

      final response = await http.get(
        Uri.parse(
          '$baseUrl/api/today-report/$userId',
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );


      final data = jsonDecode(response.body);


      if (response.statusCode == 200 &&
          data['success'] == true) {

        return data;

      }


      return {
        "success": false,
        "score": 0,
        "status": "Belum Ada Data",
        "conclusion": "",
      };


    } catch(e){

      print(
        "ERROR TODAY REPORT : $e"
      );


      return {
        "success": false,
        "score":0,
        "status":"Belum Ada Data",
        "conclusion":"",
      };

    }
  }

  Future<Map<String, dynamic>> getHistory(
    int userId,
  ) async {
    try {

      final response = await http.get(
        Uri.parse('$baseUrl/api/history/$userId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      final data = jsonDecode(response.body);

      // print("HISTORY RESPONSE: $data");

      if (response.statusCode == 200 &&
          data['success'] == true) {

        return {
          'success': true,
          'data': List<Map<String, dynamic>>.from(
            data['data'],
          ),
        };
      }

      return {
        'success': false,
        'data': [],
      };

    } catch (e) {

      print("ERROR GET HISTORY: $e");

      return {
        'success': false,
        'data': [],
      };
    }
  }

  Future<Map<String, dynamic>> getPsikolog(String kota) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/api/psikolog?kota=$kota'),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'data': data['data'],
        };
      } else {
        return {
          'success': false,
          'data': [],
        };
      }
    } catch (e) {
      return {
        'success': false,
        'data': [],
      };
    }
  }

  Future<Map<String, dynamic>?> uploadProfilePhoto({
    required int userId,
    required File imageFile,
  }) async {
    try {

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUrl/upload_profile_photo'),
      );

      request.fields['user_id'] = userId.toString();

      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          imageFile.path,
        ),
      );

      var response = await request.send();

      if (response.statusCode == 200) {

        final responseBody =
            await response.stream.bytesToString();

        return jsonDecode(responseBody);

      } else {

        print("Upload gagal: ${response.statusCode}");
        return null;

      }

    } catch (e) {

      print("Error upload foto: $e");
      return null;

    }
  }
  
  Future<void> logout() async {
    await http.post(Uri.parse('$baseUrl/api/logout'));
  }

}
