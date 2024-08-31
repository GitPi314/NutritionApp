class Micronutrient {
  final String name;
  final double intake; // Menge, die eingenommen wurde
  final double recommendedAmount; // Empfohlene Menge

  Micronutrient({
    required this.name,
    required this.intake,
    required this.recommendedAmount,
  });

  double get intakePercentage => (intake / recommendedAmount) * 100;

  String get formattedPercentage => '${intakePercentage.toStringAsFixed(1)}%';
}
