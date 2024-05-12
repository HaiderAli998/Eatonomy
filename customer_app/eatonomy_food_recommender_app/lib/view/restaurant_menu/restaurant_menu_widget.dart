import 'package:eatonomy_food_recommender_app/view/restaurant_menu/restaurant_menu_tab_item_list.dart';
import 'package:flutter/material.dart';
import '../../res/components/Colors/colors_app.dart';
import '../../utils/routes/routes_name.dart';
import '../cart/persistent_shopping_cart.dart';
import 'restaurant_menu_model.dart';

class RestaurantMenuWidget extends StatefulWidget {
  final int id;
  final String restaurantName;
  final List<String> openingHours;
  final double rating;
  final String deliveryTime;
  final String imageUrl;
  final List<String> categories;

  const RestaurantMenuWidget(
      {super.key,
      required this.restaurantName,
      required this.openingHours,
      required this.rating,
      required this.deliveryTime,
      required this.categories,
      required this.id,
      required this.imageUrl});

  @override
  State<RestaurantMenuWidget> createState() => _RestaurantMenuWidgetState();
}

class _RestaurantMenuWidgetState extends State<RestaurantMenuWidget>
    with SingleTickerProviderStateMixin {
  late RestaurantMenuModel _model;
  late TabController _tabController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int iterationCount = 0;
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: ColorsApp.backgroundColorApp,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.of(context).size.height * 0.14),
          child: AppBar(
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black),
            automaticallyImplyLeading: false,
            actions: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Consumer<FavRestaurantProvider>(
                  //   builder: (BuildContext context, value, Widget? child){
                  //     return IconButton(
                  //       icon: Icon(
                  //         value.selectedItems.contains('')
                  //             ? Icons.favorite
                  //             : Icons.favorite_border_outlined,
                  //         color: Colors.white,
                  //         size: 24.0,
                  //       ),
                  //       onPressed: () {
                  //
                  //
                  //       },
                  //     );
                  //   },
                  // ),
                  PersistentShoppingCart().showCartItemCountWidget(
                      cartItemCountWidgetBuilder: (itemCount) => IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesName.cartScreen);
                          },
                          icon: Badge(
                            label: Text(itemCount.toString()),
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                            ),
                          ))),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  widget.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.1,
                  fit: BoxFit.cover,
                ),
              ),
              centerTitle: true,
              expandedTitleScale: 1.0,
            ),
            toolbarHeight: MediaQuery.of(context).size.height * 0.05,
            elevation: 0.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                            child: Text(
                              widget.restaurantName,
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontFamily: 'Outfit',
                                color: Color(0xFF43464D),
                                fontSize: 20.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        thickness: 1.0,
                        color: Color(0xFFE1E2E3),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 0, 0, 0),
                        child: Column(
                          children: [
                            for (var hours in widget.openingHours)
                              Row(
                                children: [
                                  Text(
                                    iterationCount % 2 == 0
                                        ? "Monday-Friday: "
                                        : "Saturday-Sunday: ",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: ColorsApp.lightGrey,
                                    ),
                                  ),
                                  Text(
                                    hours,
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: iterationCount % 2 == 0
                                          ? ColorsApp.splashBackgroundColorApp
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.006),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 24,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.038),
                                Text(
                                  widget.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: ColorsApp.lightGrey,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.006),
                            Row(
                              children: [
                                const Icon(
                                  Icons.watch_later,
                                  color: ColorsApp.lightGrey,
                                  size: 24,
                                ),
                                SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.038),
                                Text(
                                  'Delivery: ${widget.deliveryTime}',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: ColorsApp.lightGrey,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.020),
                    ],
                  ),
                ),
                TabBar(
                  unselectedLabelColor: Colors.black,
                  isScrollable: true,
                  labelColor: ColorsApp.splashBackgroundColorApp,
                  tabs: widget.categories
                      .map((category) => Tab(text: category))
                      .toList(),
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
                Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children: widget.categories
                          .map((category) => TabItemList(
                                foodCategory: category,
                                id: widget.id,
                              ))
                          .toList()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
