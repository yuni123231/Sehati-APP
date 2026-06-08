import 'dart:convert';
import 'package:http/http.dart' as http;

class UsdaService {
  static const String apiKey = "wbbghPfQD95MKrcz9tZKTmYGvoDjvY6dfi4MdqqV";

  Future<List<Map<String, dynamic>>> searchFoods(String query) async {
    final url = Uri.parse(
      "https://api.nal.usda.gov/fdc/v1/foods/search?query=$query&api_key=$apiKey&pageSize=20",
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<Map<String, dynamic>>.from(data['foods']);
    } else {
      throw Exception("Gagal mengambil data dari USDA");
    }
  }
}