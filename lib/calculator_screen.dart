import 'dart:math';

import 'package:calculator_app/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  ValueNotifier<String> equationNotifier = ValueNotifier("0");
  ValueNotifier<String> resultNotifier = ValueNotifier("0");
  String expression = "";

  String doesContainDecimal(String result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }

  void buttonPressed(String buttonText) {
    // decimal k check
    String equation = equationNotifier.value;
    String result = resultNotifier.value;

    if (buttonText == "AC") {
      equation = "0";
      result = "0";
    } else if (buttonText == "⌫") {
      equation = equation.substring(0, equation.length - 1);
      if (equation == "") {
        equation = "0";
      }
    } else if (buttonText == "+/-") {
      if (equation[0] != '-' && equation[0] != "0") {
        equation = '-$equation';
      } else {
        equation = equation.substring(1);
      }
    } else if (buttonText == "=") {
      expression = equation;
      expression = expression.replaceAll('×', '*');
      expression = expression.replaceAll('÷', '/');
      expression = expression.replaceAll('%', '%');

      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);

        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        if (expression.contains('%')) {
          result = doesContainDecimal(result);
        }
      } catch (e) {
        result = "Error";
      }
    } else if (equation == "0" &&
        (buttonText == "×" || buttonText == "÷" || buttonText == "+")) {
      equation = "0";
    } else {
      if (equation == "0") {
        equation = buttonText;
      } else {
        equation = equation + buttonText;
      }
    }
    equationNotifier.value = equation;
    resultNotifier.value = result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black54,
          leading: const Icon(Icons.settings, color: Colors.orange),
          actions: const [
            Padding(
              padding: EdgeInsets.only(top: 18.0),
              child: Text('DEG', style: TextStyle(color: Colors.white38)),
            ),
            SizedBox(width: 20),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ValueListenableBuilder(
                                  valueListenable: resultNotifier,
                                  builder: (_, result, ___) {
                                    return Text(result,
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 80));
                                  })),
                          const Icon(Icons.more_vert,
                              color: Colors.orange, size: 30),
                          const SizedBox(width: 20),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: ValueListenableBuilder(
                                valueListenable: equationNotifier,
                                builder: (_, equation, ___) {
                                  return Text(equation,
                                      style: const TextStyle(
                                        fontSize: 40,
                                        color: Colors.white38,
                                      ));
                                }),
                          ),
                          IconButton(
                            icon: const Icon(Icons.backspace_outlined,
                                color: Colors.orange, size: 30),
                            onPressed: () {
                              buttonPressed("⌫");
                            },
                          ),
                          const SizedBox(width: 20),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButton('AC', Colors.white10, () => buttonPressed('AC')),
                  customButton('%', Colors.white10, () => buttonPressed('%')),
                  customButton('÷', Colors.white10, () => buttonPressed('÷')),
                  customButton("×", Colors.white10, () => buttonPressed('×')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButton('7', Colors.white24, () => buttonPressed('7')),
                  customButton('8', Colors.white24, () => buttonPressed('8')),
                  customButton('9', Colors.white24, () => buttonPressed('9')),
                  customButton('-', Colors.white10, () => buttonPressed('-')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButton('4', Colors.white24, () => buttonPressed('4')),
                  customButton('5', Colors.white24, () => buttonPressed('5')),
                  customButton('6', Colors.white24, () => buttonPressed('6')),
                  customButton('+', Colors.white10, () => buttonPressed('+')),
                ],
              ),
              const SizedBox(height: 10),
              // calculator number buttons

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
//mainAxisAlignment: MainAxisAlignment.spaceAround
                    children: [
                      Row(
                        children: [
                          customButton(
                              '1', Colors.white24, () => buttonPressed('1')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          customButton(
                              '2', Colors.white24, () => buttonPressed('2')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          customButton(
                              '3', Colors.white24, () => buttonPressed('3')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          customButton('+/-', Colors.white24,
                              () => buttonPressed('+/-')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          customButton(
                              '0', Colors.white24, () => buttonPressed('0')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          customButton(
                              '.', Colors.white24, () => buttonPressed('.')),
                        ],
                      ),
                    ],
                  ),
                  customButton('=', Colors.orange, () => buttonPressed('=')),
                ],
              )
            ],
          ),
        ));
  }
}
