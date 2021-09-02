import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app2/consts/colors.dart';
import 'package:shopping_app2/consts/my_icons.dart';
import 'package:shopping_app2/provider/cart_provider.dart';
import 'package:shopping_app2/provider/order_provider.dart';
import 'package:shopping_app2/screens/cart/cart_empty.dart';
import 'package:shopping_app2/screens/cart/cart_full.dart';
import 'package:shopping_app2/services/global_method.dart';
import 'package:shopping_app2/services/payment.dart';

import 'order_empty.dart';
import 'order_full.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/OrderScreen';
  const OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void initState() {
    super.initState();
    StripeService.init();
  }

  void payWithCard(int amount) async {
    ProgressDialog dialog = ProgressDialog(context);
    dialog.style(message: 'Please wait ...');
    await dialog.show();
    var response = await StripeService.payWithCard(
        currency: 'USD', amount: amount.toString());
    await dialog.hide();

    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(response.message),
      duration: Duration(milliseconds: response.success == true ? 1500 : 3000),
    ));
  }

  @override
  Widget build(BuildContext context) {
    GlobalMethod globalMethod = GlobalMethod();
    final orderProvider = Provider.of<OrdersProvider>(context);
    bool isOrder = false;

    return FutureBuilder(
        future: orderProvider.fetchOrders(),
        builder: (context, snapshot) {
          return orderProvider.getOrders.isEmpty
              ? Scaffold(
                  body: OrderEmpty(),
                )
              : Scaffold(
                  appBar: AppBar(
                    backgroundColor: Theme.of(context).backgroundColor,
                    title: Text('Orders (${orderProvider.getOrders.length})'),
                    actions: [
                      IconButton(
                          icon: Icon(MyAppIcons.trash),
                          onPressed: () {
                            // globalMethod.showDialogg(
                            //     'Clear cart!',
                            //     'Your Cart Will be cleared',
                            //     () => cartProvider.clearCart(),
                            //     context);
                          })
                    ],
                  ),
                  body: Container(
                    margin: EdgeInsets.only(bottom: 60),
                    child: ListView.builder(
                      itemBuilder: (BuildContext ctx, int index) {
                        return ChangeNotifierProvider.value(
                            value: orderProvider.getOrders[index],
                            child: OrderFull());
                      },
                      itemCount: orderProvider.getOrders.length,
                    ),
                  ),
                );
        });
  }
}
