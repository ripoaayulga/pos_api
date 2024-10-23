import 'dart:convert';
import 'package:http/http.dart' as http;

class KodePosService {
  final String apiUrl =
      "https://kodepos-2d475.firebaseio.com/list_propinsi.json?print=pretty";

  Future<Map<String, dynamic>> fetchProvinsi() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      // Mengurai body respon JSON menjadi Map
      return json.decode(response.body);
    } else {
      throw Exception('Gagal memuat data provinsi');
    }
  }
}
