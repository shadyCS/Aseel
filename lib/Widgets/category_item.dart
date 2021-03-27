import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/user_category.dart';
import 'package:shop_app/Screens/products_overview_screen.dart';

class CategoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final category = Provider.of<UserCategory>(context);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(ProductsOverviewScreen.id,
                arguments: category.titel);
          },
          child: Image.network(
            category.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          title: Text(
            category.titel,
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
