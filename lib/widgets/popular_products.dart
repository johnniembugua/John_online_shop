import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            onTap: () {},
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 170,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/CatFurniture.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Positioned(
                        right: 12,
                        top: 10,
                        child: Icon(
                          Entypo.star,
                          color: Colors.grey.shade800,
                        )),
                    Positioned(
                        right: 10,
                        top: 7,
                        child: Icon(Entypo.star_outlined, color: Colors.white)),
                    Positioned(
                        right: 12,
                        bottom: 20,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          color: Theme.of(context).backgroundColor,
                          child: Text(
                            '\Ksh 200.00',
                            style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                            ),
                          ),
                        )),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Description',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(30),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  MaterialCommunityIcons.cart_plus,
                                  size: 25,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
