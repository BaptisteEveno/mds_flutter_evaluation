import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class InventoryItemProvider with ChangeNotifier {
  InventoryItem? _inventoryItem;
  List<InventoryItem> _inventoryItems = [];

  InventoryItem? get inventoryItem => _inventoryItem;

  List<InventoryItem> get inventoryItems => _inventoryItems;

  void setInventoryItem(InventoryItem? item) {
    _inventoryItem = item;
    notifyListeners();
  }

  void addRecipeToInventory(InventoryItem item) {
    print("************************ ITEM ************************");
    print(item);
    _inventoryItems.add(item);
    notifyListeners();
  }
}

class InventoryItem {
  final String name;

  InventoryItem({required this.name});
}

class _InventoryPageState extends State<InventoryPage> {

  // Méthode pour ajouter une recette au tableau

  Widget _buildListView() {
    var inventoryItemProvider = Provider.of<InventoryItemProvider>(context);
    var inventoryItems = inventoryItemProvider.inventoryItems; // Accédez à inventoryItems via le provider

    return ListView.builder(
      itemCount: inventoryItems.length,
      itemBuilder: (context, index) {
        var inventoryItem = inventoryItems[index];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(child: Text(inventoryItem.name)),
              ],
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    var inventoryItemProvider = Provider.of<InventoryItemProvider>(context);
    var inventoryItem = inventoryItemProvider.inventoryItem;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Page d'inventaire"),
      ),
      body: Center(
        child: inventoryItem != null
            ? _buildListView()
            : Text("Aucun objet dans l'inventaire"),
      ),
    );
  }
}
