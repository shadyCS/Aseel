import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/orders.dart' show Orders;
import 'package:shop_app/Providers/products.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const String id = 'OrdersScreen';

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context, listen: false)
          .fetchAndSetOrders()
          .then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orders.orders.length,
              itemBuilder: (context, index) => OrderItem(
                orderItem: orders.orders[index],
              ),
            ),
    );
  }
}
