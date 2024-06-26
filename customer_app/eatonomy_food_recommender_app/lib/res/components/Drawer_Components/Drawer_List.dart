import 'package:flutter/material.dart';

import 'Drawer_List_Item.dart';

class MyDrawerList extends StatelessWidget {
  const MyDrawerList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children:  <Widget>[
        DrawerListItem(
          icon: Icons.category,
          title: "Category", onTap: () {  },
        ),
        DrawerListItem(
          icon: Icons.shopping_cart_rounded,
          title: "My Cart", onTap: () {  },
        ),
        DrawerListItem(
          icon: Icons.add_location,
          title: "Delivery Address", onTap: () {  },
        ),
        DrawerListItem(
          icon: Icons.payment,
          title: "Payment Methods", onTap: () {  },
        ),
        DrawerListItem(
          icon: Icons.help_outline_rounded,
          title: "Help", onTap: () {  },
        ),
      ],
    );
  }
}
