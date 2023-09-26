import 'package:calculator_app/calculator_screen.dart';
import 'package:calculator_app/calculator_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: Provider<CalculatorViewModel>(
          create: (_) => CalculatorViewModel(),
          dispose: (_, vm) => vm.dispose(),
          builder: (_, __) {
            return const CalculatorView();
          }),
    );
  }
}
