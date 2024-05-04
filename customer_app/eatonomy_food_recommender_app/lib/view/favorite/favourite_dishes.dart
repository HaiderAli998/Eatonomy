import 'package:flutter/material.dart';

class FavDishes extends StatefulWidget {
  const FavDishes({super.key});

  @override
  State<FavDishes> createState() => _FavDishesState();
}

class _FavDishesState extends State<FavDishes> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Favourite Dishes')),
    );
  }
}
