import 'package:flutter/material.dart';
import 'package:shop/models/http_exception.dart';
import './product.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  List<Product> _items = [];

  final String authToken;
  final String userId;

  Products(this.authToken, this._items, this.userId);

  List<Product> get items => [..._items];

  List<Product> get favoriteItems =>
      _items.where((element) => element.isFavorite).toList();

  Product findById(String id) =>
      _items.firstWhere((element) => element.id == id);

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((element) => element.id == id);
    if (prodIndex >= 0) {
      final url =
          'https://shopapp-d2eca.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://shopapp-d2eca.firebaseio.com/products/$id.json?auth=$authToken';
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      throw HttpException('Could not delete product');
    } else {
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    }
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? '&orderBy="creatorId"&equalTo="$userId"' : '';
    final url =
        'https://shopapp-d2eca.firebaseio.com/products.json?auth=$authToken$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final favoriteResponse = await http.get(
          'https://shopapp-d2eca.firebaseio.com/userFavorites/$userId.json?auth=$authToken');
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          imageUrl: prodData['imageUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product value) async {
    final url =
        'https://shopapp-d2eca.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': value.title,
          'description': value.description,
          'imageUrl': value.imageUrl,
          'price': value.price,
          'creatorId': userId,
        }),
      );
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          title: value.title,
          description: value.description,
          price: value.price,
          imageUrl: value.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
