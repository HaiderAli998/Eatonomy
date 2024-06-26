import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/colors/colors_app.dart';
import '../../res/custom_containers/simple_text_form_field.dart';
import '../../utils/Utils.dart';


class AddRestaurnatWidget extends StatefulWidget {
  const AddRestaurnatWidget({super.key});

  @override
  State<AddRestaurnatWidget> createState() => _AddRestaurnatWidgetState();
}

class _AddRestaurnatWidgetState extends State<AddRestaurnatWidget> {
  final firestore = FirebaseFirestore.instance.collection('Restaurants');

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _numberOfReviews = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  FocusNode titleFocus = FocusNode();
  FocusNode deliveryTimeFocus = FocusNode();
  FocusNode idFocus = FocusNode();
  FocusNode numberOfReviewsFocus = FocusNode();
  FocusNode ratingFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorsApp.backgroundColorApp,
        title: Center(
          child: Text(
            'ADD Restaurant',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SimpleTextField(
                focusNode: titleFocus,
                controller: _titleController,
                keyboardType: TextInputType.name,
                hintText: 'Name of Restaurant',
                prefixIcon: Icons.restaurant,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, deliveryTimeFocus);
                }),
            SimpleTextField(
                focusNode: deliveryTimeFocus,
                controller: _deliveryTimeController,
                keyboardType: TextInputType.name,
                hintText: 'Delivery Time',
                prefixIcon: Icons.timelapse_outlined,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, idFocus);
                }),
            SimpleTextField(
                focusNode: idFocus,
                controller: _idController,
                keyboardType: TextInputType.number,
                hintText: 'ID of Restaurant(Integer)',
                prefixIcon: Icons.account_circle,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, numberOfReviewsFocus);
                }),
            SimpleTextField(
                focusNode: numberOfReviewsFocus,
                controller: _numberOfReviews,
                keyboardType: TextInputType.number,
                hintText: 'Number of Reviews(Integer)',
                prefixIcon: Icons.reviews,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, ratingFocus);
                }),
            SimpleTextField(
                focusNode: ratingFocus,
                controller: _ratingController,
                keyboardType: TextInputType.number,
                hintText: 'Rating of Restaurant(Double)',
                prefixIcon: Icons.stars,
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, deliveryTimeFocus);
                }),
          ],
        ),
      ),
    );
  }
}
