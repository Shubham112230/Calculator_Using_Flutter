import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/providers/calculator_provider.dart';
import 'src/ui/screens/calculator_screen.dart';
import 'src/utils/locator.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Calculator',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CalculatorScreen(),
      ),
    );
  }
}
