import 'package:flutter/material.dart';
import 'package:shopping_app2/inner_screens/categories_feeds.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({this.index});
  final int index;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  List<Map<String, Object>> categories = [
    {
      'categoryName': 'Fresh milk',
      'categoryImagePath': 'assets/images/fresh.jpg',
    },
    {
      'categoryName': 'Toned milk',
      'categoryImagePath': 'assets/images/Toned.jpg',
    },
    {
      'categoryName': 'Tetro milk',
      'categoryImagePath': 'assets/images/Tetro.jpg',
    },
    {
      'categoryName': 'Farmented milk',
      'categoryImagePath': 'assets/images/farmented2.png',
    },
    {
      'categoryName': 'Cow milk',
      'categoryImagePath': 'assets/images/cow-milk.jpg',
    },
    {
      'categoryName': 'Goat milk',
      'categoryImagePath': 'assets/images/goat3.jpg',
    },
    // {
    //   'categoryName': 'Watches',
    //   'categoryImage': 'assets/images/CatLaptops.png',
    // },
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(CategoriesFeedsScreen.routeName,
                arguments: '${categories[widget.index]['categoryName']}');
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(
                  categories[widget.index]['categoryImagePath'],
                ),
                fit: BoxFit.cover,
              ),
            ),
            margin: EdgeInsets.symmetric(horizontal: 10),
            width: 150,
            height: 150,
          ),
        ),
        Positioned(
          left: 10,
          bottom: 0.0,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: Theme.of(context).backgroundColor,
            child: Text(
              categories[widget.index]['categoryName'],
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).textSelectionTheme.selectionColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
