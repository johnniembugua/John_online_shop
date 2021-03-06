import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

import 'package:shopping_app2/inner_screens/brands_navigation_rail.dart';
import 'package:shopping_app2/provider/products.dart';
import 'package:shopping_app2/screens/feeds.dart';

import 'package:shopping_app2/widgets/category.dart';
import 'package:shopping_app2/widgets/custom_text.dart';
import 'package:shopping_app2/widgets/popular_products.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List _couroselImages = [
  //   'assets/images/CatBeauty.jpg',
  //   'assets/images/CatClothes.jpg',
  //   'assets/images/CatWatches.jpg',
  //   'assets/images/CatShoes.jpg',
  //   'assets/images/Huawei.jpg',
  // ];
  List _brandImages = [
    'assets/images/cow-milk.jpg',
    'assets/images/Toned2.jpeg',
    'assets/images/Tetro.jpg',
    'assets/images/farmented.jpg',
    'assets/images/goat3.jpg',
    'assets/images/goat-milk.jpg',
    // 'assets/images/Huawei.jpg',

    //'assets/images/Huawei.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    productData.fetchProducts();
    final popularItems = productData.popularProducts;
    return
        // Scaffold(
        //   body:
        // BackdropScaffold(
        //   frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        //   headerHeight: MediaQuery.of(context).size.height * 0.25,
        //   appBar: BackdropAppBar(
        //     title: Text('Home'),
        //     leading: BackdropToggleButton(
        //       icon: AnimatedIcons.home_menu,
        //     ),
        //     flexibleSpace: Container(
        //       decoration: BoxDecoration(
        //           gradient: LinearGradient(colors: [
        //         ColorsConsts.starterColor,
        //         ColorsConsts.endColor
        //       ])),
        //     ),
        //     actions: [
        //       IconButton(
        //           iconSize: 15,
        //           padding: EdgeInsets.all(10),
        //           icon: CircleAvatar(
        //             radius: 15,
        //             backgroundColor: Colors.white,
        //             child: CircleAvatar(
        //               radius: 13,
        //               backgroundImage: AssetImage('assets/images/CatLaptops.png'),
        //             ),
        //           ),
        //           onPressed: () {})
        //     ],
        //   ),
        //   backLayer: BackLayerMenu(),
        //   frontLayer:
        //   SingleChildScrollView(
        // child:
        Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 180,
          margin: const EdgeInsets.only(
            left: 15,
            right: 15,
            top: 10,
            bottom: 10,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.green,
          ),
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: CustomText(
                            text: 'Set Schedule for your repeated delivery',
                            maxlines: 2,
                            color: Colors.white,
                            size: 20,
                            weight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Flexible(
                          child: CustomText(
                            text:
                                'Get them delivered everyday to your doorstep',
                            maxlines: 2,
                            color: Colors.white,
                            size: 18,
                            weight: FontWeight.w300,
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {},
                          child: Text(
                            'Know more',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: AssetImage('assets/images/fresh.jpg'),
                        fit: BoxFit.cover,
                      )),
                    ))
              ],
            ),
          ),
        ),
        // Container(
        //   height: 190.0,
        //   width: double.infinity,
        //   child: Carousel(
        //     boxFit: BoxFit.fill,
        //     autoplay: true,
        //     animationCurve: Curves.fastOutSlowIn,
        //     animationDuration: Duration(milliseconds: 1000),
        //     dotSize: 5.0,
        //     dotIncreasedColor: Colors.purple,
        //     dotBgColor: Colors.black.withOpacity(0.2),
        //     dotPosition: DotPosition.bottomCenter,
        //     showIndicator: true,
        //     indicatorBgPadding: 5.0,
        //     images: [
        //       ExactAssetImage(_couroselImages[0]),
        //       ExactAssetImage(_couroselImages[1]),
        //       ExactAssetImage(_couroselImages[2]),
        //       ExactAssetImage(_couroselImages[3]),
        //     ],
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Categories',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
          ),
        ),
        Container(
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            itemCount: 6,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext ctx, int index) {
              return CategoryWidget(
                index: index,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Popular Brands',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    BrandNavigationRailScreen.routeName,
                    arguments: {
                      0,
                    },
                  );
                },
                child: Text(
                  'View all...',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.red),
                ),
              )
            ],
          ),
        ),
        Container(
          height: 210,
          width: MediaQuery.of(context).size.width * 0.95,
          child: Swiper(
            itemCount: _brandImages.length,
            autoplay: true,
            viewportFraction: 0.8,
            scale: 0.9,
            onTap: (index) {
              Navigator.of(context).pushNamed(
                BrandNavigationRailScreen.routeName,
                arguments: {
                  index,
                },
              );
            },
            itemBuilder: (BuildContext ctx, int index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Colors.blueGrey,
                  child: Image.asset(
                    _brandImages[index],
                    fit: BoxFit.fill,
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                'Popular Products',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
              ),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(FeedsScreen.routeName, arguments: 'popular');
                },
                child: Text(
                  'View all...',
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                      color: Colors.red),
                ),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 285,
          margin: EdgeInsets.symmetric(horizontal: 3),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularItems.length,
              itemBuilder: (BuildContext ctx, int index) {
                return ChangeNotifierProvider.value(
                  value: popularItems[index],
                  child: PopularProducts(
                      /* imageUrl: popularItems[index].imageUrl,
                          title: popularItems[index].title,
                          description: popularItems[index].description,
                          price: popularItems[index].price, */
                      ),
                );
              }),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10),
          width: double.infinity,
          // height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.green,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Flexible(
                  child: Text(
                    'Order before 2pm and get deiver by 8pm the same day or Order by 12midnight and get deliver by 8 AM the next day',
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.green),
                  ),
                )
              ],
            ),
          ),
        )
      ],
      //),

      //   ),
    );
  }
}
