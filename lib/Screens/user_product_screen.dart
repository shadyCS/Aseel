import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/products.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';
import 'package:shop_app/Widgets/app_drawer.dart';
import 'package:shop_app/Widgets/user_product_item.dart';

class UserProductsScreen extends StatefulWidget {
  static const String id = 'UserProductScreen';

  @override
  _UserProductsScreenState createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  var _isInit = true;
  var _isLoading = false;
  Future<void> _refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetMyProducts();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Products>(context, listen: false)
          .fetchAndSetMyProducts()
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
    final products = Provider.of<Products>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your products'),
        actions: [
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.id);
              }),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : RefreshIndicator(
              onRefresh: () => _refreshProduct(context),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: ListView.builder(
                  itemCount: products.items.length,
                  itemBuilder: (context, index) => Column(
                    children: [
                      UserProductItem(
                        id: products.items[index].id,
                        title: products.items[index].title,
                        imageUrl: products.items[index].imageUrl,
                      ),
                      Divider()
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
