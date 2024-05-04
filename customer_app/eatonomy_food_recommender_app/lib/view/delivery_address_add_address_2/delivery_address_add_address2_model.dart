import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'delivery_address_add_address2_widget.dart'
    show DeliveryAddressAddAddress2Widget;
import 'package:flutter/material.dart';

class DeliveryAddressAddAddress2Model
    extends FlutterFlowModel<DeliveryAddressAddAddress2Widget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();

  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    unfocusNode.dispose();
  }
}
