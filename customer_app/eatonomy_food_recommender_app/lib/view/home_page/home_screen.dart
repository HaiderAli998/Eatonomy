import 'package:eatonomy_food_recommender_app/res/components/HomePage_Components/categories_container.dart';
import 'package:eatonomy_food_recommender_app/res/components/colors_app.dart';
import 'package:eatonomy_food_recommender_app/view/drawer/Drawer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import '../../res/components/HomePage_Components/Current_Location.dart';
import '../../res/components/HomePage_Components/Home_appbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart'
    as smooth_page_indicator;
import 'package:eatonomy_food_recommender_app/view/home_page/home_page_model.dart';
export 'package:eatonomy_food_recommender_app/view/home_page/home_page_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
  late Position _currentPosition;
  String _currentAddress = 'Loading...';

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel());
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    final position = await LocationService.getCurrentPosition(context);
    if (position != null) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng(_currentPosition);
      });
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    final address = await LocationService.getAddressFromLatLng(position);
    setState(() {
      _currentAddress = address;
    });
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
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
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
              currentAddress: _currentAddress,
              onCartPressed: () {
                // Handle cart button pressed
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
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  8.0, 0.0, 8.0, 0.0),
                              child: TextFormField(
                                controller: _model.textController,
                                focusNode: _model.textFieldFocusNode,
                                autofocus: true,
                                obscureText: false,
                                decoration: InputDecoration(
                                    labelText: 'Food, Restaurants,etc',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          fontSize: 14.0,
                                        ),
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Color(0xFFFFF9E1),
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 2.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    filled: true,
                                    fillColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    prefixIcon:
                                        const Icon(Icons.search_rounded)),
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 12.0,
                                    ),
                                validator: _model.textControllerValidator
                                    .asValidator(context),
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
                                  onTap: () {}),
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/pizza-pie.svg',
                                  text: 'Pizza',
                                  onTap: () {}),
                              CustomCategoryContainer(
                                  svgPath: 'assets/icons/bbq-2.svg',
                                  text: 'BBQ',
                                  onTap: () {}),
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
                                  onTap: () {}),
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
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Container(
                                        width: width*.50,
                                        height: height*.120,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage('assets/images/Banner1.png'),
                                              fit: BoxFit.fill),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Container(
                                        width: width*.50,
                                        height: height*.120,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage('assets/images/Banner1.png'),
                                              fit: BoxFit.fill),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Container(
                                        width: width*.50,
                                        height: height*.120,
                                        decoration: const BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage('assets/images/Banner1.png'),
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
                                alignment: AlignmentDirectional(-1.0, 1.0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
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
                                        duration: Duration(milliseconds: 500),
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
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Restaurants near you',
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
                            alignment: AlignmentDirectional(1.0, 0.0),
                            child: FFButtonWidget(
                              onPressed: () {
                                print('Button pressed ...');
                              },
                              text: 'View all',
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: 15.0,
                              ),
                              options: FFButtonOptions(
                                height: 40.0,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 24.0, 0.0),
                                iconPadding: EdgeInsetsDirectional.fromSTEB(
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
                                borderSide: BorderSide(
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
                      Container(
                        width: 100.0,
                        height: MediaQuery.sizeOf(context).height * 0.275,
                        decoration: BoxDecoration(
                          color: FlutterFlowTheme.of(context).primaryBackground,
                        ),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  height:
                                  MediaQuery.sizeOf(context).height * 0.3,
                                  constraints: BoxConstraints(
                                    maxWidth: 80.0,
                                    maxHeight: 80.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.8,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(0.0),
                                                  bottomRight:
                                                  Radius.circular(0.0),
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                  Radius.circular(8.0),
                                                ),
                                                child: Image.network(
                                                  'https://picsum.photos/seed/435/600',
                                                  width:
                                                  MediaQuery.sizeOf(context)
                                                      .width *
                                                      0.8,
                                                  height:
                                                  MediaQuery.sizeOf(context)
                                                      .height *
                                                      0.18,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(10.0, 5.0,
                                                        0.0, 0.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                          context)
                                                          .width *
                                                          0.2,
                                                      height: MediaQuery.sizeOf(
                                                          context)
                                                          .height *
                                                          0.03,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          bottomLeft:
                                                          Radius.circular(
                                                              30.0),
                                                          bottomRight:
                                                          Radius.circular(
                                                              30.0),
                                                          topLeft:
                                                          Radius.circular(
                                                              30.0),
                                                          topRight:
                                                          Radius.circular(
                                                              30.0),
                                                        ),
                                                        shape:
                                                        BoxShape.rectangle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          width: 0.0,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Text(
                                                            '4.5',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .secondaryText,
                                                              fontSize:
                                                              10.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w300,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: Color(
                                                                0xFFE7B734),
                                                            size: 15.0,
                                                          ),
                                                          Text(
                                                            '(25+ )',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .secondaryText,
                                                              fontSize:
                                                              10.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w200,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 0.0,
                                                        10.0, 0.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () {
                                                        print(
                                                            'Button pressed ...');
                                                      },
                                                      text: '',
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidHeart,
                                                        size: 15.0,
                                                      ),
                                                      options: FFButtonOptions(
                                                        width:
                                                        MediaQuery.sizeOf(
                                                            context)
                                                            .width *
                                                            0.055,
                                                        height:
                                                        MediaQuery.sizeOf(
                                                            context)
                                                            .height *
                                                            0.026,
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            3.5,
                                                            4.0,
                                                            0.0,
                                                            0.0),
                                                        iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            0.0),
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .primary,
                                                        textStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .titleSmall
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          color: Colors
                                                              .white,
                                                          fontSize: 1.0,
                                                        ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(24.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 10.0, 0.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Restaurant Name',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryText,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                                child: FaIcon(
                                                  FontAwesomeIcons
                                                      .solidCheckCircle,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primary,
                                                  size: 10.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                              child: Icon(
                                                Icons.delivery_dining,
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                size: 10.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Free delivery',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Readex Pro',
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryText,
                                                  fontSize: 10.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  35.0, 0.0, 0.0, 0.0),
                                              child: FaIcon(
                                                FontAwesomeIcons.stopwatch,
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                size: 10.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                '10-15mins',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .override(
                                                  fontFamily:
                                                  'Readex Pro',
                                                  fontSize: 9.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 5.0, 0.0, 15.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      5.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0x51FFFFFF),
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                        Radius.circular(
                                                            15.0),
                                                        bottomRight:
                                                        Radius.circular(
                                                            15.0),
                                                        topLeft:
                                                        Radius.circular(
                                                            15.0),
                                                        topRight:
                                                        Radius.circular(
                                                            15.0),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          15.0,
                                                          0.0,
                                                          15.0,
                                                          0.0),
                                                      child: Text(
                                                        'Food Category',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .secondaryText,
                                                          fontSize: 9.0,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0x51FFFFFF),
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      bottomLeft:
                                                      Radius.circular(15.0),
                                                      bottomRight:
                                                      Radius.circular(15.0),
                                                      topLeft:
                                                      Radius.circular(15.0),
                                                      topRight:
                                                      Radius.circular(15.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(15.0, 0.0,
                                                        15.0, 0.0),
                                                    child: Text(
                                                      'Food Category',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 9.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0x51FFFFFF),
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      bottomLeft:
                                                      Radius.circular(15.0),
                                                      bottomRight:
                                                      Radius.circular(15.0),
                                                      topLeft:
                                                      Radius.circular(15.0),
                                                      topRight:
                                                      Radius.circular(15.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(15.0, 0.0,
                                                        15.0, 0.0),
                                                    child: Text(
                                                      'Food Category',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 9.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  height:
                                  MediaQuery.sizeOf(context).height * 0.3,
                                  constraints: BoxConstraints(
                                    maxWidth: 80.0,
                                    maxHeight: 80.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.8,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(0.0),
                                                  bottomRight:
                                                  Radius.circular(0.0),
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                  Radius.circular(8.0),
                                                ),
                                                child: Image.network(
                                                  'https://picsum.photos/seed/435/600',
                                                  width:
                                                  MediaQuery.sizeOf(context)
                                                      .width *
                                                      0.8,
                                                  height:
                                                  MediaQuery.sizeOf(context)
                                                      .height *
                                                      0.18,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(10.0, 5.0,
                                                        0.0, 0.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                          context)
                                                          .width *
                                                          0.2,
                                                      height: MediaQuery.sizeOf(
                                                          context)
                                                          .height *
                                                          0.03,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          bottomLeft:
                                                          Radius.circular(
                                                              30.0),
                                                          bottomRight:
                                                          Radius.circular(
                                                              30.0),
                                                          topLeft:
                                                          Radius.circular(
                                                              30.0),
                                                          topRight:
                                                          Radius.circular(
                                                              30.0),
                                                        ),
                                                        shape:
                                                        BoxShape.rectangle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          width: 0.0,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Text(
                                                            '4.5',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .secondaryText,
                                                              fontSize:
                                                              10.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w300,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: Color(
                                                                0xFFE7B734),
                                                            size: 15.0,
                                                          ),
                                                          Text(
                                                            '(25+ )',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .secondaryText,
                                                              fontSize:
                                                              10.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w200,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 0.0,
                                                        10.0, 0.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () {
                                                        print(
                                                            'Button pressed ...');
                                                      },
                                                      text: '',
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidHeart,
                                                        size: 15.0,
                                                      ),
                                                      options: FFButtonOptions(
                                                        width:
                                                        MediaQuery.sizeOf(
                                                            context)
                                                            .width *
                                                            0.055,
                                                        height:
                                                        MediaQuery.sizeOf(
                                                            context)
                                                            .height *
                                                            0.026,
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            3.5,
                                                            4.0,
                                                            0.0,
                                                            0.0),
                                                        iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            0.0),
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .primary,
                                                        textStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .titleSmall
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          color: Colors
                                                              .white,
                                                          fontSize: 1.0,
                                                        ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(24.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 10.0, 0.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Restaurant Name',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryText,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                                child: FaIcon(
                                                  FontAwesomeIcons
                                                      .solidCheckCircle,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primary,
                                                  size: 10.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                              child: Icon(
                                                Icons.delivery_dining,
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                size: 10.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Free delivery',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Readex Pro',
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryText,
                                                  fontSize: 10.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  35.0, 0.0, 0.0, 0.0),
                                              child: FaIcon(
                                                FontAwesomeIcons.stopwatch,
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                size: 10.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                '10-15mins',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .override(
                                                  fontFamily:
                                                  'Readex Pro',
                                                  fontSize: 9.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 5.0, 0.0, 15.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      5.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0x51FFFFFF),
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                        Radius.circular(
                                                            15.0),
                                                        bottomRight:
                                                        Radius.circular(
                                                            15.0),
                                                        topLeft:
                                                        Radius.circular(
                                                            15.0),
                                                        topRight:
                                                        Radius.circular(
                                                            15.0),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          15.0,
                                                          0.0,
                                                          15.0,
                                                          0.0),
                                                      child: Text(
                                                        'Food Category',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .secondaryText,
                                                          fontSize: 9.0,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0x51FFFFFF),
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      bottomLeft:
                                                      Radius.circular(15.0),
                                                      bottomRight:
                                                      Radius.circular(15.0),
                                                      topLeft:
                                                      Radius.circular(15.0),
                                                      topRight:
                                                      Radius.circular(15.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(15.0, 0.0,
                                                        15.0, 0.0),
                                                    child: Text(
                                                      'Food Category',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 9.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0x51FFFFFF),
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      bottomLeft:
                                                      Radius.circular(15.0),
                                                      bottomRight:
                                                      Radius.circular(15.0),
                                                      topLeft:
                                                      Radius.circular(15.0),
                                                      topRight:
                                                      Radius.circular(15.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(15.0, 0.0,
                                                        15.0, 0.0),
                                                    child: Text(
                                                      'Food Category',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 9.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  height:
                                  MediaQuery.sizeOf(context).height * 0.3,
                                  constraints: BoxConstraints(
                                    maxWidth: 80.0,
                                    maxHeight: 80.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.8,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(0.0),
                                                  bottomRight:
                                                  Radius.circular(0.0),
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                  Radius.circular(8.0),
                                                ),
                                                child: Image.network(
                                                  'https://picsum.photos/seed/435/600',
                                                  width:
                                                  MediaQuery.sizeOf(context)
                                                      .width *
                                                      0.8,
                                                  height:
                                                  MediaQuery.sizeOf(context)
                                                      .height *
                                                      0.18,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(10.0, 5.0,
                                                        0.0, 0.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                          context)
                                                          .width *
                                                          0.2,
                                                      height: MediaQuery.sizeOf(
                                                          context)
                                                          .height *
                                                          0.03,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                        borderRadius:
                                                        BorderRadius.only(
                                                          bottomLeft:
                                                          Radius.circular(
                                                              30.0),
                                                          bottomRight:
                                                          Radius.circular(
                                                              30.0),
                                                          topLeft:
                                                          Radius.circular(
                                                              30.0),
                                                          topRight:
                                                          Radius.circular(
                                                              30.0),
                                                        ),
                                                        shape:
                                                        BoxShape.rectangle,
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          width: 0.0,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                        MainAxisSize.min,
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                        children: [
                                                          Text(
                                                            '4.5',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .secondaryText,
                                                              fontSize:
                                                              10.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w300,
                                                            ),
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: Color(
                                                                0xFFE7B734),
                                                            size: 15.0,
                                                          ),
                                                          Text(
                                                            '(25+ )',
                                                            style: FlutterFlowTheme
                                                                .of(context)
                                                                .bodyMedium
                                                                .override(
                                                              fontFamily:
                                                              'Readex Pro',
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .secondaryText,
                                                              fontSize:
                                                              10.0,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w200,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(0.0, 0.0,
                                                        10.0, 0.0),
                                                    child: FFButtonWidget(
                                                      onPressed: () {
                                                        print(
                                                            'Button pressed ...');
                                                      },
                                                      text: '',
                                                      icon: FaIcon(
                                                        FontAwesomeIcons
                                                            .solidHeart,
                                                        size: 15.0,
                                                      ),
                                                      options: FFButtonOptions(
                                                        width:
                                                        MediaQuery.sizeOf(
                                                            context)
                                                            .width *
                                                            0.055,
                                                        height:
                                                        MediaQuery.sizeOf(
                                                            context)
                                                            .height *
                                                            0.026,
                                                        padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            3.5,
                                                            4.0,
                                                            0.0,
                                                            0.0),
                                                        iconPadding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                            0.0,
                                                            0.0,
                                                            0.0,
                                                            0.0),
                                                        color:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .primary,
                                                        textStyle:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .titleSmall
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          color: Colors
                                                              .white,
                                                          fontSize: 1.0,
                                                        ),
                                                        elevation: 0.0,
                                                        borderSide: BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(24.0),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 10.0, 0.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Restaurant Name',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryText,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                                child: FaIcon(
                                                  FontAwesomeIcons
                                                      .solidCheckCircle,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primary,
                                                  size: 10.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                              child: Icon(
                                                Icons.delivery_dining,
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                size: 10.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                'Free delivery',
                                                style: FlutterFlowTheme.of(
                                                    context)
                                                    .bodyMedium
                                                    .override(
                                                  fontFamily: 'Readex Pro',
                                                  color:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryText,
                                                  fontSize: 10.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  35.0, 0.0, 0.0, 0.0),
                                              child: FaIcon(
                                                FontAwesomeIcons.stopwatch,
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                size: 10.0,
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(5.0, 0.0, 0.0, 0.0),
                                              child: Text(
                                                '10-15mins',
                                                style:
                                                FlutterFlowTheme.of(context)
                                                    .labelSmall
                                                    .override(
                                                  fontFamily:
                                                  'Readex Pro',
                                                  fontSize: 9.0,
                                                  fontWeight:
                                                  FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Align(
                                          alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                          child: Padding(
                                            padding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0.0, 5.0, 0.0, 15.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              mainAxisAlignment:
                                              MainAxisAlignment.start,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      5.0, 0.0, 0.0, 0.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Color(0x51FFFFFF),
                                                      borderRadius:
                                                      BorderRadius.only(
                                                        bottomLeft:
                                                        Radius.circular(
                                                            15.0),
                                                        bottomRight:
                                                        Radius.circular(
                                                            15.0),
                                                        topLeft:
                                                        Radius.circular(
                                                            15.0),
                                                        topRight:
                                                        Radius.circular(
                                                            15.0),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          15.0,
                                                          0.0,
                                                          15.0,
                                                          0.0),
                                                      child: Text(
                                                        'Food Category',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodyMedium
                                                            .override(
                                                          fontFamily:
                                                          'Readex Pro',
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .secondaryText,
                                                          fontSize: 9.0,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0x51FFFFFF),
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      bottomLeft:
                                                      Radius.circular(15.0),
                                                      bottomRight:
                                                      Radius.circular(15.0),
                                                      topLeft:
                                                      Radius.circular(15.0),
                                                      topRight:
                                                      Radius.circular(15.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(15.0, 0.0,
                                                        15.0, 0.0),
                                                    child: Text(
                                                      'Food Category',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 9.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0x51FFFFFF),
                                                    borderRadius:
                                                    BorderRadius.only(
                                                      bottomLeft:
                                                      Radius.circular(15.0),
                                                      bottomRight:
                                                      Radius.circular(15.0),
                                                      topLeft:
                                                      Radius.circular(15.0),
                                                      topRight:
                                                      Radius.circular(15.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(15.0, 0.0,
                                                        15.0, 0.0),
                                                    child: Text(
                                                      'Food Category',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 9.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  15.0, 0.0, 0.0, 0.0),
                              child: Text(
                                'Recommended for you',
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
                        ],
                      ),
                      Divider(
                        thickness: 1.0,
                        color: FlutterFlowTheme.of(context).accent4,
                      ),
                      Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height,
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.sizeOf(context).width,
                          maxHeight: MediaQuery.sizeOf(context).height,
                        ),
                        decoration: BoxDecoration(),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          children: [
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.94,
                              height: MediaQuery.sizeOf(context).height * 0.251,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: Container(
                                  width:
                                  MediaQuery.sizeOf(context).width * 0.94,
                                  height:
                                  MediaQuery.sizeOf(context).height * 0.269,
                                  constraints: BoxConstraints(
                                    maxWidth: 80.0,
                                    maxHeight: 80.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.93,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(0.0),
                                                  bottomRight:
                                                  Radius.circular(0.0),
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                  Radius.circular(8.0),
                                                ),
                                                child: Image.network(
                                                  'https://picsum.photos/seed/435/600',
                                                  width:
                                                  MediaQuery.sizeOf(context)
                                                      .width *
                                                      0.94,
                                                  height:
                                                  MediaQuery.sizeOf(context)
                                                      .height *
                                                      0.18,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 5.0, 0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          10.0,
                                                          0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () {
                                                          print(
                                                              'Button pressed ...');
                                                        },
                                                        text: '',
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .solidHeart,
                                                          size: 15.0,
                                                        ),
                                                        options:
                                                        FFButtonOptions(
                                                          width:
                                                          MediaQuery.sizeOf(
                                                              context)
                                                              .width *
                                                              0.055,
                                                          height:
                                                          MediaQuery.sizeOf(
                                                              context)
                                                              .height *
                                                              0.026,
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              3.5,
                                                              4.0,
                                                              0.0,
                                                              0.0),
                                                          iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              0.0),
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primary,
                                                          textStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .titleSmall
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            color: Colors
                                                                .white,
                                                            fontSize:
                                                            1.0,
                                                          ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                          BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              24.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 10.0, 0.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Food Name',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryText,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    150.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'PKR',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 10.0, 0.0),
                                                child: Text(
                                                  'ItemPrice',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.delivery_dining,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              size: 10.0,
                                            ),
                                            Text(
                                              'Free delivery',
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .secondaryText,
                                                fontSize: 10.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                            FaIcon(
                                              FontAwesomeIcons
                                                  .gripLinesVertical,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              size: 10.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                width:
                                                MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.2,
                                                height:
                                                MediaQuery.sizeOf(context)
                                                    .height *
                                                    0.03,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    bottomLeft:
                                                    Radius.circular(30.0),
                                                    bottomRight:
                                                    Radius.circular(30.0),
                                                    topLeft:
                                                    Radius.circular(30.0),
                                                    topRight:
                                                    Radius.circular(30.0),
                                                  ),
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryBackground,
                                                    width: 0.0,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '4.5',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w300,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Color(0xFFE7B734),
                                                      size: 15.0,
                                                    ),
                                                    Text(
                                                      '(25+ )',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w200,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.94,
                              height: MediaQuery.sizeOf(context).height * 0.251,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: Container(
                                  width:
                                  MediaQuery.sizeOf(context).width * 0.94,
                                  height:
                                  MediaQuery.sizeOf(context).height * 0.269,
                                  constraints: BoxConstraints(
                                    maxWidth: 80.0,
                                    maxHeight: 80.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.93,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(0.0),
                                                  bottomRight:
                                                  Radius.circular(0.0),
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                  Radius.circular(8.0),
                                                ),
                                                child: Image.network(
                                                  'https://picsum.photos/seed/435/600',
                                                  width:
                                                  MediaQuery.sizeOf(context)
                                                      .width *
                                                      0.94,
                                                  height:
                                                  MediaQuery.sizeOf(context)
                                                      .height *
                                                      0.18,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 5.0, 0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          10.0,
                                                          0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () {
                                                          print(
                                                              'Button pressed ...');
                                                        },
                                                        text: '',
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .solidHeart,
                                                          size: 15.0,
                                                        ),
                                                        options:
                                                        FFButtonOptions(
                                                          width:
                                                          MediaQuery.sizeOf(
                                                              context)
                                                              .width *
                                                              0.055,
                                                          height:
                                                          MediaQuery.sizeOf(
                                                              context)
                                                              .height *
                                                              0.026,
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              3.5,
                                                              4.0,
                                                              0.0,
                                                              0.0),
                                                          iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              0.0),
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primary,
                                                          textStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .titleSmall
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            color: Colors
                                                                .white,
                                                            fontSize:
                                                            1.0,
                                                          ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                          BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              24.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 10.0, 0.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Food Name',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryText,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    150.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'PKR',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 10.0, 0.0),
                                                child: Text(
                                                  'ItemPrice',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.delivery_dining,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              size: 10.0,
                                            ),
                                            Text(
                                              'Free delivery',
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .secondaryText,
                                                fontSize: 10.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                            FaIcon(
                                              FontAwesomeIcons
                                                  .gripLinesVertical,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              size: 10.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                width:
                                                MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.2,
                                                height:
                                                MediaQuery.sizeOf(context)
                                                    .height *
                                                    0.03,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    bottomLeft:
                                                    Radius.circular(30.0),
                                                    bottomRight:
                                                    Radius.circular(30.0),
                                                    topLeft:
                                                    Radius.circular(30.0),
                                                    topRight:
                                                    Radius.circular(30.0),
                                                  ),
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryBackground,
                                                    width: 0.0,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '4.5',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w300,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Color(0xFFE7B734),
                                                      size: 15.0,
                                                    ),
                                                    Text(
                                                      '(25+ )',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w200,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.94,
                              height: MediaQuery.sizeOf(context).height * 0.251,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(0.0),
                                  bottomRight: Radius.circular(0.0),
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15.0, 0.0, 15.0, 0.0),
                                child: Container(
                                  width:
                                  MediaQuery.sizeOf(context).width * 0.94,
                                  height:
                                  MediaQuery.sizeOf(context).height * 0.269,
                                  constraints: BoxConstraints(
                                    maxWidth: 80.0,
                                    maxHeight: 80.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0),
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                          MediaQuery.sizeOf(context).width *
                                              0.93,
                                          child: Stack(
                                            children: [
                                              ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(0.0),
                                                  bottomRight:
                                                  Radius.circular(0.0),
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                  Radius.circular(8.0),
                                                ),
                                                child: Image.network(
                                                  'https://picsum.photos/seed/435/600',
                                                  width:
                                                  MediaQuery.sizeOf(context)
                                                      .width *
                                                      0.94,
                                                  height:
                                                  MediaQuery.sizeOf(context)
                                                      .height *
                                                      0.18,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 5.0, 0.0, 0.0),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0.0,
                                                          0.0,
                                                          10.0,
                                                          0.0),
                                                      child: FFButtonWidget(
                                                        onPressed: () {
                                                          print(
                                                              'Button pressed ...');
                                                        },
                                                        text: '',
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .solidHeart,
                                                          size: 15.0,
                                                        ),
                                                        options:
                                                        FFButtonOptions(
                                                          width:
                                                          MediaQuery.sizeOf(
                                                              context)
                                                              .width *
                                                              0.055,
                                                          height:
                                                          MediaQuery.sizeOf(
                                                              context)
                                                              .height *
                                                              0.026,
                                                          padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              3.5,
                                                              4.0,
                                                              0.0,
                                                              0.0),
                                                          iconPadding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0.0,
                                                              0.0,
                                                              0.0,
                                                              0.0),
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primary,
                                                          textStyle:
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .titleSmall
                                                              .override(
                                                            fontFamily:
                                                            'Readex Pro',
                                                            color: Colors
                                                                .white,
                                                            fontSize:
                                                            1.0,
                                                          ),
                                                          elevation: 0.0,
                                                          borderSide:
                                                          BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              24.0),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 10.0, 0.0, 5.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    10.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'Food Name',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .bodyMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    color:
                                                    FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryText,
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    150.0, 0.0, 0.0, 0.0),
                                                child: Text(
                                                  'PKR',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                    0.0, 0.0, 10.0, 0.0),
                                                child: Text(
                                                  'ItemPrice',
                                                  style: FlutterFlowTheme.of(
                                                      context)
                                                      .labelMedium
                                                      .override(
                                                    fontFamily:
                                                    'Readex Pro',
                                                    fontWeight:
                                                    FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(
                                              Icons.delivery_dining,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              size: 10.0,
                                            ),
                                            Text(
                                              'Free delivery',
                                              style: FlutterFlowTheme.of(
                                                  context)
                                                  .bodyMedium
                                                  .override(
                                                fontFamily: 'Readex Pro',
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .secondaryText,
                                                fontSize: 10.0,
                                                fontWeight:
                                                FontWeight.normal,
                                              ),
                                            ),
                                            FaIcon(
                                              FontAwesomeIcons
                                                  .gripLinesVertical,
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                              size: 10.0,
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                              child: Container(
                                                width:
                                                MediaQuery.sizeOf(context)
                                                    .width *
                                                    0.2,
                                                height:
                                                MediaQuery.sizeOf(context)
                                                    .height *
                                                    0.03,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                  BorderRadius.only(
                                                    bottomLeft:
                                                    Radius.circular(30.0),
                                                    bottomRight:
                                                    Radius.circular(30.0),
                                                    topLeft:
                                                    Radius.circular(30.0),
                                                    topRight:
                                                    Radius.circular(30.0),
                                                  ),
                                                  shape: BoxShape.rectangle,
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                        context)
                                                        .secondaryBackground,
                                                    width: 0.0,
                                                  ),
                                                ),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.min,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '4.5',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w300,
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Color(0xFFE7B734),
                                                      size: 15.0,
                                                    ),
                                                    Text(
                                                      '(25+ )',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodyMedium
                                                          .override(
                                                        fontFamily:
                                                        'Readex Pro',
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .secondaryText,
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w200,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 10.0)),
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
    // return Scaffold(
    //   key: _scaffoldKey,
    //   drawer: const MyDrawer(),
    //   appBar: AppBar(
    //     title: Column(
    //       children: [
    //         const Text(
    //           'Delivery Address',
    //           style: TextStyle(
    //               color: ColorsApp.splashBackgroundColorApp, fontSize: 12),
    //         ),
    //         Text(
    //           _currentAddress ?? "",
    //           style: const TextStyle(color: ColorsApp.stormGrey, fontSize: 14),
    //         )
    //       ],
    //     ),
    //     leading: IconButton(
    //       icon: const Icon(Icons.menu_outlined,
    //           size: 33, color: ColorsApp.stormGrey),
    //       onPressed: () => _scaffoldKey.currentState?.openDrawer(),
    //     ),
    //     backgroundColor: ColorsApp.backgroundColorApp,
    //     centerTitle: true,
    //     actions: [
    //       Padding(
    //           padding: const EdgeInsets.only(right: 19),
    //           child: SvgPicture.asset(
    //             'assets/App_cart_logo.svg',
    //           ))
    //     ],
    //   ),
    // );
  }
}
