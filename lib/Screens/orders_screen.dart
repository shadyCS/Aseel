import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/orders.dart' show Orders;
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const String id = 'OrdersScreen';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: ListView.builder(
        itemCount: orders.orders.length,
        itemBuilder: (context, index) => OrderItem(
          orderItem: orders.orders[index],
        ),
      ),
    );
  }
}
