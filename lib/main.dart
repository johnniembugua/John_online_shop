import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app2/consts/theme_data.dart';
import 'package:shopping_app2/inner_screens/product_detail.dart';

import 'package:shopping_app2/provider/cart_provider.dart';
import 'package:shopping_app2/provider/dark_theme_provider.dart';
import 'package:shopping_app2/provider/fav_provider.dart';
import 'package:shopping_app2/provider/products.dart';
//import 'package:shopping_app2/screens/bottom_bar.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app2/screens/auth/forget_password.dart';
import 'package:shopping_app2/screens/auth/login.dart';
import 'package:shopping_app2/screens/auth/sign_up.dart';
import 'package:shopping_app2/screens/bottom_bar.dart';
import 'package:shopping_app2/screens/cart/cart.dart';
import 'package:shopping_app2/screens/landing_page.dart';
import 'package:shopping_app2/screens/main_screen.dart';
import 'package:shopping_app2/screens/orders/order.dart';
import 'package:shopping_app2/screens/user_state.dart';

import 'inner_screens/brands_navigation_rail.dart';
import 'inner_screens/categories_feeds.dart';
import 'screens/upload_product_form.dart';
import 'screens/cart/cart.dart';
import 'screens/feeds.dart';
import 'screens/wishlist/wishlist.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            MaterialApp(
              home: Scaffold(
                body: Center(
                  child: Text('Error Occured'),
                ),
              ),
            );
          }
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
                ChangeNotifierProvider(
                  create: (_) => FavsProvider(),
                ),
              ],
              child: Consumer<DarkThemeProvider>(
                  builder: (context, themeData, child) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Flutter Demo',
                  theme:
                      Styles.themeData(themeChangeProvider.darkTheme, context),
                  home: UserState(),
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
                    LandingPage.routeName: (ctx) => LandingPage(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                    SignUpScreen.routeName: (ctx) => SignUpScreen(),
                    BottomBarScreen.routeName: (ctx) => BottomBarScreen(),
                    UploadProductForm.routeName: (ctx) => UploadProductForm(),
                    ForgetPassword.routeName: (ctx) => ForgetPassword(),
                    MainScreen.routeName: (ctx) => MainScreen(),
                    OrderScreen.routeName: (ctx) => OrderScreen(),
                  },
                );
              }));
        });
  }
}
