import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/categories.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/categories_grid.dart';

class CategoriesScreen extends StatefulWidget {
  static const String id = 'CategoriesScreen';

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  var _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Categories>(context).fetchAndSetProducts();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('MyShop')),
        drawer: AppDrawer(),
        body: CategoryGird());
  }
}
