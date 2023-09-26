import 'package:flutter/foundation.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorViewModel {
  String _expression = "";

  final ValueNotifier<String> _equationNotifier = ValueNotifier("0");
  final ValueNotifier<String> _resultNotifier = ValueNotifier("0");

  ValueListenable<String> get equation => _equationNotifier;
  ValueListenable<String> get result => _resultNotifier;

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
    String equation = _equationNotifier.value;
    String result = _resultNotifier.value;

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
      _expression = equation;
      _expression = _expression.replaceAll('×', '*');
      _expression = _expression.replaceAll('÷', '/');
      _expression = _expression.replaceAll('%', '%');

      try {
        Parser p = Parser();
        Expression exp = p.parse(_expression);

        ContextModel cm = ContextModel();
        result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        if (_expression.contains('%')) {
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
    _equationNotifier.value = equation;
    _resultNotifier.value = result;
  }

  void dispose() {
    _resultNotifier.dispose();
    _equationNotifier.dispose();
  }
}
