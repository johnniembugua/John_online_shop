import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app2/consts/colors.dart';
import 'package:shopping_app2/consts/my_icons.dart';
import 'package:shopping_app2/provider/cart_provider.dart';
import 'package:shopping_app2/services/global_method.dart';
import 'package:shopping_app2/widgets/cart_empty.dart';
import 'package:shopping_app2/widgets/cart_full.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/CartScreen';
  const CartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalMethod globalMethod = GlobalMethod();
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCartItems.isEmpty
        ? Scaffold(
            body: CartEmpty(),
          )
        : Scaffold(
            bottomSheet: checkoutSection(context, cartProvider.totalAmount),
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text('Cart (${cartProvider.getCartItems.length})'),
              actions: [
                IconButton(
                    icon: Icon(MyAppIcons.trash),
                    onPressed: () {
                      globalMethod.showDialogg(
                          'Clear cart!',
                          'Your Cart Will be cleared',
                          () => cartProvider.clearCart(),
                          context);
                    })
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: ListView.builder(
                itemBuilder: (BuildContext ctx, int index) {
                  return ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values.toList()[index],
                      child: CartFull(
                        productId:
                            cartProvider.getCartItems.keys.toList()[index],
                      ));
                },
                itemCount: cartProvider.getCartItems.length,
              ),
            ),
          );
  }

  Widget checkoutSection(BuildContext ctx, double subTotal) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [
                      ColorsConsts.gradiendLStart,
                      ColorsConsts.gradiendLEnd,
                    ],
                    stops: [
                      0.0,
                      0.7,
                    ],
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {},
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Checkout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(ctx).textSelectionColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Text(
              'Total',
              style: TextStyle(
                color: Theme.of(ctx).textSelectionColor,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'Ksh ${subTotal.toStringAsFixed(3)}',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
