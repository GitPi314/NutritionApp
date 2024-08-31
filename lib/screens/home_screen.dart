import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_item.dart';
import '../services/nutrient_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                final foodItem = await showFoodSelectionDialog(context);
                if (foodItem != null) {
                  Provider.of<NutrientProvider>(context, listen: false)
                      .addFoodItem(foodItem, 100); // Beispiel: 100g hinzugefügt
                }
              },
              child: const Text('Lebensmittel hinzufügen'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Füge Lebensmittel hinzu, um deine tägliche Nährstoffaufnahme zu verfolgen!',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<FoodItem?> showFoodSelectionDialog(BuildContext context) async {
    // Dies ist ein Platzhalter für den Lebensmittelauswahldialog.
    // In einer vollständigen Implementierung würdest du hier einen Dialog anzeigen,
    // um ein Lebensmittel aus einer Liste auszuwählen und die Menge anzugeben.

    // Beispiel für ein ausgewähltes Lebensmittel
    final exampleFoodItem = FoodItem(
      productName: 'Beispiel Lebensmittel',
      mainNutrients: {
        'Fett': Nutrient(amount: '10.0', unit: 'g'),
        'Eiweiß': Nutrient(amount: '20.0', unit: 'g'),
      },
      vitamins: {
        'Vitamin C': Nutrient(amount: '50.0', unit: 'mg'),
      },
      minerals: {
        'Calcium': Nutrient(amount: '100.0', unit: 'mg'),
      },
    );

    return exampleFoodItem;
  }
}
