import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../res/components/HomePage_Components/categories_container.dart';
import '../food_categories/food_categories_widget.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: const BoxDecoration(),
        child: GridView(
          padding: EdgeInsets.zero,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 1.0,
          ),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          children: [
            CustomCategoryContainer(
                svgPath: 'assets/icons/hamburger.svg',
                text: 'Burgers',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            appBarTitle: 'Burgers',
                            dataStream: FirebaseFirestore.instance
                                .collection('Burgers')
                                .snapshots(),
                          )));
                }),
            CustomCategoryContainer(
                svgPath: 'assets/icons/pizza-pie.svg',
                text: 'Pizza',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            appBarTitle: 'Pizza',
                            dataStream: FirebaseFirestore.instance
                                .collection('Pizza')
                                .snapshots(),
                          )));
                }),
            CustomCategoryContainer(
                svgPath: 'assets/icons/bbq-2.svg',
                text: 'BBQ',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            appBarTitle: 'BBQ',
                            dataStream: FirebaseFirestore.instance
                                .collection('BBQ')
                                .snapshots(),
                          )));
                }),
            CustomCategoryContainer(
                svgPath: 'assets/icons/chicken.svg',
                text: 'Broast',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            appBarTitle: 'Broast',
                            dataStream: FirebaseFirestore.instance
                                .collection('Broast')
                                .snapshots(),
                          )));
                }),
            CustomCategoryContainer(
                svgPath: 'assets/icons/chinese-2.svg',
                text: 'Chinese',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            appBarTitle: 'Chinese',
                            dataStream: FirebaseFirestore.instance
                                .collection('Chinese')
                                .snapshots(),
                          )));
                }),
            CustomCategoryContainer(
                svgPath: 'assets/icons/biryani.svg',
                text: 'Biryani',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            appBarTitle: 'Biryani',
                            dataStream: FirebaseFirestore.instance
                                .collection('Biryani')
                                .snapshots(),
                          )));
                }),
            CustomCategoryContainer(
                svgPath: 'assets/icons/desi.svg',
                text: 'Desi',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            appBarTitle: 'Desi',
                            dataStream: FirebaseFirestore.instance
                                .collection('Desi')
                                .snapshots(),
                          )));
                }),
            CustomCategoryContainer(
                svgPath: 'assets/icons/sandwich-01.svg',
                text: 'Sandwich',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            appBarTitle: 'Sandwich',
                            dataStream: FirebaseFirestore.instance
                                .collection('Sandwich')
                                .snapshots(),
                          )));
                }),
            CustomCategoryContainer(
                svgPath: 'assets/icons/pasta.svg',
                text: 'Pasta',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            appBarTitle: 'Pasta',
                            dataStream: FirebaseFirestore.instance
                                .collection('Pasta')
                                .snapshots(),
                          )));
                }),
            CustomCategoryContainer(
                svgPath: 'assets/icons/shawarma.svg',
                text: 'Shawarma',
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => CategoryScreen(
                            appBarTitle: 'Shawarma',
                            dataStream: FirebaseFirestore.instance
                                .collection('Shawarma')
                                .snapshots(),
                          )));
                }),
            CustomCategoryContainer(
              svgPath: 'assets/icons/ice-cream.svg',
              text: 'Ice-Cream',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                          appBarTitle: 'Ice-Cream',
                          dataStream: FirebaseFirestore.instance
                              .collection('Ice-Cream')
                              .snapshots(),
                        )));
              },
            ),
            CustomCategoryContainer(
              svgPath: 'assets/icons/tea.svg',
              text: 'Tea',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => CategoryScreen(
                          appBarTitle: 'Tea',
                          dataStream: FirebaseFirestore.instance
                              .collection('Tea')
                              .snapshots(),
                        )));
              },
            ),
          ],
        ),
      ),
    );
  }
}
