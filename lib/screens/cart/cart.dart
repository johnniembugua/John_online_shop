import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app2/consts/colors.dart';
import 'package:shopping_app2/consts/my_icons.dart';
import 'package:shopping_app2/provider/cart_provider.dart';
import 'package:shopping_app2/services/global_method.dart';
import 'package:shopping_app2/services/payment.dart';
import 'package:uuid/uuid.dart';

import 'cart_empty.dart';
import 'cart_full.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/CartScreen';
  const CartScreen({Key key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  var response;

  Future<void> payWithCard(int amount) async {
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(message: 'Please wait ...');
    await dialog.show();
    response = await StripeService.payWithCard(
        currency: 'USD', amount: amount.toString());
    await dialog.hide();
    print('response: ${response.success}');

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1500 : 3000),
    ));
  }

  GlobalMethod globalMethod = GlobalMethod();
  @override
  Widget build(BuildContext context) {
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
    final cartProvider = Provider.of<CartProvider>(context);
    var uuid = Uuid();
    final FirebaseAuth _auth = FirebaseAuth.instance;
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
                    onTap: () async {
                      double amountInCents = subTotal * 1000;
                      int integerAmount = (amountInCents / 10).ceil();
                      await payWithCard(integerAmount);
                      if (response.success == true) {
                        User user = _auth.currentUser;
                        final _uid = user.uid;
                        cartProvider.getCartItems
                            .forEach((key, orderValue) async {
                          final orderId = uuid.v4();
                          try {
                            await FirebaseFirestore.instance
                                .collection('order')
                                .doc(orderId)
                                .set({
                              'orderId': orderId,
                              'userId': _uid,
                              'productId': orderValue.productId,
                              'title': orderValue.title,
                              'price': orderValue.price * orderValue.quantity,
                              'imageUrl': orderValue.imageUrl,
                              'quantity': orderValue.quantity,
                              'orderDate': Timestamp.now(),
                            });
                          } catch (error) {
                            print('error occured $error');
                          }
                        });
                      } else {
                        globalMethod.authErrorHandle(
                            'Please enter genuine credentials', context);
                      }
                    },
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
