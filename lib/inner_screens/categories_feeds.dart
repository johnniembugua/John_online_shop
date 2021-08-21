import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app2/models/product.dart';
import 'package:shopping_app2/provider/products.dart';
import 'package:shopping_app2/widgets/feeds_products.dart';

class CategoriesFeedsScreen extends StatelessWidget {
  static const routeName = '/CategoriesFeedsScreen';

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context, listen: false);
    final categoryName = ModalRoute.of(context).settings.arguments as String;
    final productList = productsProvider.findByCategory(categoryName);
    
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 230 / 400,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        children: List.generate(
          productList.length,
          (index) {
            return ChangeNotifierProvider.value(
                value: productList[index], child: FeedsProduct());
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
