import 'package:flutter/cupertino.dart';

import '../model/saved_address_model.dart';

class SavedAddressProvider extends ChangeNotifier {
  final List<SavedAddressModel> _addressModel = [];

  List<SavedAddressModel> get addressModel => _addressModel;

  void addAddress(SavedAddressModel model) {
    _addressModel.add(model);
    notifyListeners();
  }

  void clearData() {
    _addressModel.clear();
    notifyListeners();
  }

  void removeAddress(SavedAddressModel model) {
    _addressModel.remove(model);
    notifyListeners();
  }
}
