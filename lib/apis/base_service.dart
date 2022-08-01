import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:ecommerce_app/model/model.dart';

class BaseService {
  // final String baseUrl =
  //     'https://run.mocky.io/v3/654bd15e-b121-49ba-a588-960956b15175';

  static Future<BaseRepository> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://run.mocky.io/v3/bb1be4f8-309f-4d5a-a1d3-f4ac045ce5fb'));

    if (response.statusCode == 200) {
      final decodedString = jsonDecode(response.body) as Map<String, dynamic>;
      final result = BaseRepository.fromJson(decodedString);

      debugPrint('First Item = ${result.homeStore?.first}');
      debugPrint('First Item = ${result.bestSeller?.first}');
      return result;
    } else {
      throw Exception(
          'Failed to load data. StatusCode = ${response.statusCode}');
    }
  }
}

