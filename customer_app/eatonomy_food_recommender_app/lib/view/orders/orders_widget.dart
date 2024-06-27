import 'package:eatonomy_food_recommender_app/view/drawer/Drawer.dart';
import 'package:eatonomy_food_recommender_app/view/orders/order_component.dart';
import 'package:eatonomy_food_recommender_app/view/orders/recent_order_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/shared_pref_service.dart';
import '../cart/persistent_shopping_cart.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'orders_model.dart';
export 'orders_model.dart';

class OrdersWidget extends StatefulWidget {
  const OrdersWidget({super.key});

  @override
  State<OrdersWidget> createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends State<OrdersWidget> {
  late OrdersModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => OrdersModel());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final SharedPreferencesService prefsService = SharedPreferencesService();
      var v = await prefsService.getObjectList("key");

      // Clear existing items to prevent duplication
      Provider.of<CartProvider>(context, listen: false).clearCartItems();

      // Ensure the data is not null
      if (v.isNotEmpty) {
        Provider.of<CartProvider>(context, listen: false).setCartItems(v);
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: MyDrawer(),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, _) => [
            SliverAppBar(
              pinned: false,
              floating: false,
              backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
              iconTheme: IconThemeData(
                  color: FlutterFlowTheme.of(context).secondaryText),
              automaticallyImplyLeading: true,
              actions: [
                PersistentShoppingCart().showCartItemCountWidget(
                    cartItemCountWidgetBuilder: (itemCount) => IconButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RoutesName.cartScreen);
                          },
                          icon: Badge(
                            label: Text(itemCount.toString()),
                            child: const Icon(Icons.shopping_bag_outlined),
                          ),
                        ))
              ],
              leading: IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
              centerTitle: true,
              elevation: 0.0,
              title: Text(
                'Orders',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Outfit',
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
          body: ListView.builder(
            itemCount: cartProvider.cartItems.length,
            itemBuilder: (context, index) {
              final item = cartProvider.cartItems[index];
              return OrderComponent(
                dishName: item.productName,
                productID: item.quantity.toString(),
                price: item.unitPrice,
              );
            },
          ),
        ),
      ),
    );
  }
}
