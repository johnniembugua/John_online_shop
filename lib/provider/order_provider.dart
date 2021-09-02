import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopping_app2/models/order_attr.dart';
import 'package:shopping_app2/models/product.dart';

class OrdersProvider with ChangeNotifier {
  List<OrdersAttr> _orders = [];
  List<OrdersAttr> get getOrders {
    return [..._orders];
  }

  Future<void> fetchOrders() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    User _user = _auth.currentUser;
    var _uid = _user.uid;
    print('the user Id is equal to $_uid');
    await FirebaseFirestore.instance
        .collection('order')
        .where('userId', isEqualTo: _uid)
        .get()
        .then((QuerySnapshot ordersSnapShot) {
      _orders.clear();
      ordersSnapShot.docs.forEach((element) {
        _orders.insert(
            0,
            OrdersAttr(
              orderId: element.get('orderId'),
              userId: element.get('userId'),
              productId: element.get('productId'),
              title: element.get('title'),
              imageUrl: element.get('imageUrl'),
              price: element.get('price'.toString()),
              quantity: element.get('quantity'.toString()),
              orderDate: element.get('orderDate'),
            ));
      });
    });
  }
}
