class FoodItem {
  final String productName;
  final Map<String, Nutrient> mainNutrients;
  final Map<String, Nutrient> vitamins;
  final Map<String, Nutrient> minerals;

  FoodItem({
    required this.productName,
    required this.mainNutrients,
    required this.vitamins,
    required this.minerals,
  });

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      productName: json['product_name'],
      mainNutrients: _parseNutrients(json['main_nutrients']),
      vitamins: _parseNutrients(json['vitamins']),
      minerals: _parseNutrients(json['minerals']),
    );
  }

  static Map<String, Nutrient> _parseNutrients(Map<String, dynamic> json) {
    return json.map((key, value) => MapEntry(key, Nutrient.fromJson(value)));
  }
}

class Nutrient {
  final String amount;
  final String unit;

  Nutrient({
    required this.amount,
    required this.unit,
  });

  factory Nutrient.fromJson(Map<String, dynamic> json) {
    return Nutrient(
      amount: json['amount'],
      unit: json['unit'],
    );
  }
}
