import 'package:flutter/material.dart';
import 'package:shopping_app2/models/product.dart';
import 'package:shopping_app2/widgets/feeds_products.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/Feeds';

  List<Product> _products = [
    Product(
      productId: 'Samsung',
      title: 'Samsung galaxy 59',
      description:
          'Samsung Galaxy 59 G968U unlocked GSP 4G LTE phone w/ 12mp Camera - midnight Black',
      price: 5900.00,
      imageUrl: 'assets/images/samsung.jpg',
      brand: 'Samsung',
      productCategoryName: 'Phones',
      quantity: 65,
      isPopular: false,
    ),
    Product(
      productId: 'Samsung Galaxy A10s',
      title: 'Samsung galaxy A10s',
      description:
          'Samsung Galaxy 59 G968U unlocked GSP 4G LTE phone w/ 13+2mp dual Camera - midnight Black',
      price: 30000.00,
      imageUrl: 'assets/images/samsung.jpg',
      brand: 'Samsung',
      productCategoryName: 'Phones',
      quantity: 10,
      isPopular: false,
    ),
    Product(
      productId: 'Infinix',
      title: 'Infinix hot4',
      description:
          'Infinix hot4 G968U unlocked GSP 4G LTE phone w/ 12mp Camera - midnight Black',
      price: 10000.00,
      imageUrl: 'assets/images/CatPhones.png',
      brand: 'Samsung',
      productCategoryName: 'Phones',
      quantity: 2,
      isPopular: false,
    ),
    Product(
      productId: 'Apple',
      title: 'Apple',
      description:
          'Samsung Galaxy 59 G968U unlocked GSP 4G LTE phone w/ 12mp Camera - midnight Black',
      price: 5900.00,
      imageUrl: 'assets/images/apple.jpg',
      brand: 'Apple',
      productCategoryName: 'Phones',
      quantity: 65,
      isPopular: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 230 / 400,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        children: List.generate(
          _products.length,
          (index) {
            return FeedsProduct(
              productId: _products[index].productId,
              description: _products[index].description,
              price: _products[index].price,
              imageUrl: _products[index].imageUrl,
              quantity: _products[index].quantity,
              isFavorite: _products[index].isFavorite,
            );
          },
        ),
      ),

      // body: StaggeredGridView.countBuilder(
      //   padding: EdgeInsets.all(8.0),
      //   crossAxisCount: 6,
      //   itemBuilder: (BuildContext context, int index) => FeedsProduct(),
      //   staggeredTileBuilder: (int index) =>
      //       StaggeredTile.count(3, index.isEven ? 4 : 5),
      //   mainAxisSpacing: 6.0,
      //   crossAxisSpacing: 8.0,
      // ),
    );
  }
}
