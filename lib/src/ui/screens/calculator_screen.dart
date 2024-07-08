import 'package:calculator/src/ui/calculator_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/calculator_provider.dart';

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _displayController = TextEditingController();

  double _firstNumber = 0;
  double _secondNumber = 0;
  String _operation = '';
  bool _isOperationSelected = false;
  String _displayText = '';

  void _onNumberPressed(String number) {
    setState(() {
      if (_isOperationSelected) {
        _displayText = number;
        _isOperationSelected = false;
      } else {
        _displayText += number;
      }
      _displayController.text = _displayText;
    });
  }

  void _onOperationPressed(String operation) {
    setState(() {
      _firstNumber = double.parse(_displayController.text);
      _operation = operation;
      _displayText += ' $operation ';
      _displayController.text = _displayText;
      _isOperationSelected = true;
    });
  }

  void _onEqualsPressed(CalculatorProvider calculatorProvider) {
    setState(() {
      _secondNumber = double.parse(_displayController.text.split(' ').last);
      switch (_operation) {
        case '+':
          calculatorProvider.add(_firstNumber, _secondNumber);
          break;
        case '-':
          calculatorProvider.subtract(_firstNumber, _secondNumber);
          break;
        case '*':
          calculatorProvider.multiply(_firstNumber, _secondNumber);
          break;
        case '/':
          calculatorProvider.divide(_firstNumber, _secondNumber);
          break;
      }
      _displayText = calculatorProvider.result.toString();
      _displayController.text = _displayText;
      _isOperationSelected = false;
    });
  }

  void _onClearPressed(CalculatorProvider calculatorProvider) {
    setState(() {
      _displayController.clear();
      _displayText = '';
      _firstNumber = 0;
      _secondNumber = 0;
      _operation = '';
      _isOperationSelected = false;
      calculatorProvider.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(24),
              child: TextField(
                controller: _displayController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                readOnly: true,
                textAlign: TextAlign.right,
              ),
            ),
          ),
          Row(
            children: [
              CalculatorButton('1', () => _onNumberPressed('1')),
              CalculatorButton('2', () => _onNumberPressed('2')),
              CalculatorButton('3', () => _onNumberPressed('3')),
              CalculatorButton('+', () => _onOperationPressed('+')),
            ],
          ),
          Row(
            children: [
              CalculatorButton('4', () => _onNumberPressed('4')),
              CalculatorButton('5', () => _onNumberPressed('5')),
              CalculatorButton('6', () => _onNumberPressed('6')),
              CalculatorButton('-', () => _onOperationPressed('-')),
            ],
          ),
          Row(
            children: [
              CalculatorButton('7', () => _onNumberPressed('7')),
              CalculatorButton('8', () => _onNumberPressed('8')),
              CalculatorButton('9', () => _onNumberPressed('9')),
              CalculatorButton('*', () => _onOperationPressed('*')),
            ],
          ),
          Row(
            children: [
              CalculatorButton('0', () => _onNumberPressed('0')),
              CalculatorButton('C', () => _onClearPressed(calculatorProvider)),
              CalculatorButton('=', () => _onEqualsPressed(calculatorProvider)),
              CalculatorButton('/', () => _onOperationPressed('/')),
            ],
          ),
        ],
      ),
    );
  }
}
