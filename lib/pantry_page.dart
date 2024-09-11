import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart';

class PantryPage extends StatefulWidget {
  const PantryPage({super.key});
  @override
  State<PantryPage> createState() => _PantryPageState();
}

class _PantryPageState extends State<PantryPage> {
  @override
  Widget build(BuildContext context) {
    final groceryItems = context.watch<MyAppState>().groceryItems;


    if (groceryItems.isEmpty) {
      return Center(
        child: Text('No items yet.'),
      );
    }


    return Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('Your grocery items:'),
            ),
            for (var item in groceryItems)
              ListTile(title: Text(item))
          ]
        ),
      );
  }
}


