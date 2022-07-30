import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/best_seller.dart';
import '../model/base_repository.dart';

class BaseService {
  final String baseUrl =
      'https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175';

  Future<baseRepository> fetchData() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final decodedString = jsonDecode(response.body) as Map<String, dynamic>;

      return baseRepository.fromJson(decodedString);
    } else {
      throw Exception(
          'Failed to load data. StatusCode = ${response.statusCode}');
    }
  }
}
