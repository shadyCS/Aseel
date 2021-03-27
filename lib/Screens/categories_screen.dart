import 'package:flutter/material.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/categories_grid.dart';

class CategoriesScreen extends StatelessWidget {
  static const String id = 'CategoriesScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MyShop')),
        drawer: AppDrawer(),
        body: CategoryGird());
  }
}
