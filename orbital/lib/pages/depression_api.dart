import 'package:http/http.dart' as http;
import 'dart:convert';

class DepressionAPI {
  Future<List<dynamic>> fetchDepressionData() async {
    final url = 'https://www.nimh.nih.gov/api/content/condition/depression';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load depression data');
    }
  }
}
