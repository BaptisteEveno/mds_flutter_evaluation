import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SwipeDemo(),
    );
  }
}

class SwipeDemo extends StatelessWidget {
  const SwipeDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Swipe Gesture Demo'),
      ),
      body: Center(
        child: GestureDetector(
          onHorizontalDragEnd: (DragEndDetails details) {
            // Calculer la direction du glissement
            if (details.velocity.pixelsPerSecond.dx > 0) {
              // Glissement vers la droite
              _showMessage(context, 'Swipe à droite détecté');
            } else {
              // Glissement vers la gauche
              _showMessage(context, 'Swipe à gauche détecté');
            }
          },
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.blue,
            child: const Center(
              child: Text(
                'Faites glisser à gauche ou à droite',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
