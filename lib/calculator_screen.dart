import 'package:calculator_app/calculator_view_model.dart';
import 'package:calculator_app/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<CalculatorViewModel>();
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
                                  valueListenable: vm.result,
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
                                valueListenable: vm.equation,
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
                              vm.buttonPressed("⌫");
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
                  customButton(
                      'AC', Colors.white10, () => vm.buttonPressed('AC')),
                  customButton(
                      '%', Colors.white10, () => vm.buttonPressed('%')),
                  customButton(
                      '÷', Colors.white10, () => vm.buttonPressed('÷')),
                  customButton(
                      "×", Colors.white10, () => vm.buttonPressed('×')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButton(
                      '7', Colors.white24, () => vm.buttonPressed('7')),
                  customButton(
                      '8', Colors.white24, () => vm.buttonPressed('8')),
                  customButton(
                      '9', Colors.white24, () => vm.buttonPressed('9')),
                  customButton(
                      '-', Colors.white10, () => vm.buttonPressed('-')),
                ],
              ),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  customButton(
                      '4', Colors.white24, () => vm.buttonPressed('4')),
                  customButton(
                      '5', Colors.white24, () => vm.buttonPressed('5')),
                  customButton(
                      '6', Colors.white24, () => vm.buttonPressed('6')),
                  customButton(
                      '+', Colors.white10, () => vm.buttonPressed('+')),
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
                              '1', Colors.white24, () => vm.buttonPressed('1')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          customButton(
                              '2', Colors.white24, () => vm.buttonPressed('2')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          customButton(
                              '3', Colors.white24, () => vm.buttonPressed('3')),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          customButton('+/-', Colors.white24,
                              () => vm.buttonPressed('+/-')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          customButton(
                              '0', Colors.white24, () => vm.buttonPressed('0')),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04),
                          customButton(
                              '.', Colors.white24, () => vm.buttonPressed('.')),
                        ],
                      ),
                    ],
                  ),
                  customButton('=', Colors.orange, () => vm.buttonPressed('=')),
                ],
              )
            ],
          ),
        ));
  }
}
