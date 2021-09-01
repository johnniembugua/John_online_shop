import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:shopping_app2/consts/colors.dart';
import 'package:shopping_app2/consts/my_icons.dart';
import 'package:shopping_app2/provider/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app2/screens/cart.dart';
import 'package:shopping_app2/screens/wishlist.dart';

class UserInfoScreen extends StatefulWidget {
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  ScrollController _scrollController;
  var top = 0.0;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String _uid;
  String _name;
  String _email;
  String _joinedAt;
  int _phoneNumber;
  String _userImageUrl;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      setState(() {});
    });
    getData();
  }

  void getData() async {
    User user = _auth.currentUser;
    _uid = user.uid;
    user.email;
    final DocumentSnapshot userDoc = user.isAnonymous
        ? null
        : await FirebaseFirestore.instance.collection('users').doc(_uid).get();
    if (userDoc == null) {
      return;
    } else {
      setState(() {
        _name = userDoc.get('name');
        _email = user.email;
        _joinedAt = userDoc.get('joinedAt');
        _phoneNumber = userDoc.get('phoneNumber');
        _userImageUrl = userDoc.get('imageUrl');
        //print('name $_name');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
        body: Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              elevation: 4,
              expandedHeight: 200,
              pinned: true,
              flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                top = constraints.biggest.height;
                return Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        ColorsConsts.starterColor,
                        ColorsConsts.endColor,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                  child: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    centerTitle: true,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 300),
                          opacity: top <= 110 ? 1.0 : 0,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 12.0,
                              ),
                              Container(
                                height: kToolbarHeight / 1.8,
                                width: kToolbarHeight / 1.8,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white,
                                      blurRadius: 1.0,
                                    )
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(_userImageUrl ??
                                        'https://images-na.ssl-images-amazon.com/images/I/51ME-ADMjRL._AC_SL1000_.jpg'),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 12,
                              ),
                              Text(
                                _name == null ? 'Guest' : _name,
                                style: TextStyle(
                                    fontSize: 20.0, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    background: Image(
                      //TODO:Change default imageUrl
                      image: NetworkImage(_userImageUrl ??
                          'https://images-na.ssl-images-amazon.com/images/I/51ME-ADMjRL._AC_SL1000_.jpg'),
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              }),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: userTitle('User Bag'),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () => Navigator.of(context)
                            .pushNamed(WishlistScreen.routeName),
                        title: Text('Wishlist'),
                        trailing: Icon(Icons.chevron_right_rounded),
                        leading: Icon(MyAppIcons.wishlist),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () => Navigator.of(context)
                            .pushNamed(CartScreen.routeName),
                        title: Text('Cart'),
                        trailing: Icon(Icons.chevron_right_rounded),
                        leading: Icon(MyAppIcons.cart),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: userTitle('User Information'),
                  ),
                  Divider(thickness: 1, color: Colors.grey),
                  userListTile('Email', '$_email' ?? '', 0, context),
                  userListTile('Phone number', _phoneNumber.toString() ?? '', 1,
                      context),
                  userListTile('shipping address', '', 2, context),
                  userListTile('Joined date', '$_joinedAt' ?? '', 3, context),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: userTitle('User Settings'),
                  ),
                  Divider(thickness: 1, color: Colors.grey),
                  ListTileSwitch(
                    value: themeChange.darkTheme,
                    leading: Icon(Ionicons.md_moon),
                    onChanged: (value) {
                      setState(() {
                        themeChange.darkTheme = value;
                      });
                    },
                    visualDensity: VisualDensity.comfortable,
                    switchType: SwitchType.cupertino,
                    switchActiveColor: Colors.indigo,
                    title: Text('Green theme'),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Theme.of(context).splashColor,
                      child: ListTile(
                        onTap: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Image.network(
                                          'https://image.flaticon.com/icons/png/128/1828/1828304.png',
                                          height: 20.0,
                                          width: 20,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Text('Sign Out'),
                                      ),
                                    ],
                                  ),
                                  content: Text("Do you want to sign out?"),
                                  actions: [
                                    TextButton(
                                        onPressed: () async {
                                          Navigator.pop(context);
                                        },
                                        child: Text('Cancel')),
                                    TextButton(
                                        onPressed: () async {
                                          await _auth.signOut().then((value) =>
                                              Navigator.pop(context));
                                        },
                                        child: Text('Ok')),
                                  ],
                                );
                              });
                        },
                        title: Text('Logout'),
                        leading: Icon(Icons.exit_to_app_rounded),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        _buildFab(),
      ],
    ));
  }

  Widget _buildFab() {
    final double defaultTopMargin = 200.0 - 4.0;
    final double scaleStart = 160.0;
    final double scaleEnd = scaleStart / 2;

    double top = defaultTopMargin;
    double scale = 1.0;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart) {
        scale = 1.0;
      } else if (offset < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - scaleEnd - offset) / scaleEnd;
      } else {
        scale = 0.0;
      }
    }
    return Positioned(
      top: top,
      right: 16.0,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: FloatingActionButton(
          backgroundColor: Colors.purple,
          heroTag: 'btn1',
          onPressed: () {},
          child: Icon(Icons.camera_alt_outlined),
        ),
      ),
    );
  }

  List<IconData> _userTileIcons = [
    Icons.email,
    Icons.phone,
    Icons.local_shipping,
    Icons.watch_later,
    Icons.exit_to_app_rounded,
  ];

  Widget userListTile(
      String title, String subtitle, int index, BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Theme.of(context).splashColor,
        child: ListTile(
          onTap: () {},
          title: Text(title),
          subtitle: Text(subtitle),
          leading: Icon(_userTileIcons[index]),
        ),
      ),
    );
  }

  Widget userTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
    );
  }
}
