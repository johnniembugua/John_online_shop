import 'package:flutter/material.dart';
import 'package:shopping_app2/consts/theme_data.dart';
import 'package:shopping_app2/inner_screens/product_detail.dart';

import 'package:shopping_app2/provider/cart_provider.dart';
import 'package:shopping_app2/provider/dark_theme_provider.dart';
import 'package:shopping_app2/provider/products.dart';
import 'package:shopping_app2/screens/bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app2/screens/cart.dart';

import 'inner_screens/brands_navigation_rail.dart';
import 'inner_screens/categories_feeds.dart';
import 'screens/cart.dart';
import 'screens/feeds.dart';
import 'screens/wishlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();
  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme =
        await themeChangeProvider.darkThemePreferences.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) {
              return themeChangeProvider;
            },
          ),
          ChangeNotifierProvider(
            create: (_) => Products(),
          ),
          ChangeNotifierProvider(
            create: (_) => CartProvider(),
          ),
        ],
        child:
            Consumer<DarkThemeProvider>(builder: (context, themeData, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(themeChangeProvider.darkTheme, context),
            home: BottomBarScreen(),
            //initialRoute: '/',
            routes: {
              //   '/': (ctx) => LandingPage(),
              BrandNavigationRailScreen.routeName: (ctx) =>
                  BrandNavigationRailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              CategoriesFeedsScreen.routeName: (context) =>
                  CategoriesFeedsScreen(),
              FeedsScreen.routeName: (context) => FeedsScreen(),
              WishlistScreen.routeName: (ctx) => WishlistScreen(),
              ProductDetails.routeName: (ctx) => ProductDetails(),
            },
          );
        }));
  }
}
