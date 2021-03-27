import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/cart.dart' show Cart;
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Screens/orders_screen.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const String id = "CartScreen";
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text('\$${cart.totalAmount.toStringAsFixed(2)}'),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  MaterialButton(
                    child: Text('Order Now'),
                    onPressed: () {
                      final orders =
                          Provider.of<Orders>(context, listen: false);
                      orders.addOrder(
                        cart.items.values.toList(),
                        cart.totalAmount,
                      );
                      cart.clear();
                      Navigator.pushReplacementNamed(context, OrdersScreen.id);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) => CartItem(
                  id: cart.items.values.toList()[index].id,
                  productID: cart.items.keys.toList()[index],
                  price: cart.items.values.toList()[index].price,
                  title: cart.items.values.toList()[index].title,
                  quantity: cart.items.values.toList()[index].quantity),
            ),
          ),
        ],
      ),
    );
  }
}
