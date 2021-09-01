import 'package:flutter/material.dart';
import 'package:shopping_app2/screens/upload_product_form.dart';
import 'package:shopping_app2/screens/bottom_bar.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/MainScreen';
  const MainScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        BottomBarScreen(),
        UploadProductForm(),
      ],
    );
  }
}
