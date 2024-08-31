import 'package:flutter/material.dart';
import '../models/food_item.dart';

class NutrientProvider with ChangeNotifier {
  Map<String, double> _dailyIntake = {};
  Map<String, double> _recommendedAmounts = {
    'Beta Carotin': 5.0,
    'Biotin': 30.0,
    'Calcium': 1000.0,
    'Chrom': 35.0,
    'Coenzym Q10': 100.0,
    'Eisen': 18.0,
    'Essentielle Fettsäuren': 20.0,
    'Fluor': 4.0,
    'Jod': 150.0,
    'Kalium': 4700.0,
    'Kupfer': 900.0,
    'L-Carnitin': 500.0,
    'Magnesium': 400.0,
    'Mangan': 2.3,
    'Natrium': 1500.0,
    'Phosphor': 700.0,
    'Selen': 55.0,
    'Zink': 11.0,
    'Vitamin A': 900.0,
    'Vitamin B1': 1.2,
    'Vitamin B2': 1.3,
    'Vitamin B3': 16.0,
    'Vitamin B5': 5.0,
    'Vitamin B6': 1.7,
    'Vitamin B9': 400.0,
    'Vitamin B12': 2.4,
    'Vitamin C': 90.0,
    'Vitamin D': 20.0,
    'Vitamin E': 15.0,
    'Vitamin K': 120.0,
  };

  Map<String, double> get dailyIntake => _dailyIntake;

  Map<String, double> get recommendedAmounts => _recommendedAmounts;

  void addFoodItem(FoodItem food, double quantity) {
    _updateNutrients(food.mainNutrients, quantity);
    _updateNutrients(food.vitamins, quantity);
    _updateNutrients(food.minerals, quantity);
    notifyListeners();
  }

  void _updateNutrients(Map<String, Nutrient> nutrients, double quantity) {
    nutrients.forEach((name, nutrient) {
      final amount = double.tryParse(nutrient.amount.replaceAll(",", ".")) ?? 0;
      if (amount > 0) {
        _dailyIntake[name] = (_dailyIntake[name] ?? 0) + amount * quantity / 100;
      }
    });
  }

  double getIntakePercentage(String nutrientName) {
    final intake = _dailyIntake[nutrientName] ?? 0.0;
    final recommended = _recommendedAmounts[nutrientName] ?? 100.0; // Standardwert 100, falls nichts festgelegt
    return (intake / recommended) * 100;
  }

  double getRecommendedAmount(String nutrientName) {
    return _recommendedAmounts[nutrientName] ?? 100.0; // Standardwert, falls nichts festgelegt
  }

  void setRecommendedAmount(String nutrientName, double amount) {
    _recommendedAmounts[nutrientName] = amount;
    notifyListeners();
  }
}
