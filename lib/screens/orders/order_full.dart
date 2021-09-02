import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app2/consts/colors.dart';
import 'package:shopping_app2/inner_screens/product_detail.dart';
import 'package:shopping_app2/models/cart_attr.dart';
import 'package:shopping_app2/models/order_attr.dart';
import 'package:shopping_app2/provider/cart_provider.dart';
import 'package:shopping_app2/provider/dark_theme_provider.dart';
import 'package:shopping_app2/provider/order_provider.dart';
import 'package:shopping_app2/services/global_method.dart';

class OrderFull extends StatefulWidget {
  const OrderFull({Key key}) : super(key: key);

  @override
  _OrderFullState createState() => _OrderFullState();
}

class _OrderFullState extends State<OrderFull> {
  GlobalMethod globalMethod = GlobalMethod();
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final themeChange = Provider.of<DarkThemeProvider>(context);
    final orderAttr = Provider.of<OrdersAttr>(context);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ProductDetails.routeName,
            arguments: orderAttr.productId);
      },
      child: Container(
        height: 150.0,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: const Radius.circular(16.0),
            bottomLeft: const Radius.circular(16.0),
          ),
          color: Theme.of(context).backgroundColor,
        ),
        child: Row(
          children: [
            Container(
              //margin: EdgeInsets.all(8),
              width: 130,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(orderAttr.imageUrl),
                  //fit: BoxFit.fill,
                ),
              ),
            ),
            Flexible(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              orderAttr.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(32.0),
                              onTap: () {
                                // globalMethod.showDialogg(
                                //     'Remove item!',
                                //     'Product will be removed from the cart',
                                //     () => cartProvider
                                //         .removeItem(orderAttr.productId),
                                //     context);
                              },
                              //splashColor: ,
                              child: Container(
                                height: 50,
                                width: 50,
                                child: Icon(
                                  Entypo.cross,
                                  color: Colors.red,
                                  size: 22,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text('Price'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Ksh ${orderAttr.price}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text('Quantity'),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${orderAttr.quantity}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Flexible(child: Text('Order Id')),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              '${orderAttr.orderId}',
                              style: TextStyle(
                                  fontSize: 10, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}