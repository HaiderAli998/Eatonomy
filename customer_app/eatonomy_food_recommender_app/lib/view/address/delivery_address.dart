import 'package:eatonomy_food_recommender_app/res/components/Colors/colors_app.dart';
import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/Custom_button.dart';
import 'package:eatonomy_food_recommender_app/view/model/saved_address_model.dart';
import 'package:eatonomy_food_recommender_app/view/payment_method/payment_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../flutter_flow/flutter_flow_model.dart';
import '../home_page/home_page_model.dart';
import '../provider/saved_address_provider.dart';

class DeliveryAddress extends StatefulWidget {
  final bool ButtonVisibility;

  const DeliveryAddress({
    super.key,
    required this.ButtonVisibility,
  });

  @override
  State<DeliveryAddress> createState() => _DeliveryAddressState();
}

class _DeliveryAddressState extends State<DeliveryAddress> {
  late HomePageModel _model;
  late TextEditingController workTextEditingController;
  late TextEditingController homeTextEditingController;
  late String address;
  int? selectedAddressIndex;
  bool isClickedCurrentLocation = false;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => HomePageModel(context));
    _model.textController ??= TextEditingController();
    _model.getCurrentPosition();
    workTextEditingController = TextEditingController();
    homeTextEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _model.textController?.dispose();
    workTextEditingController.dispose();
    homeTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SharedPreferences prefs;
    var savedAddressProvider =
        Provider.of<SavedAddressProvider>(context, listen: true);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsApp.backgroundColorApp,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorsApp.darkGrey,
            ),
          ),
          title: const Text(
            'Delivery Address',
            style: TextStyle(
              color: ColorsApp.darkGrey,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                padding: const EdgeInsets.all(8.0),
                icon: const Icon(
                  Icons.add,
                  color: ColorsApp.darkGrey,
                ),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: ColorsApp.backgroundColorApp,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200,
                        child: Center(
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Address Type',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: ColorsApp.darkGrey),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                                color: ColorsApp.neutralN30,
                              ),
                              InkWell(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Home Address',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: TextField(
                                          controller:
                                              homeTextEditingController,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText:
                                                  'Enter Home Address'),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              savedAddressProvider.addAddress(
                                                  SavedAddressModel(
                                                      logo: Icons.home,
                                                      addressType: 'Home',
                                                      addressDescription:
                                                          homeTextEditingController
                                                              .text));
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Save'),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.home),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Home"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                                color: ColorsApp.neutralN30,
                              ),
                              InkWell(
                                onTap: () async {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Work Address',
                                          style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        content: TextField(
                                          controller:
                                              workTextEditingController,
                                          decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText:
                                                  'Enter Work Address'),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              savedAddressProvider.addAddress(
                                                  SavedAddressModel(
                                                      logo: Icons
                                                          .home_work_rounded,
                                                      addressType: 'Work',
                                                      addressDescription:
                                                          workTextEditingController
                                                              .text));
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('Save'),
                                          )
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Icon(Icons.home_work_rounded),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Work"),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 2,
                                color: ColorsApp.neutralN30,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isClickedCurrentLocation = !isClickedCurrentLocation;
                      selectedAddressIndex = null;
                      address = _model.getAddress;
                      // Unselect saved address
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                              style: isClickedCurrentLocation
                                  ? BorderStyle.solid
                                  : BorderStyle.none,
                              color: ColorsApp.splashBackgroundColorApp)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(
                              'assets/icons/Eye_Dropper.svg',
                              fit: BoxFit.contain,
                              height: 24,
                              width: 24,
                              colorFilter: const ColorFilter.mode(
                                  ColorsApp.splashBackgroundColorApp,
                                  BlendMode.srcIn),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Current Location',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: ColorsApp.darkGrey,
                                      fontWeight: FontWeight.bold),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(_model.getAddress),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Divider(
                    thickness: 2,
                    color: ColorsApp.neutralN30,
                  ),
                ),
                const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                  child: Text(
                    'Saved Address',
                    style: TextStyle(
                        fontSize: 16,
                        color: ColorsApp.darkGrey,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: savedAddressProvider.addressModel.length,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedAddressIndex = index;
                            isClickedCurrentLocation =
                                false; // Unselect current location
                            address = savedAddressProvider
                                .addressModel[index].addressDescription;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    style: selectedAddressIndex == index
                                        ? BorderStyle.solid
                                        : BorderStyle.none,
                                    color:
                                        ColorsApp.splashBackgroundColorApp)),
                            child: ListTile(
                              leading: Icon(savedAddressProvider
                                  .addressModel[index].logo),
                              title: Text(savedAddressProvider
                                  .addressModel[index].addressType),
                              subtitle: Text(savedAddressProvider
                                  .addressModel[index].addressDescription),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            widget.ButtonVisibility
                ? Positioned(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                    child:
                        CustomButton(isEnabled: true, 'Continue', () async {
                      prefs = await SharedPreferences.getInstance();
                      prefs.setString('Address', address);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PaymentMethod(address: address),
                      ));
                    }, ColorsApp.splashBackgroundColorApp))
                : Container()
          ],
        ));
  }
}
