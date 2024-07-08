import 'package:flutter/material.dart';
import '../services/calculator_service.dart';
import '../utils/locator.dart';

class CalculatorProvider with ChangeNotifier {
  final CalculatorService _calculatorService = locator<CalculatorService>();

  double get result => _calculatorService.result;

  void add(double a, double b) {
    _calculatorService.add(a, b);
    notifyListeners();
  }

  void subtract(double a, double b) {
    _calculatorService.subtract(a, b);
    notifyListeners();
  }

  void multiply(double a, double b) {
    _calculatorService.multiply(a, b);
    notifyListeners();
  }

  void divide(double a, double b) {
    _calculatorService.divide(a, b);
    notifyListeners();
  }

  void clear() {
    _calculatorService.clear();
    notifyListeners();
  }
}
