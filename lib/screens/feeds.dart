import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopping_app2/widgets/feeds_products.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.count(
        childAspectRatio: 230 / 290,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 2,
        children: List.generate(
          10,
          (index) {
            return FeedsProduct();
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
