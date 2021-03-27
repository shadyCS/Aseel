import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.imageUrl,
      this.isFavorite = false});

  Future<void> toggleFavoriteStatus() async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://myshopapp-cd82e-default-rtdb.firebaseio.com/products/$id.json';
    try {
      var response = await patch(
        Uri.parse(url),
        body: json.encode(
          {'isFavorite': isFavorite},
        ),
      );
      if (response.statusCode >= 400) {
        throw "Bad Request";
      }
    } catch (ex) {
      isFavorite = oldStatus;
      notifyListeners();
    }
  }
}
