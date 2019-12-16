import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageurl;

  UserProductItem(this.id, this.title, this.imageurl);

  @override
  Widget build(BuildContext context) {
    //if running to context issues with scaffold
    final scaffold = Scaffold.of(context);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageurl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit), onPressed: () {
                    Navigator.of(context).pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete), onPressed: () async {
                try {
                await Provider.of<Products>(context, listen: false)
                .deleteProduct(id);
                } catch (error) {
                  scaffold.showSnackBar(SnackBar(
                    content: Text('Error in deleting, please try again', textAlign: TextAlign.center,),
                    backgroundColor: Colors.redAccent,
                  ));

                }

              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
      
    );
  }
}