import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/constants.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.products,
      @required this.dateTime});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url =
        'https://myshopapp-cd82e-default-rtdb.firebaseio.com/orders.json';
    final timestamp = DateTime.now();

    var response = await post(Uri.parse(url),
        body: jsonEncode({
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'userId': userID,
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price
                  })
              .toList()
        }));
    _orders.insert(
      0,
      OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartProducts,
          dateTime: timestamp),
    );
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    const url =
        'https://myshopapp-cd82e-default-rtdb.firebaseio.com/orders.json';
    final response = await get(Uri.parse(url));
    final List<OrderItem> loadedOrders = [];
    final extractedData = jsonDecode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderID, orderData) {
      if (userID == orderData['userId']) {
        loadedOrders.add(OrderItem(
            id: orderID,
            amount: orderData['amount'],
            dateTime: DateTime.parse(orderData['dateTime']),
            products: (orderData['products'] as List<dynamic>)
                .map((item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    quantity: item['quantity'],
                    title: item['title']))
                .toList()));
      }
    });
    _orders = loadedOrders;
    notifyListeners();
  }
}
