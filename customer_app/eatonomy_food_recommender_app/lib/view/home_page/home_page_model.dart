import 'package:eatonomy_food_recommender_app/view/home_page/home_screen.dart';
import 'package:geolocator/geolocator.dart';

import '../../res/components/HomePage_Components/Current_Location.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

class HomePageModel extends FlutterFlowModel<HomeScreen> with ChangeNotifier {
  final BuildContext context; // Add this field

  HomePageModel(this.context);

  late Position _currentPosition;
  String currentAddress = 'Loading...';

  // State field(s) for TextField widget.
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  // State field(s) for PageView widget.
  PageController? pageViewController1;

  int get pageViewCurrentIndex1 => pageViewController1 != null &&
          pageViewController1!.hasClients &&
          pageViewController1!.page != null
      ? pageViewController1!.page!.round()
      : 0;

  // State field(s) for PageView widget.
  PageController? pageViewController2;

  int get pageViewCurrentIndex2 => pageViewController2 != null &&
          pageViewController2!.hasClients &&
          pageViewController2!.page != null
      ? pageViewController2!.page!.round()
      : 0;

  /// Initialization and disposal methods.

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    super.dispose();
    textController?.dispose();
  }

  Future<void> getCurrentPosition() async {
    final position = await LocationService.getCurrentPosition(context);
    if (position != null) {
      _currentPosition = position;
      _getAddressFromLatLng(_currentPosition);
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    final address = await LocationService.getAddressFromLatLng(position);
    currentAddress = address;
    notifyListeners();
  }

  String get getAddress => currentAddress;

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
