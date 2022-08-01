import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_app/model/model.dart';


class CartService {
  final String cartUrl =
      'https://run.mocky.io/v3/53539a72-3c5f-4f30-bbb1-6ca10d42c149';

  Future<Cart> fetchData() async {
    final response = await http.get(Uri.parse(cartUrl));

    if (response.statusCode == 200) {
      final decodedString = jsonDecode(response.body) as Map<String, dynamic>;
      final result = Cart.fromJson(decodedString);

      // debugPrint('Cart id = ${result.id}');

      return result;
    } else {
      throw Exception(
          'Failed to load data. StatusCode = ${response.statusCode}');
    }
  }
}

// main() async {
//   final result = await CartService().fetchData();
//   print(result.basket?[1].title);
// }