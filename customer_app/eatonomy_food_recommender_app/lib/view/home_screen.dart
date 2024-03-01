import 'package:eatonomy_food_recommender_app/res/components/colors_app.dart';
import 'package:eatonomy_food_recommender_app/view/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import '../res/components/Current_Location.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Position _currentPosition;
  String _currentAddress = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getCurrentPosition();
  }

  Future<void> _getCurrentPosition() async {
    final position =
        await LocationService.getCurrentPosition(context);

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
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MyDrawer(),
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(
                  color: ColorsApp.splashBackgroundColorApp, fontSize: 12),
            ),
            Text(
              _currentAddress ?? "",
              style: const TextStyle(color: ColorsApp.stormGrey, fontSize: 14),
            )
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu_outlined,
              size: 33, color: ColorsApp.stormGrey),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        backgroundColor: ColorsApp.backgroundColorApp,
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 19),
              child: SvgPicture.asset(
                'assets/App_cart_logo.svg',
              ))
        ],
      ),
    );
  }
}
