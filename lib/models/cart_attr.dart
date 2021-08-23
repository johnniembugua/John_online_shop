import 'package:flutter/material.dart';

class CartAttr with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  CartAttr({
    this.quantity,
    this.id,
    this.title,
    this.imageUrl,
    this.price,
  });
}
