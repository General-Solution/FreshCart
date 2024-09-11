import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'picture_page.dart';
import 'pantry_page.dart';
import 'recipe_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyHomePage(title: "HomePage"),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var groceryItems = ['Apple', 'Banana', 'Milk']; 
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, this.initialDestinationIndex = 0});
  final String title;
  final int initialDestinationIndex;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialDestinationIndex;
  }

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = PicturePage();
        break;
      case 1:
        page = PantryPage();
        break;
      case 2:
        page = RecipePage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Row(
            children: [
              SafeArea(
                child: NavigationRail(
                  extended: constraints.maxWidth >= 600,
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.add_shopping_cart),
                      label: Text('Add Groceries'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.kitchen_outlined),
                      label: Text('My Kitchen'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.restaurant),
                      label: Text('Find Reicpes'),
                    ),
                  ],
                  selectedIndex: selectedIndex,   
                  onDestinationSelected: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
