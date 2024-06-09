import 'package:eatonomy_food_recommender_app/view/provider/fav_dish_provider.dart'; // Assuming DishProvider is the correct import
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../flutter_flow/flutter_flow_widgets.dart';
import '../../../view/model/dish_data_model.dart';
import '../Colors/colors_app.dart';

class DishCard extends StatefulWidget {
  final String imageUrl;
  final String productName;
  final int price;
  final int restaurantID;
  final int dishID;
  final bool isDeliveryFree;
  final double rating;
  final int numberOfReviews;
  final String description;
  final String deliveryTime;
  final VoidCallback onTap;

  const DishCard(
      {super.key,
      required this.imageUrl,
      required this.productName,
      required this.price,
      required this.isDeliveryFree,
      required this.rating,
      required this.numberOfReviews,
      required this.onTap,
      required this.restaurantID,
      required this.deliveryTime,
      required this.description,
      required this.dishID});

  @override
  State<DishCard> createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dishProvider = Provider.of<DishProvider>(context);
    final isLiked = dishProvider.isLiked(widget.dishID);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.94,
        height: MediaQuery.of(context).size.height * 0.255,
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
            width: MediaQuery.of(context).size.width * 0.94,
            height: MediaQuery.of(context).size.height * 0.269,
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
                  buildTopImage(context, dishProvider, isLiked),
                  buildProductInfo(context),
                  buildDeliveryAndRatingInfo(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTopImage(
      BuildContext context, DishProvider dishProvider, bool isLiked) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.93,
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
              width: MediaQuery.of(context).size.width * 0.94,
              height: MediaQuery.of(context).size.height * 0.18,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: 10,
            right: 20,
            child: FFButtonWidget(
              icon: FaIcon(
                isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                color: Colors.white,
                size: 15,
              ),
              onPressed: () {
                if (isLiked) {
                  dishProvider.removeDish(widget.dishID);
                } else {
                  dishProvider.addDish(DishModel(
                    imageUrl: widget.imageUrl,
                    productName: widget.productName,
                    price: widget.price,
                    dishID: widget.dishID,
                    restaurantID: widget.restaurantID,
                    isDeliveryFree: widget.isDeliveryFree,
                    rating: widget.rating,
                    numberOfReviews: widget.numberOfReviews,
                    onTap: widget.onTap,
                    isLiked: isLiked,
                    description: '',
                    deliveryTime: '',
                  ));
                }
              },
              text: '',
              options: FFButtonOptions(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                iconPadding: const EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
                color: ColorsApp.splashBackgroundColorApp,
                width: 35,
                height: 35,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
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
    );
  }

  Widget buildProductInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 5.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.productName,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            "\$${widget.price}",
            style: const TextStyle(
                color: ColorsApp.splashBackgroundColorApp,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildDeliveryAndRatingInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.isDeliveryFree ? 'Free delivery' : 'Paid delivery',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontSize: 10.0,
                  fontWeight: FontWeight.normal,
                ),
          ),
          Text(
            '${widget.rating} (${widget.numberOfReviews}+)',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontSize: 10.0,
                  fontWeight: FontWeight.w200,
                ),
          ),
        ],
      ),
    );
  }
}
