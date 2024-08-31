import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/nutrient_provider.dart';

class MicronutrientScreen extends StatefulWidget {
  const MicronutrientScreen({super.key});

  @override
  _MicronutrientScreenState createState() => _MicronutrientScreenState();
}

class _MicronutrientScreenState extends State<MicronutrientScreen> {
  bool _isVitaminsExpanded = false;
  bool _isMineralsExpanded = false;

  @override
  Widget build(BuildContext context) {
    final dailyIntake = Provider.of<NutrientProvider>(context).dailyIntake;
    final nutrientProvider = Provider.of<NutrientProvider>(context);

    // Listen der Mikronährstoffe
    final List<String> vitamins = [
      'Vitamin A',
      'Vitamin B1',
      'Vitamin B2',
      'Vitamin B3',
      'Vitamin B5',
      'Vitamin B6',
      'Vitamin B9',
      'Vitamin B12',
      'Vitamin C',
      'Vitamin D',
      'Vitamin E',
      'Vitamin K',
    ];

    final List<String> minerals = [
      'Natrium',
      'Kalium',
      'Magnesium',
      'Calcium',
      'Eisen',
      'Phosphor',
      'Kupfer',
      'Zink',
      'Chlorid',
      'Fluorid',
      'Jodid',
      'Selen',
      'Mangan',
      'Schwefel',
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFC5EBFB),
      appBar: AppBar(
        title: const Text(
          'Mikronährstoffe',
          style: TextStyle(
            fontFamily: "NunitoFont",
            fontSize: 28,
            color: Colors.black87,
          ),
        ),
        backgroundColor: const Color(0xFF38BFF9),
      ),
      body: ListView(
        children: [
          ExpansionTile(
            title: const Text(
              "Vitamine",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: _isVitaminsExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _isVitaminsExpanded = expanded;
              });
            },
            children: vitamins.map((nutrientName) {
              final intakeAmount = dailyIntake[nutrientName] ?? 0.0;
              final recommendedAmount = nutrientProvider.getRecommendedAmount(nutrientName);
              final intakePercentage = (intakeAmount / recommendedAmount) * 100;

              return MicronutrientTile(
                micronutrientName: nutrientName,
                intakePercentage: intakePercentage,
              );
            }).toList(),
          ),
          ExpansionTile(
            title: const Text(
              "Mineralstoffe & Spurenelemente",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            initiallyExpanded: _isMineralsExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _isMineralsExpanded = expanded;
              });
            },
            children: minerals.map((nutrientName) {
              final intakeAmount = dailyIntake[nutrientName] ?? 0.0;
              final recommendedAmount = nutrientProvider.getRecommendedAmount(nutrientName);
              final intakePercentage = (intakeAmount / recommendedAmount) * 100;

              return MicronutrientTile(
                micronutrientName: nutrientName,
                intakePercentage: intakePercentage,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class MicronutrientTile extends StatefulWidget {
  final String micronutrientName;
  final double intakePercentage;

  const MicronutrientTile({
    required this.micronutrientName,
    required this.intakePercentage,
    super.key,
  });

  @override
  _MicronutrientTileState createState() => _MicronutrientTileState();
}

class _MicronutrientTileState extends State<MicronutrientTile> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _setAnimation();
    _controller.forward();
  }

  @override
  void didUpdateWidget(MicronutrientTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.intakePercentage != widget.intakePercentage) {
      _setAnimation();
      _controller.reset();
      _controller.forward();
    }
  }

  void _setAnimation() {
    final double endValue = widget.intakePercentage > 160 ? 160.0 : widget.intakePercentage;
    _widthAnimation = Tween<double>(
      begin: 0.0,
      end: endValue,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = _getBarColor(widget.intakePercentage);
    final bool showBar = widget.intakePercentage > 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.micronutrientName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "NunitoFont",
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 8),
          showBar
              ? AnimatedBuilder(
            animation: _widthAnimation,
            builder: (context, child) {
              return Stack(
                children: [
                  /*
              Container(
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
              ),

               */
                  Container(
                    height: 28,
                    width: _widthAnimation.value * 2.5,
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(color: Colors.white, width: 0.75),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        '${widget.intakePercentage.toStringAsFixed(1)}%',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          )
              : const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '0%',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color _getBarColor(double percentage) {
    if (percentage < 40) {
      return const Color(0xFFFFF176); // Helles, leuchtendes Gelb
    } else if (percentage < 80) {
      return const Color(0xFF8BC34A); // Leuchtendes Lime-Grün
    } else if (percentage <= 120) {
      return const Color(0xFF4CAF50); // Leuchtendes Grün
    } else if (percentage <= 160) {
      return const Color(0xFFFFA726); // Leuchtendes Orange
    } else {
      return const Color(0xFFE57373); // Leuchtendes Rot
    }
  }
}
