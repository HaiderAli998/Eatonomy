import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class FireStoreScreen extends StatefulWidget {
  const FireStoreScreen({super.key});

  @override
  State<FireStoreScreen> createState() => _FireStoreScreenState();
}

class _FireStoreScreenState extends State<FireStoreScreen> {
  final firestore1 =
      FirebaseFirestore.instance.collection('Restaurants').snapshots();

  // CollectionReference reference =
  //     FirebaseFirestore.instance.collection('Restaurants');
  List<String> titleList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FireStore List'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
              stream: firestore1,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.hasError}');
                } else if (!snapshot.hasData) {
                  return const Text('No Data Available');
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      String title =
                          snapshot.data!.docs[index]['title'].toString();
                      return Container();
                    },
                  );

                  // return Expanded(
                  // child: ListView.builder(
                  //     itemCount: snapshot.data?.docs.length,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return ListTile(
                  //         onTap: () {
                  //           // Update Operation
                  //           reference
                  //               .doc(snapshot.data!.docs[index]['id']
                  //                   .toString())
                  //               .update({
                  //             'title': 'Muhammad Ali Bukhari'
                  //           }).then((value) {
                  //             Utils.toastMessage('Update Massage');
                  //           }).onError((error, stackTrace) {
                  //             Utils.toastMessage(error.toString());
                  //           });
                  //           //Delete Operation
                  //           reference
                  //               .doc(snapshot.data!.docs[index]['id']
                  //                   .toString())
                  //               .delete();
                  //         },
                  //         //Read Operation
                  //         title: Text(
                  //             snapshot.data!.docs[index]['title'].toString()),
                  //         subtitle: Text(
                  //             snapshot.data!.docs[index]['id'].toString()),
                  //       );
                  //     }),
                  // );
                }
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesName.fireStoreAdd);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  List<String> get getTitleList => titleList;
}
