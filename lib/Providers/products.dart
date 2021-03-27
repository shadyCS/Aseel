import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'product.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Products with ChangeNotifier {
  List<Product> _items = [];
  var _showFavorits = false;

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  void showFavoritesOnly() {
    _showFavorits = true;
    notifyListeners();
  }

  void showAll() {
    _showFavorits = false;
    notifyListeners();
  }

  Product findByID(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts([String category = 'All']) async {
    const url =
        'https://myshopapp-cd82e-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await get(Uri.parse(url));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data == null) {
        return;
      }
      final List<Product> loadedProduct = [];
      data.forEach((productID, productData) {
        print(category);
        if ((category == 'All' || category == productData['category']) &&
            userID != productData['userId']) {
          loadedProduct.add(
            Product(
                id: productID,
                title: productData['title'],
                description: productData['description'],
                imageUrl: productData['imageUrl'],
                isFavorite: productData['isFavorite'],
                price: productData['price'],
                userID: productData['userId'],
                category: productData['category'],
                available: productData['available']),
          );
        }
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (ex) {}
  }

  Future<void> fetchAndSetMyProducts() async {
    const url =
        'https://myshopapp-cd82e-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await get(Uri.parse(url));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      if (data == null) {
        return;
      }
      final List<Product> loadedProduct = [];
      data.forEach((productID, productData) {
        if (userID == productData['userId']) {
          loadedProduct.add(
            Product(
                id: productID,
                title: productData['title'],
                description: productData['description'],
                imageUrl: productData['imageUrl'],
                isFavorite: productData['isFavorite'],
                price: productData['price'],
                userID: productData['userId'],
                category: productData['category'],
                available: productData['available']),
          );
        }
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (ex) {}
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://myshopapp-cd82e-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await post(Uri.parse(url),
          body: jsonEncode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
            'userId': userID,
            'category': product.category,
            'available': product.available
          }));
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: jsonDecode(response.body)['name'],
        userID: userID,
      );

      _items.insert(0, newProduct);
      notifyListeners();
    } catch (ex) {}
  }

  Future<void> updateProduct(String id, Product product) async {
    final productIndex = _items.indexWhere((element) => element.id == id);
    if (productIndex >= 0) {
      final url =
          'https://myshopapp-cd82e-default-rtdb.firebaseio.com/products/$id.json';
      try {
        final response = await patch(Uri.parse(url),
            body: jsonEncode({
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'category': product.category,
              'available': product.available
            }));
        _items[productIndex] = product;
        notifyListeners();
      } catch (ex) {}
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        'https://myshopapp-cd82e-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    final existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    try {
      var response = await delete(Uri.parse(url));
      if (response.statusCode >= 400) {
        throw "Somthing went wrong";
      }
      _items.removeWhere((element) => element.id == id);
      notifyListeners();
    } catch (ex) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
    }
  }
}
