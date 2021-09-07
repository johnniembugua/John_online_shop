import 'package:flutter/material.dart';
import 'package:shopping_app2/consts/my_icons.dart';
import 'package:shopping_app2/screens/upload_product_form.dart';

import 'calendar.dart';
import 'cart/cart.dart';
import 'feeds.dart';
import 'home.dart';
import 'search.dart';
import 'user_info.dart';

class BottomBarScreen extends StatefulWidget {
  static const routeName = '/BottomBarScreen';
  const BottomBarScreen({Key key}) : super(key: key);

  @override
  _BottomBarScreenState createState() => _BottomBarScreenState();
}

class _BottomBarScreenState extends State<BottomBarScreen> {
  // List _pages = [
  //   HomeScreen(),
  //   FeedsScreen(),
  //   SearchScreen(),
  //   CartScreen(),
  //   UserInfoScreen(),
  // ];
  List<Map<String, Object>> _pages;
  int _selectedIndex = 0;
  @override
  void initState() {
    _pages = [
      {
        'page': Search(),
        'title': 'Homescreen',
      },
      {
        'page': FeedsScreen(),
        'title': 'FeedsScreen',
      },
      {
        'page': UploadProductForm(),
        'title': 'Calendar',
      },
      {
        'page': CartScreen(),
        'title': 'Cart Screen',
      },
      {
        'page': UserInfoScreen(),
        'title': 'UserInfo',
      },
    ];
    super.initState();
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text(_pages[_selectedIndex]['title']),
        // ),
        body: _pages[_selectedIndex]['page'],
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectedPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Theme.of(context).textSelectionColor,
          selectedItemColor: Colors.purple,
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(MyAppIcons.home),
              tooltip: 'Home',
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(MyAppIcons.feeds),
              tooltip: 'Feeds',
              label: 'Feeds',
            ),
            BottomNavigationBarItem(
              //activeIcon: null,
              icon: Icon(MyAppIcons.add),
              // icon:Icon(Icons.search,color: Colors.transparent,),
              tooltip: 'Add',
              label: 'Add',
            ),
            BottomNavigationBarItem(
              icon: Icon(MyAppIcons.bag),
              tooltip: 'Cart',
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(MyAppIcons.user),
              tooltip: 'Account',
              label: 'Account',
            ),
          ],
        ));
  }
}
