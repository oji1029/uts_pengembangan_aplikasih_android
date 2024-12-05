import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_simple_calculator/flutter_simple_calculator.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key}); // Menggunakan super.key di sini

  @override
  CalculatorPageState createState() => CalculatorPageState();
}

class CalculatorPageState extends State<CalculatorPage> {
  double? _currentValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Color.fromARGB(255, 11, 10, 11)],
            ),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Calculator',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SimpleCalculator(
          value: _currentValue!,
          hideExpression: false,
          hideSurroundingBorder: true,
          autofocus: true,
          onChanged: (key, value, expression) {
            setState(() {
              _currentValue = value ?? 0;
            });
            if (kDebugMode) {
              print('$key\t$value\t$expression');
            }
          },
          theme: CalculatorThemeData(
            // Border untuk kalkulator
            borderColor: Colors.grey.shade800,
            borderWidth: 2,
            // Tampilan display
            displayColor: Colors.black,
            displayStyle: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
            // Tampilan ekspresi
            expressionColor: Colors.black87,
            expressionStyle: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white70,
            ),
            // Tombol operator
            operatorColor: Colors.pinkAccent.shade200,
            operatorStyle: const TextStyle(fontSize: 25, color: Colors.white),
            // Tombol perintah
            commandColor: Colors.amber.shade400,
            commandStyle: const TextStyle(fontSize: 25, color: Colors.black),
            // Tombol angka
            numColor: Colors.blueGrey.shade800,
            numStyle: const TextStyle(fontSize: 30, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
