import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class InventoryItemProvider with ChangeNotifier {
  InventoryItem? _inventoryItem;

  InventoryItem? get inventoryItem => _inventoryItem;

  void setInventoryItem(InventoryItem? item) {
    _inventoryItem = item;
    notifyListeners();
  }
}

class InventoryItem {
  final String name;
  final IconData iconData;

  InventoryItem({required this.name, required this.iconData});
}


class _InventoryPageState extends State<InventoryPage> {
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
            ? Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(inventoryItem.iconData, size: 50.0),
            Text(inventoryItem.name),
          ],
        )
            : Text("Aucun objet dans l'inventaire"),
      ),
    );
  }
}
