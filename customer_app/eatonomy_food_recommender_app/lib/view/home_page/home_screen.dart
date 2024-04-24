import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatonomy_food_recommender_app/res/components/HomePage_Components/categories_container.dart';
import 'package:eatonomy_food_recommender_app/res/components/HomePage_Components/dish_card.dart';
import 'package:eatonomy_food_recommender_app/res/components/HomePage_Components/restaurants_card.dart';
import 'package:eatonomy_food_recommender_app/res/components/colors_app.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:eatonomy_food_recommender_app/view/drawer/Drawer.dart';
import 'package:eatonomy_food_recommender_app/view/product_details/product_details_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../res/components/HomePage_Components/Home_appbar.dart';
import '../../res/components/HomePage_Components/appbar_textfield.dart';
import '../restaurant_menu/restaurant_menu_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:eatonomy_food_recommender_app/view/home_page/home_page_model.dart';
export 'package:eatonomy_food_recommender_app/view/home_page/home_page_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.pageHalf,
  });

  final double? pageHalf;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomePageModel _model;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final restaurantData =
      FirebaseFirestore.instance.collection('Restaurants').snapshots();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel(context));
    _model.textController ??= TextEditingController();
    _model.getCurrentPosition();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    final width = MediaQuery.of(context).size.width * 1;
    return GestureDetector(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorsApp.backgroundColorApp,
        drawer: const MyDrawer(),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            CustomSliverAppBar(
              titleText: 'Delivery Address',
              addressText: 'Address Placeholder',
              currentAddress: _model.getAddress,
              onCartPressed: () {
                Navigator.pushNamed(context, RoutesName.cartScreen);
              },
            )
          ],
          body: Builder(
            builder: (context) {
              return SafeArea(
                top: false,
                child: Container(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height,
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width,
                    maxHeight: MediaQuery.sizeOf(context).height,
                  ),
                  decoration: const BoxDecoration(),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 15.0),
                              child: HomePageTextField(
                                controller: _model.textController,
                                autofocus: true,
                                obscureText: false,
                                labelText: 'Food, Restaurants, etc',
                                onChanged: (value) {
                                  // Handle onChanged event
                                },
                                validator: (value) {
                                  // Custom validation logic
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          FlutterFlowIconButton(
                            borderColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: 20.0,
                            borderWidth: 1.0,
                            buttonSize: 40.0,
                            fillColor:
                                FlutterFlowTheme.of(context).primaryBackground,
                            icon: Icon(
                              FFIcons.kadjustmentsHorizontal,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 24.0,
                            ),
                            onPressed: () {
                              //Place the code of cart
                            },
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).accent4,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Categories',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 24.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () {
                                if (kDebugMode) {
                                  print('Button pressed ...');
                                }
                              },
                              text: 'View all',
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    24.0, 0.0, 24.0, 0.0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      fontWeight: FontWeight.w300,
                                    ),
                                elevation: 0.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).accent4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: GridView(
                            padding: EdgeInsets.zero,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 10.0,
                              childAspectRatio: 1.0,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            children: [
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/hamburger.svg',
                                  text: 'Burger',
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.burgerScreen);
                                  }),
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/pizza-pie.svg',
                                  text: 'Pizza',
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.burgerScreen);
                                  }),
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/bbq-2.svg',
                                  text: 'BBQ',
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.bbqScreen);
                                  }),
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/chicken.svg',
                                  text: 'Broast',
                                  onTap: () {}),
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/chinese-2.svg',
                                  text: 'Chinese',
                                  onTap: () {}),
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/biryani.svg',
                                  text: 'Biryani',
                                  onTap: () {}),
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/desi.svg',
                                  text: 'Desi',
                                  onTap: () {}),
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/sandwich-01.svg',
                                  text: 'Sandwich',
                                  onTap: () {}),
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/pasta.svg',
                                  text: 'Pasta',
                                  onTap: () {}),
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/shawarma.svg',
                                  text: 'Shawarma',
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, RoutesName.shawarmaScreen);
                                  }),
                              CustomCategoryContainer(
                                svgPath: 'assets/icons/ice-cream.svg',
                                text: 'Ice-Cream',
                                onTap: () {},
                              ),
                              CustomCategoryContainer(
                                svgPath: 'assets/icons/tea.svg',
                                text: 'Tea',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).accent4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          decoration: const BoxDecoration(),
                          width: double.infinity,
                          height: height * .190,
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 40.0),
                                child: PageView(
                                  controller: _model.pageViewController1 ??=
                                      PageController(initialPage: 0),
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        width: width * .50,
                                        height: height * .120,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/Banner1.png'),
                                              fit: BoxFit.fill),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        width: width * .50,
                                        height: height * .120,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/Banner1.png'),
                                              fit: BoxFit.fill),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Container(
                                        width: width * .50,
                                        height: height * .120,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/Banner1.png'),
                                              fit: BoxFit.fill),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Align(
                                alignment:
                                    const AlignmentDirectional(-1.0, 1.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 0.0, 16.0),
                                  child:
                                      smooth_page_indicator.SmoothPageIndicator(
                                    controller: _model.pageViewController1 ??=
                                        PageController(initialPage: 0),
                                    count: 3,
                                    axisDirection: Axis.horizontal,
                                    onDotClicked: (i) async {
                                      await _model.pageViewController1!
                                          .animateToPage(
                                        i,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease,
                                      );
                                    },
                                    effect: smooth_page_indicator
                                        .ExpandingDotsEffect(
                                      expansionFactor: 3.0,
                                      spacing: 8.0,
                                      radius: 16.0,
                                      dotWidth: 16.0,
                                      dotHeight: 8.0,
                                      dotColor:
                                          FlutterFlowTheme.of(context).accent1,
                                      activeDotColor:
                                          FlutterFlowTheme.of(context).primary,
                                      paintStyle: PaintingStyle.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).accent4,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Restaurants near you',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(1.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () {
                                if (kDebugMode) {
                                  print('Button pressed ...');
                                }
                              },
                              text: 'View all',
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 24.0, 0.0),
                                iconPadding:
                                    const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Poppins',
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      fontWeight: FontWeight.w300,
                                    ),
                                elevation: 0.0,
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                  width: 1.0,
                                ),
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).accent4,
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: restaurantData,
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData) {
                            return const Text('No Data Available');
                          } else {
                            return Container(
                              width: 100.0,
                              height:
                                  MediaQuery.of(context).size.height * 0.275,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  var restaurantData =
                                      snapshot.data!.docs[index];

                                  return CustomRestaurantCard(
                                    imageUrl: restaurantData['imageurl'],
                                    restaurantName: restaurantData['title'],
                                    rating: restaurantData['rating'],
                                    numberOfReviews:
                                        restaurantData['numberOfReviews'],
                                    isDeliveryFree: false,
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RestaurantMenuWidget(
                                                    imageUrl: restaurantData[
                                                        'imageurl'],
                                                    id: restaurantData['id'],
                                                    restaurantName:
                                                        restaurantData['title'],
                                                    openingHours: const [
                                                      '2:00-12:00',
                                                      '2:00-2:00'
                                                    ],
                                                    categories: List.from(
                                                        restaurantData[
                                                            'Categories']),
                                                    rating: restaurantData[
                                                        'rating'],
                                                    deliveryTime:
                                                        restaurantData[
                                                            'delivery time'],
                                                  )));
                                    },
                                    foodCategories:
                                        List.from(restaurantData['Categories']),
                                    deliveryTime: '20',
                                  );
                                },
                              ),
                            );
                          }
                        },
                      ),
                      Divider(
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).accent4,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Recommended for you',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryText,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).accent4,
                      ),
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: ListView(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              DishCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProductDetailsWidget(
                                                imageurl: '',
                                                productName: '',
                                                price: 0,
                                                isDeliveryFree: true,
                                                rating: 0.0,
                                                numberOfReviews: 0,
                                                deliveryTime: '',
                                                description: '',
                                              )));
                                },
                                imageUrl: 'https://picsum.photos/seed/435/600',
                                productName: 'Crispy Burger',
                                price: 1000,
                                isDeliveryFree: true,
                                rating: 4.5,
                                numberOfReviews: 25,
                              ),
                              DishCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProductDetailsWidget(
                                                imageurl: '',
                                                productName: '',
                                                price: 0,
                                                isDeliveryFree: true,
                                                rating: 0.0,
                                                numberOfReviews: 0,
                                                deliveryTime: '',
                                                description: '',
                                              )));
                                },
                                imageUrl: 'https://picsum.photos/seed/435/600',
                                productName: 'Crispy Burger',
                                price: 1000,
                                isDeliveryFree: true,
                                rating: 4.5,
                                numberOfReviews: 25,
                              ),
                              DishCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProductDetailsWidget(
                                                imageurl: '',
                                                productName: '',
                                                price: 0,
                                                isDeliveryFree: true,
                                                rating: 0.0,
                                                numberOfReviews: 0,
                                                deliveryTime: '',
                                                description: '',
                                              )));
                                },
                                imageUrl: 'https://picsum.photos/seed/435/600',
                                productName: 'Mighty Burger',
                                price: 1000,
                                isDeliveryFree: true,
                                rating: 4.5,
                                numberOfReviews: 25,
                              ),
                              DishCard(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProductDetailsWidget(
                                                imageurl: '',
                                                productName: '',
                                                price: 0,
                                                isDeliveryFree: true,
                                                rating: 0.0,
                                                numberOfReviews: 0,
                                                deliveryTime: '',
                                                description: '',
                                              )));
                                },
                                imageUrl: 'https://picsum.photos/seed/435/600',
                                productName: 'Mighty Burger',
                                price: 1000,
                                isDeliveryFree: true,
                                rating: 4.5,
                                numberOfReviews: 25,
                              ),
                            ].divide(const SizedBox(height: 10.0)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
