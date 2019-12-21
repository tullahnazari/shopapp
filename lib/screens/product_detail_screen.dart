import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/providers/products.dart';

import 'cart_screen.dart';
import 'orders_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/product-detail';

  @override
  Widget build(BuildContext context) {
    
    final cart = Provider.of<Cart>(context, listen: false);
    final productId =
        ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Products>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(loadedProduct.title),
      ),
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            SizedBox(height: 20,),
            Container(
              width: double.infinity,
              height: 300,
              child: Image.network(loadedProduct.imageUrl,
              fit: BoxFit.cover,),
            ),
            SizedBox(height: 10,),
            Text('\$${loadedProduct.price}', 
            style: TextStyle(color: Colors.grey,
            fontSize: 20),),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(loadedProduct.description, 
              textAlign: TextAlign.center,
              softWrap: true,),
            ), 
            SizedBox(height: 10,),
            Container(
              child: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              //Forwarding item data to cart screen
              cart.addItem(loadedProduct.id, loadedProduct.price, loadedProduct.title);
              Flushbar(
                  message: "Successfully added ${loadedProduct.title} to Cart",
                  mainButton: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                child: Text(
                    "Go To Cart",
                style: TextStyle(color: Theme.of(context).accentColor),
                  ),
                    ),
                  backgroundColor: Theme.of(context).primaryColor,


                  icon: Icon(Icons.check, color: Theme.of(context).accentColor,),

                  duration:  Duration(seconds: 3),              
                )..show(context);
          
            },
            color: Colors.deepOrange,
          ),
            ),
          ],
        ),
      ),
    );

    
  }
}


