import 'package:flutter/material.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/screens/auth-screen.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/edit_product_screen.dart';
import 'package:shopapp/screens/product_detail_screen.dart';
import 'package:shopapp/screens/user_products_screen.dart';
import './screens/products_overview_screen.dart';
import './providers/products.dart';
import 'package:provider/provider.dart';
import './screens/orders_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //ability to add multiple providers at root of app 
    return MultiProvider(providers: [
      ChangeNotifierProvider.value(
        value: Products(),
      ),
      ChangeNotifierProvider.value(
        value: Cart(),
      ),
      ChangeNotifierProvider.value(
        value: Orders(),
      )

    ],
        child: MaterialApp(
        title: 'MySHOP',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.deepPurple,
          fontFamily: 'Lato',
        ),
        home:AuthScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => 
          ProductDetailScreen(),
          //adding cartscreen route
          CartScreen.routeName: (ctx) => 
          CartScreen(),
          OrdersScreen.routeName: (ctx) => 
          OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => 
          UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => 
          EditProductScreen(),
          ProductsOverviewScreen.routeName: (ctx) =>
          ProductsOverviewScreen(),

        },
      ),
    );
  }
}
