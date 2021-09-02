import 'package:flutter/material.dart';

class CartAttr with ChangeNotifier {
  final String id;
  final String productId;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  CartAttr({
    @required this.productId,
    this.quantity,
    this.id,
    this.title,
    this.imageUrl,
    this.price,
  });
}
