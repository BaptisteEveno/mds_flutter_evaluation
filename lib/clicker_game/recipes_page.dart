import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:provider/provider.dart';
import 'inventory_page.dart';
import 'main.dart'; // Remplacez par le chemin approprié


class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  _RecipesPageState createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  List<Map<String, dynamic>> _recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    String jsonString = await rootBundle.loadString('./recipes.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      _recipes = jsonResponse.cast<Map<String, dynamic>>();
    });
  }

  @override
  Widget build(BuildContext context) {
    var resourcesProvider = Provider.of<ResourcesProvider>(context);
    var charbonQuantity = resourcesProvider.resources['Charbon']?.quantity ?? 0;
    var boisQuantity = resourcesProvider.resources['Bois']?.quantity ?? 0;
    var ferQuantity = resourcesProvider.resources['Minerai de fer']?.quantity ?? 0;
    var cuivreQuantity = resourcesProvider.resources['Minerai de cuivre']?.quantity ?? 0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Recettes'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Bois : $boisQuantity'),
                Text('Charbon : $charbonQuantity'),
                Text('Fer : $ferQuantity'),
                Text('Cuivre : $cuivreQuantity'),
              ],
            ),
          ),
          Expanded(
            child: _buildListView(),
          ),
        ],
      ),
    );
  }

  final List<InventoryItem> _inventoryItems = [
    InventoryItem(name: 'Recette 1'),
    InventoryItem(name: 'Recette 2'),
    // Ajoutez d'autres éléments de votre inventaire ici
  ];


  Widget _buildListView() {
    return ListView.builder(
      itemCount: _recipes.length,
      itemBuilder: (context, index) {
        var recipe = _recipes[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text(recipe['name'].toString())),
                Expanded(child: Text(recipe['cost'].toString())),
                Expanded(child: Text(recipe['description'].toString())),
                IconButton(
                  icon: const Icon(Icons.build),
                  onPressed: () {
                    // Create an InventoryItem corresponding to this recipe
                    InventoryItem item = InventoryItem(
                      name: recipe['name'].toString(),
                    );

                    // Retrieve the InventoryItemProvider
                    var inventoryItemProvider = Provider.of<InventoryItemProvider>(context, listen: false);

                    // Update the InventoryItem object in the provider
                    inventoryItemProvider.setInventoryItem(item);


                    // Call the function to add the recipe to the inventory
                    inventoryItemProvider.addRecipeToInventory(item);

                    // Afficher un SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Recette fabriquée : ${recipe['name']}'),
                      ),
                    );
                  },
                ),

              ],
            ),
          ),
        );
      },
    );
  }

}


