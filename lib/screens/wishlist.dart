import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app2/consts/my_icons.dart';
import 'package:shopping_app2/provider/fav_provider.dart';
import 'package:shopping_app2/services/global_method.dart';

import 'package:shopping_app2/widgets/wishlist_empty.dart';
import 'package:shopping_app2/widgets/wishlist_full.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';
  const WishlistScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favsProvider = Provider.of<FavsProvider>(context);
    GlobalMethod globalMethod = GlobalMethod();

    return favsProvider.getFavsItems.isEmpty
        ? Scaffold(
            body: WishListEmpty(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('WishList (${favsProvider.getFavsItems.length})'),
              actions: [
                IconButton(
                    icon: Icon(MyAppIcons.trash),
                    onPressed: () {
                      globalMethod.showDialogg(
                          'Clear wishlist!',
                          'Your Wishlist Will be cleared',
                          () => favsProvider.clearFavs(),
                          context);
                    })
              ],
            ),
            body: ListView.builder(
                itemCount: favsProvider.getFavsItems.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return ChangeNotifierProvider.value(
                      value: favsProvider.getFavsItems.values.toList()[index],
                      child: WishlistFull(
                        productId:
                            favsProvider.getFavsItems.keys.toList()[index],
                      ));
                }),
          );
  }
}
