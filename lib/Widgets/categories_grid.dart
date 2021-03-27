import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/categories.dart';
import 'package:shop_app/Widgets/category_item.dart';

class CategoryGird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<Categories>(context).categories;

    return categories.isEmpty
        ? Container()
        : GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: categories.length,
            itemBuilder: (context, index) => ChangeNotifierProvider.value(
              value: categories[index],
              child: CategoryItem(),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 5 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 30),
          );
  }
}
