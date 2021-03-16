import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/Screens/home_screen.dart';
import 'package:shop_app/Screens/login_screen.dart';
import 'package:shop_app/Screens/product_detail_screen.dart';
import 'package:shop_app/Screens/products_overview_screen.dart';
import 'package:shop_app/Screens/signup_screen.dart';
import './Providers/products.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
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
          SignUpScreen.id: (context) => SignUpScreen()
        },
      ),
    );
  }
}
