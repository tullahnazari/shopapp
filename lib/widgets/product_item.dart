import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/screens/product_detail_screen.dart';



class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    //adding provider of cart
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: product.id,
            );
          },
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, child) => IconButton(
                  icon: Icon(
                    product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  ),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    //forward user token for favorite status
                    product.toggleFavoriteStatus(authData.token, authData.userId);
                  },
                ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
            ),
            onPressed: () {
              //Forwarding item data to cart screen
              cart.addItem(product.id, product.price, product.title);
              //if snackbar is already open
              Flushbar(
                  messageText: Text("Added ${product.title} to Cart", style: TextStyle(color: Colors.black),),
                  mainButton: FlatButton(
                  onPressed: () {
                    cart.removeSingleItem(product.id);
                  },
                child: Text(
                    "UNDO", 
                style: TextStyle(color: Colors.black),
                  ),
                    ),
                  backgroundColor: Theme.of(context).primaryColor,


                  icon: Icon(Icons.check, color: Colors.black,),

                  duration:  Duration(seconds: 3),              
                )..show(context);
              // Scaffold.of(context).hideCurrentSnackBar();
              // Scaffold.of(context).showSnackBar(
              //   SnackBar(
              //     content:
              //     Text('Added item to Cart!', textAlign: TextAlign.center,),
              //     duration: Duration(
              //       seconds: 2
              //     ),
              //     action: SnackBarAction(
              //       label: 'UNDO', onPressed: () {
              //         cart.removeSingleItem(product.id);

              //       },
              //     ),
              //     ),
              //     );
            },
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
    );
  }
}
