import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app2/models/product.dart';
import 'package:shopping_app2/provider/products.dart';
import 'package:shopping_app2/widgets/feeds_products.dart';

class FeedsScreen extends StatelessWidget {
  static const routeName = '/Feeds';
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<Products>(context);
    List<Product> productList = productProvider.products;
    return Scaffold(
        body: GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 240 / 400,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      children: List.generate(productList.length, (index) {
        return ChangeNotifierProvider.value(
            value: productList[index], child: FeedsProduct());
      }),
    )
//         StaggeredGridView.countBuilder(
//           padding: ,
//   crossAxisCount: 6,
//   itemCount: 8,
//   itemBuilder: (BuildContext context, int index) =>FeedProducts(),
//   staggeredTileBuilder: (int index) =>
//       new StaggeredTile.count(3, index.isEven ? 4 : 5),
//   mainAxisSpacing: 8.0,
//   crossAxisSpacing: 6.0,
// ),
        );
  }
}
