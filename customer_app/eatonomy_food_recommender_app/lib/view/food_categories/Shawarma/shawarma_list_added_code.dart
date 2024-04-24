import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/Custom_button.dart';
import 'package:eatonomy_food_recommender_app/res/components/colors_app.dart';
import 'package:eatonomy_food_recommender_app/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShawarmaScreen extends StatefulWidget {
  const ShawarmaScreen({super.key});

  @override
  State<ShawarmaScreen> createState() => _ShawarmaScreenState();
}

class _ShawarmaScreenState extends State<ShawarmaScreen> {
  final titleEditingController = TextEditingController();
  final deliveryTimeEditingController = TextEditingController();
  final shawarmaData = FirebaseFirestore.instance.collection('Shawarma');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery
        .of(context)
        .size
        .height * 1;
    bool loading = false;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Data to the firebase"),
        backgroundColor: ColorsApp.splashBackgroundColorApp,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            const Text('Enter the Shawarma Information'),
            SizedBox(
              height: height * 0.02,
            ),
            TextField(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                // Only allow alphabets
              ],
              controller: titleEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Title',
                  hintText: 'Enter Title (only alphabets are required)'),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextField(
              controller: deliveryTimeEditingController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelText: 'Delivery Time',
                  hintText:
                  'Enter delivery Time (only alphabets are required)'),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            CustomButton('Add Data', loading: loading, () {
              setState(() {
                loading = true;
              });
              shawarmaData.doc().set({
                'title': titleEditingController.text,
                'Delivery Time': deliveryTimeEditingController.text,
              }).then((value) {
                Utils.toastMessage('Post Added');
                setState(() {
                  loading = false;
                });
              }).onError((error, stackTrace) {
                Utils.toastMessage(error.toString());
                setState(() {
                  loading = false;
                });
              });
            }, ColorsApp.splashBackgroundColorApp)
          ],
        ),
      ),
    );
  }
}
