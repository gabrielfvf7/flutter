import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite(String token, String userId) async {
    final url =
        'https://shopapp-d2eca.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(url, body: json.encode(!isFavorite));
      if (response.statusCode >= 400) {
        throw Error();
      } else {
        isFavorite = !isFavorite;
        notifyListeners();
      }
    } catch (error) {}
  }
}
