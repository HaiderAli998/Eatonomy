import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedAddressModel {
  IconData logo;
  String addressType;
  String addressDescription;

  SavedAddressModel(
      {required this.logo,
      required this.addressType,
      required this.addressDescription});
}
