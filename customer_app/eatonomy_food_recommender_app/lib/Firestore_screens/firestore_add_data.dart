import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatonomy_food_recommender_app/res/components/Custom_Containers/Custom_button.dart';
import 'package:eatonomy_food_recommender_app/utils/Utils.dart';
import 'package:flutter/material.dart';

class FireStoreAddData extends StatefulWidget {
  const FireStoreAddData({super.key});

  @override
  State<FireStoreAddData> createState() => _FireStoreAddDataState();
}

class _FireStoreAddDataState extends State<FireStoreAddData> {
  final textEditingController = TextEditingController();
  bool loading = false;
  final firestore1 = FirebaseFirestore.instance.collection('users');
  final firestore2 = FirebaseFirestore.instance.collection('Restaurants');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Data to Firebase"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            TextFormField(
              controller: textEditingController,
              maxLines: 5,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            CustomButton(
              "Add",
              loading: loading,
              () {
                setState(() {
                  loading = true;
                });
                //Create Operation
                String id = DateTime.now().millisecondsSinceEpoch.toString();
                firestore1.doc().set({
                  'title': textEditingController.text,
                  'id': id.toString()
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

                firestore2
                    .doc()
                    .set({'Owner': 'Ali', 'Timing': '9 to 5'}).then((value) {
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
              },
              Colors.blue,
              isEnabled: true,
            )
          ],
        ),
      ),
    );
  }
}
