import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app2/provider/products.dart';

import 'brands_rail_widget.dart';

class BrandNavigationRailScreen extends StatefulWidget {
  BrandNavigationRailScreen({Key key}) : super(key: key);

  static const routeName = '/brands_navigation_rail';
  @override
  _BrandNavigationRailScreenState createState() =>
      _BrandNavigationRailScreenState();
}

class _BrandNavigationRailScreenState extends State<BrandNavigationRailScreen> {
  int _selectedIndex = 0;
  final padding = 8.0;
  String routeArgs;
  String brand;
  @override
  void didChangeDependencies() {
    routeArgs = ModalRoute.of(context).settings.arguments.toString();
    _selectedIndex = int.parse(
      routeArgs.substring(1, 2),
    );
    print(routeArgs.toString());
    if (_selectedIndex == 0) {
      setState(() {
        brand = 'All';
      });
    }
    if (_selectedIndex == 1) {
      setState(() {
        brand = 'Fresh milk';
      });
    }
    if (_selectedIndex == 2) {
      setState(() {
        brand = 'Toned milk';
      });
    }
    if (_selectedIndex == 3) {
      setState(() {
        brand = 'Tetro milk';
      });
    }
    if (_selectedIndex == 4) {
      setState(() {
        brand = 'Farmented milk';
      });
    }
    if (_selectedIndex == 5) {
      setState(() {
        brand = 'Cow milk';
      });
    }
    if (_selectedIndex == 6) {
      setState(() {
        brand = 'Goat milk';
      });
    }
    // if (_selectedIndex == 6) {
    //   setState(() {
    //     brand = 'Huawei';
    //   });
    // }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: NavigationRail(
                      minWidth: 56.0,
                      groupAlignment: 1.0,
                      selectedIndex: _selectedIndex,
                      onDestinationSelected: (int index) {
                        setState(() {
                          _selectedIndex = index;
                          if (_selectedIndex == 0) {
                            setState(() {
                              brand = 'All';
                            });
                          }
                          if (_selectedIndex == 1) {
                            setState(() {
                              brand = 'Fresh milk';
                            });
                          }
                          if (_selectedIndex == 2) {
                            setState(() {
                              brand = 'Toned milk';
                            });
                          }
                          if (_selectedIndex == 3) {
                            setState(() {
                              brand = 'Tetro milk';
                            });
                          }
                          if (_selectedIndex == 4) {
                            setState(() {
                              brand = 'Farmented milk';
                            });
                          }
                          if (_selectedIndex == 5) {
                            setState(() {
                              brand = 'Cow milk';
                            });
                          }
                          if (_selectedIndex == 6) {
                            setState(() {
                              brand = 'Goat milk';
                            });
                          }
                          // if (_selectedIndex == 6) {
                          //   setState(() {
                          //     brand = 'Huawei';
                          //   });
                          // }

                          print(brand);
                        });
                      },
                      labelType: NavigationRailLabelType.all,
                      leading: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: CircleAvatar(
                              radius: 16,
                              backgroundImage: AssetImage(
                                'assets/images/farmented2.png',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      selectedLabelTextStyle: TextStyle(
                        color: Color(0xffffe6bc97),
                        fontSize: 20,
                        letterSpacing: 1,
                        decoration: TextDecoration.underline,
                        decorationThickness: 2.5,
                      ),
                      unselectedLabelTextStyle: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0.8,
                      ),
                      destinations: [
                        buildRotatedTextRailDestination("All", padding),
                        buildRotatedTextRailDestination('Fresh', padding),
                        buildRotatedTextRailDestination("Toned", padding),
                        buildRotatedTextRailDestination("Tetro", padding),
                        buildRotatedTextRailDestination("Farmented", padding),
                        buildRotatedTextRailDestination("Cow", padding),
                        buildRotatedTextRailDestination("Goat", padding),
                        // buildRotatedTextRailDestination("Huawei", padding),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          // This is the main content.

          ContentSpace(context, brand)
        ],
      ),
    );
  }
}

NavigationRailDestination buildRotatedTextRailDestination(
    String text, double padding) {
  return NavigationRailDestination(
    icon: SizedBox.shrink(),
    label: Padding(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: RotatedBox(
        quarterTurns: -1,
        child: Text(text),
      ),
    ),
  );
}

class ContentSpace extends StatelessWidget {
  // final int _selectedIndex;

  final String brand;
  ContentSpace(BuildContext context, this.brand);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final productsBrands = productData.findByCategory(brand);
    if (brand == 'All') {
      for (int i = 0; i < productData.products.length; i++) {
        productsBrands.add(productData.products[i]);
      }
    }
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 0, 0),
        child: MediaQuery.removePadding(
          removeTop: true,
          context: context,
          child: productsBrands.isEmpty
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Feather.database,
                      size: 40,
                    ),
                    SizedBox(height: 40),
                    Text(
                      'No products for this brand',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    )
                  ],
                )
              : ListView.builder(
                  itemCount: productsBrands.length,
                  itemBuilder: (BuildContext context, int index) =>
                      ChangeNotifierProvider.value(
                          value: productsBrands[index],
                          child: BrandsNavigationRail()),
                ),
        ),
      ),
    );
  }
}
