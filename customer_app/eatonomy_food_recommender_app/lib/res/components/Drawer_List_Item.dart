import 'package:flutter/material.dart';

class DrawerListItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const DrawerListItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
    );
  }
}
