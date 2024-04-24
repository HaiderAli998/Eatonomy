import 'package:eatonomy_food_recommender_app/res/components/colors_app.dart';
import 'package:flutter/material.dart';

class CountSelector extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;

  const CountSelector({
    super.key,
    this.initialValue = 0,
    required this.onChanged,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CountSelectorState createState() => _CountSelectorState();
}

class _CountSelectorState extends State<CountSelector> {
  late int _count;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 30,
      decoration: BoxDecoration(
        color: ColorsApp.backgroundColorApp,
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
        border: Border.all(
          color: ColorsApp.alternate,
          width: 0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _decrement,
            icon: const Icon(Icons.remove),
            padding: EdgeInsets.zero,
          ),
          Text(
            '$_count',
            style: const TextStyle(fontSize: 14),
          ),
          IconButton(
            onPressed: _increment,
            icon: const Icon(Icons.add),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  void _increment() {
    setState(() {
      _count++;
      widget.onChanged(_count);
    });
  }

  void _decrement() {
    setState(() {
      if (_count > 0) {
        _count--;
        widget.onChanged(_count);
      }
    });
  }
}
