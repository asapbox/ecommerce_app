import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/model/model.dart';

class ItemService {
  final String itemUrl =
      'https://run.mocky.io/v3/6c14c560-15c6-4248-b9d2-b4508df7d4f5';

  Future<Item> fetchData() async {
    final response = await http.get(Uri.parse(itemUrl));

    if (response.statusCode == 200) {
      final decodedString = jsonDecode(response.body) as Map<String, dynamic>;
      final result = Item.fromJson(decodedString);

     debugPrint('Item title = ${result.title}');

      return result;
    } else {
      throw Exception(
          'Failed to load data. StatusCode = ${response.statusCode}');
    }
  }
}

main() async {
  final result = await ItemService().fetchData();
print(result.colors);
}