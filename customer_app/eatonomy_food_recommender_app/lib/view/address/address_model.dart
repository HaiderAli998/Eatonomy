import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';

import 'delivery_address.dart';

class AddressModel extends FlutterFlowModel<DeliveryAddress> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
