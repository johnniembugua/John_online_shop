import 'package:flutter/cupertino.dart';
import 'package:shopping_app2/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [
    Product(
      productId: 'Samsung',
      title: 'Samsung galaxy 59',
      description:
          'Samsung Galaxy 59 G968U unlocked GSP 4G LTE phone w/ 12mp Camera - midnight Black',
      price: 5900.00,
      imageUrl: 'assets/images/samsung.jpg',
      brand: 'Samsung',
      productCategoryName: 'Phones',
      quantity: 65,
      isPopular: false,
    ),
    Product(
      productId: 'Samsung Galaxy A10s',
      title: 'Samsung galaxy A10s',
      description:
          'Samsung Galaxy 59 G968U unlocked GSP 4G LTE phone w/ 13+2mp dual Camera - midnight Black',
      price: 30000.00,
      imageUrl: 'assets/images/Huawei.jpg',
      brand: 'Samsung',
      productCategoryName: 'Phones',
      quantity: 10,
      isPopular: false,
    ),
    Product(
      productId: 'Infinix',
      title: 'Infinix hot4',
      description:
          'Infinix hot4 G968U unlocked GSP 4G LTE phone w/ 12mp Camera - midnight Black',
      price: 10000.00,
      imageUrl: 'assets/images/CatPhones.png',
      brand: 'Samsung',
      productCategoryName: 'Phones',
      quantity: 2,
      isPopular: false,
    ),
    Product(
      productId: 'Apple',
      title: 'Apple',
      description:
          'Samsung Galaxy 59 G968U unlocked GSP 4G LTE phone w/ 12mp Camera - midnight Black',
      price: 5900.00,
      imageUrl: 'assets/images/apple.jpg',
      brand: 'Apple',
      productCategoryName: 'Phones',
      quantity: 65,
      isPopular: false,
    ),
  ];
  List<Product> get products {
    return [..._products];
  }

  List<Product> findByCategory(String categoryName) {
    List _categoryList = _products
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
    return _categoryList;
  }
}
