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
                  OrderButton(cart: cart),
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

class OrderButton extends StatefulWidget {
  const OrderButton({
    @required this.cart,
  });

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: _isLoading ? CircularProgressIndicator() : Text('Order Now'),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              final orders = Provider.of<Orders>(context, listen: false);
              await orders.addOrder(
                widget.cart.items.values.toList(),
                widget.cart.totalAmount,
              );
              setState(() {
                _isLoading = false;
              });
              widget.cart.clear();
              Navigator.pushReplacementNamed(context, OrdersScreen.id);
            },
    );
  }
}
