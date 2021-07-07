import 'package:flutter/material.dart';

import 'package:shopping_app2/widgets/wishlist_empty.dart';
import 'package:shopping_app2/widgets/wishlist_full.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  const WishlistScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List wishList = [];
    return wishList.isEmpty
        ? Scaffold(
            body: WishListEmpty(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('WishList ()'),
            ),
            body: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext ctx, int index) {
                  return WishlistFull();
                }),
          );
  }
}
