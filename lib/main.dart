import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Providers/cart.dart';
import 'package:shop_app/Providers/categories.dart';
import 'package:shop_app/Providers/orders.dart';
import 'package:shop_app/Providers/user_category.dart';
import 'package:shop_app/Screens/cart_screen.dart';
import 'package:shop_app/Screens/categories_screen.dart';
import 'package:shop_app/Screens/edit_product_screen.dart';
import 'package:shop_app/Screens/home_screen.dart';
import 'package:shop_app/Screens/login_screen.dart';
import 'package:shop_app/Screens/orders_screen.dart';
import 'package:shop_app/Screens/product_detail_screen.dart';
import 'package:shop_app/Screens/products_overview_screen.dart';
import 'package:shop_app/Screens/signup_screen.dart';
import 'package:shop_app/Screens/user_product_screen.dart';
import './Providers/products.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Products()),
        ChangeNotifierProvider(create: (context) => Cart()),
        ChangeNotifierProvider(create: (context) => Orders()),
        ChangeNotifierProvider(create: (context) => UserCategory()),
        ChangeNotifierProvider(create: (context) => Categories()),
      ],
      child: MaterialApp(
        title: 'Wholesale App',
        theme: ThemeData(
            primarySwatch: Colors.blueGrey,
            accentColor: Colors.deepOrange,
            brightness: Brightness.dark),
        initialRoute: HomeScreen.id,
        routes: {
          HomeScreen.id: (conext) => HomeScreen(),
          ProductsOverviewScreen.id: (context) => ProductsOverviewScreen(),
          ProductDetailScreen.id: (context) => ProductDetailScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          SignUpScreen.id: (context) => SignUpScreen(),
          CartScreen.id: (context) => CartScreen(),
          OrdersScreen.id: (context) => OrdersScreen(),
          UserProductsScreen.id: (context) => UserProductsScreen(),
          EditProductScreen.id: (context) => EditProductScreen(),
          CategoriesScreen.id: (context) => CategoriesScreen(),
        },
      ),
    );
  }
}
