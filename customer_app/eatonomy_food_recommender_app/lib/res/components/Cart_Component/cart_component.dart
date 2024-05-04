import 'package:eatonomy_food_recommender_app/view/cart/persistent_shopping_cart.dart';
import 'package:flutter/material.dart';
import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../Count_Selector_Component/count_selector_component.dart';

class CartComponent extends StatelessWidget {
  final String? imageURL;
  final String dishName;
  final double price;
  final String productID;

  // final ValueChanged<int> onChanged;

  const CartComponent({
    super.key,
    required this.imageURL,
    required this.dishName,
    required this.price,
    required this.productID,
    // required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.2,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  imageURL!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          dishName,
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: const Color(0xFF43464D),
                                    fontSize: 15.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          PersistentShoppingCart().removeFromCart(productID);
                          // Add your delete action here
                        },
                        icon: const Icon(
                          Icons.delete_outline,
                          color: ColorsApp.splashBackgroundColorApp,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Text(
                          'PKR',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Readex Pro',
                                    color: FlutterFlowTheme.of(context).primary,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 2.0),
                          child: Text(
                            price.toString(),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Readex Pro',
                                  color: const Color(0xFF43464D),
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CountSelector(
                          onChanged: (a) {},
                          productID: productID,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
