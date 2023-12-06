import 'recipes_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'inventory_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ResourcesProvider()),
        ChangeNotifierProvider(create: (context) => InventoryItemProvider()),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clicker Game',
      debugShowCheckedModeBanner: false, // Supprimer le bandeau DEBUG
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class Resource {
  String name;
  int quantity;

  Resource(this.name, {this.quantity = 0});

  void increment() {
    quantity++;
  }
}

class ResourcesProvider with ChangeNotifier {
  final Map<String, Resource> _resources = {
    'Bois': Resource('Bois'),
    'Minerai de fer': Resource('Minerai de fer'),
    'Minerai de cuivre': Resource('Minerai de cuivre'),
    'Charbon': Resource('Charbon'),
    // Ajoutez d'autres ressources ici si nécessaire
  };

  Map<String, Resource> get resources => _resources;

  void incrementResource(String resourceName) {
    if (_resources.containsKey(resourceName)) {
      _resources[resourceName]!.increment();
      notifyListeners();
    }
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ressources'),
        actions: <Widget>[
          Tooltip(
            message: 'Les recettes',
            child: IconButton(
              icon: const Icon(Icons.menu_book),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecipesPage()),
                );
              },
            ),
          ),
          Tooltip(
            message: 'Inventaire',
            child: IconButton(
              icon: const Icon(Icons.inventory_2),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const InventoryPage()),
                );
              },
            ),
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 4,
        children: const <Widget>[
          ResourceWidget('Bois', '#967969', 'Du bois brut'),
          ResourceWidget('Minerai de fer', '#ced4da', 'Du minerai de fer brut'),
          ResourceWidget('Minerai de cuivre', '#d9480f', 'Du minerai de cuivre brut'),
          ResourceWidget('Charbon', '#000000', 'Du minerai de charbon'),
          // Ajouter d'autres ressources si nécessaire
        ],
      ),
    );
  }
}

class ResourceWidget extends StatefulWidget {
  final String name;
  final String colorHex;
  final String description;

  const ResourceWidget(this.name, this.colorHex, this.description, {super.key});

  @override
  _ResourceWidgetState createState() => _ResourceWidgetState();
}

class _ResourceWidgetState extends State<ResourceWidget> {
  void incrementResource(BuildContext context) {
    Provider.of<ResourcesProvider>(context, listen: false).incrementResource(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Color(int.parse(widget.colorHex.substring(1, 7), radix: 16) + 0xFF000000);
    var resource = Provider.of<ResourcesProvider>(context).resources[widget.name];

    return InkWell(
      onTap: () => incrementResource(context),
      child: Card(
        color: backgroundColor,
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(widget.name, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Quantité: ${resource?.quantity ?? 0}', style: const TextStyle(color: Colors.white)),
              ElevatedButton(
                onPressed: () => incrementResource(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.grey[700],
                ),
                child: const Text('Miner'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
