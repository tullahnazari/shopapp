import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/widgets/product_grid.dart';
//adding enum for selection
enum FilterOptions {
    Favorites, 
    All,
  }

class ProductsOverviewScreen extends StatefulWidget {


  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {

  var _showOnlyFavories = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        //adding vertical elipsis menu
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                
              if ( selectedValue == FilterOptions.Favorites) {
                _showOnlyFavories = true;

              } else {
                _showOnlyFavories = false;

              }
              });   
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'), value: FilterOptions.Favorites),
                PopupMenuItem(
                  child: Text('Show All'), value: FilterOptions.All),
            ],
          ),
            ],
      ),
      body: ProductsGrid(_showOnlyFavories),
      
    );
  }
}

