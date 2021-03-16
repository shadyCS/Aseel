import 'package:flutter/material.dart';
import 'package:shop_app/Widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  static const String id = "ProductsOverview";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: ProductsGrid(),
    );
  }
}
