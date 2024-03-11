import 'package:flutter/material.dart';

import 'Drawer_List_Item.dart';

class MyDrawerList extends StatelessWidget {
  const MyDrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const <Widget>[
        DrawerListItem(
          icon: Icons.category,
          title: "Category",
        ),
        DrawerListItem(
          icon: Icons.shopping_cart_rounded,
          title: "My Cart",
        ),
        DrawerListItem(
          icon: Icons.add_location,
          title: "Delivery Address",
        ),
        DrawerListItem(
          icon: Icons.payment,
          title: "Payment Methods",
        ),
        DrawerListItem(
          icon: Icons.help_outline_rounded,
          title: "Help",
        ),
      ],
    );
  }
}
