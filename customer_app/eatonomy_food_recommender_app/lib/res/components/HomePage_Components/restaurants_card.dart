import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../view/model/restaurant_data_model.dart';
import '../Colors/colors_app.dart';
import '../../../view/provider/fav_restaurant_provider.dart';

class CustomRestaurantCard extends StatefulWidget {
  final String imageUrl;
  final int id;
  final String restaurantName;
  final double rating;
  final int numberOfReviews;
  final bool isDeliveryFree;
  final String deliveryTime;
  final List<String> openingHours;
  final List<String> foodCategories;
  final VoidCallback onTap;

  const CustomRestaurantCard({
    super.key,
    required this.imageUrl,
    required this.id,
    required this.restaurantName,
    required this.rating,
    required this.openingHours,
    required this.numberOfReviews,
    required this.isDeliveryFree,
    required this.deliveryTime,
    required this.foodCategories,
    required this.onTap,
  });

  @override
  State<CustomRestaurantCard> createState() => _CustomRestaurantCardState();
}

class _CustomRestaurantCardState extends State<CustomRestaurantCard> {
  @override
  Widget build(BuildContext context) {
    final restaurantProvider = Provider.of<FavRestaurantProvider>(context);
    final isLiked = restaurantProvider.isLiked(widget.id);

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.3,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15.0, 0.0, 15.0, 0.0),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.3,
            constraints: const BoxConstraints(
              maxWidth: 80.0,
              maxHeight: 80.0,
            ),
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).secondaryBackground,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
            ),
            child: Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 34,
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(0.0),
                            bottomRight: Radius.circular(0.0),
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0),
                          ),
                          child: Image.network(
                            widget.imageUrl,
                            width: MediaQuery.of(context).size.width * 34,
                            height: MediaQuery.of(context).size.height * 0.18,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 5.0, 0.0, 0.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: const BorderRadius.only(
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(30.0),
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                  ),
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    width: 0.0,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      widget.rating.toString(),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.w300,
                                          ),
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Color(0xFFE7B734),
                                      size: 15.0,
                                    ),
                                    Text(
                                      '(${widget.numberOfReviews}+)',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Readex Pro',
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryText,
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.w200,
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: FFButtonWidget(
                                icon: FaIcon(
                                  isLiked
                                      ? FontAwesomeIcons.solidHeart
                                      : FontAwesomeIcons.heart,
                                  color: Colors.white,
                                  size: 15,
                                ),
                                onPressed: () {
                                  if (isLiked) {
                                    restaurantProvider
                                        .removeRestaurant(widget.id);
                                  } else {
                                    restaurantProvider.addRestaurant(
                                      RestaurantModel(
                                        imageUrl: widget.imageUrl,
                                        restaurantName: widget.restaurantName,
                                        isDeliveryFree: widget.isDeliveryFree,
                                        isLiked: true,
                                        price: 0,
                                        rating: widget.rating,
                                        numberOfReviews: widget.numberOfReviews,
                                        onTap: widget.onTap,
                                        restaurantID: widget.id,
                                        description: '',
                                        deliveryTime: widget.deliveryTime,
                                        foodCategories: widget.foodCategories,
                                        openingHours: widget.openingHours,
                                      ),
                                    );
                                  }
                                },
                                text: '',
                                options: FFButtonOptions(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 0, 0),
                                  iconPadding:
                                      const EdgeInsetsDirectional.fromSTEB(
                                          8, 0, 0, 0),
                                  color: ColorsApp.splashBackgroundColorApp,
                                  width: 35,
                                  height: 35,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Readex Pro',
                                        color: Colors.white,
                                        fontSize: 2,
                                      ),
                                  elevation: 0,
                                  borderSide: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        0.0, 10.0, 0.0, 5.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: Text(
                            widget.restaurantName,
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 0.0, 0.0),
                          child: FaIcon(
                            FontAwesomeIcons.solidCircleCheck,
                            color: FlutterFlowTheme.of(context).primary,
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
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 0.0, 0.0),
                        child: Icon(
                          Icons.delivery_dining,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 10.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            5.0, 0.0, 0.0, 0.0),
                        child: Text(
                          widget.isDeliveryFree
                              ? 'Free delivery'
                              : 'Delivery charges apply',
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Readex Pro',
                                color:
                                    FlutterFlowTheme.of(context).secondaryText,
                                fontSize: 10.0,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            35.0, 0.0, 0.0, 0.0),
                        child: FaIcon(
                          FontAwesomeIcons.stopwatch,
                          color: FlutterFlowTheme.of(context).primary,
                          size: 10.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            5.0, 0.0, 0.0, 0.0),
                        child: Text(
                          '${widget.deliveryTime}mins',
                          style:
                              FlutterFlowTheme.of(context).labelSmall.override(
                                    fontFamily: 'Readex Pro',
                                    fontSize: 9.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-1.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 5.0, 0.0, 0.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                            widget.foodCategories.length,
                            (index) => Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  5.0, 0.0, 0.0, 0.0),
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0x51FFFFFF),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0),
                                    topRight: Radius.circular(15.0),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      5.0, 0.0, 5.0, 0.0),
                                  child: Text(
                                    widget.foodCategories[index],
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Readex Pro',
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryText,
                                          fontSize: 9.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
