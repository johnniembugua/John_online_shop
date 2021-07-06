import 'package:backdrop/backdrop.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:shopping_app2/consts/colors.dart';
import 'package:shopping_app2/widgets/category.dart';
import 'package:shopping_app2/widgets/popular_products.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List _couroselImages = [
    'assets/images/CatBeauty.jpg',
    'assets/images/CatClothes.jpg',
    'assets/images/CatWatches.jpg',
    'assets/images/CatShoes.jpg',
    'assets/images/Huawei.jpg',
  ];
  List _brandImages = [
    'assets/images/apple.jpg',
    'assets/images/Dell.jpg',
    'assets/images/nike.jpg',
    'assets/images/samsung.jpg',
    'assets/images/addidas.jpg',
    //'assets/images/Huawei.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackdropScaffold(
        frontLayerBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
        headerHeight: MediaQuery.of(context).size.height * 0.25,
        appBar: BackdropAppBar(
          title: Text('Home'),
          leading: BackdropToggleButton(
            icon: AnimatedIcons.home_menu,
          ),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              ColorsConsts.starterColor,
              ColorsConsts.endColor
            ])),
          ),
          actions: [
            IconButton(
                iconSize: 15,
                padding: EdgeInsets.all(10),
                icon: CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 13,
                    backgroundImage: AssetImage('assets/images/CatLaptops.png'),
                  ),
                ),
                onPressed: () {})
          ],
        ),
        backLayer: Center(
          child: Text('Back Layer'),
        ),
        frontLayer: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 190.0,
                width: double.infinity,
                child: Carousel(
                  boxFit: BoxFit.fill,
                  autoplay: true,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 5.0,
                  dotIncreasedColor: Colors.purple,
                  dotBgColor: Colors.black.withOpacity(0.2),
                  dotPosition: DotPosition.bottomCenter,
                  //otVerticalPadding: 10.0,
                  showIndicator: true,
                  indicatorBgPadding: 5.0,
                  images: [
                    AssetImage(_couroselImages[0]),
                    AssetImage(_couroselImages[1]),
                    AssetImage(_couroselImages[2]),
                    AssetImage(_couroselImages[3]),
                    ExactAssetImage(_couroselImages[4]),
                  ],
                ),
              ),
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
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext ctx, int index) {
                    return CategoryWidget(
                      index: index,
                    );
                  },
                  itemCount: 6,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Brands',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View all..',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15),
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
                  onTap: (index) {},
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Popular Products',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'View all..',
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 15),
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
                    itemCount: 8,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext ctx, int index) {
                      return PopularProducts();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
