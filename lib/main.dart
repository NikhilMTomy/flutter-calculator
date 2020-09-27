import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(
        title: 'Calculator',
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _output = '0';
  bool evaluated = false;
  final List<String> operators = <String>['+', '-', '*', '/'];

  double findFontSize() {
    int step = (_output.length/4).floor()+1;
    return (144 / step).toDouble();
  }

  void evaluvate() {
    if (_output != "NAN") {
      for (int i = 0; i < operators.length; i++) {
        int index = _output.lastIndexOf(operators[i]);
        if (index != -1) {
          if (index == _output.length - 1) {
            setState(() {
              _output = _output.substring(0, _output.length - 1);
            });
          } else {
            double op1 = double.parse(_output.substring(0, index));
            double op2 = double.parse(_output.substring(index + 1));
            if (operators[i] == '/' && op2 == 0) {
              setState(() {
                _output = 'NAN';
              });
            } else {
              String output;
              switch (operators[i]) {
                case '+':
                  output = '${op1 + op2}';
                  break;
                case '-':
                  output = '${op1 - op2}';
                  break;
                case '*':
                  output = '${op1 * op2}';
                  break;
                case '/':
                  output = '${op1 / op2}';
                  break;
              }
              setState(() {
                _output = output;
              });
            }
          }
        }
      }
    }
  }

  void appendNumber (int number) {
    if (evaluated) {
      setState(() {
        evaluated = false;
        _output = '$number';
      });
    } else if (number != 0 || _output != '0') {
      if (_output == '0' || _output == 'NAN') {
        setState(() {
          evaluated = false;
          _output = '$number';
        });
      } else {
        setState(() {
          evaluated = false;
          _output += '$number';
        });
      }
    }
  }
  void appendOperator(String operator) {
    evaluvate();
    if (_output == 'NAN') {
      evaluated = false;
      _output = '0';
    }
    setState(() {
      evaluated = false;
      _output += operator;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                alignment: Alignment.bottomRight,
                padding: EdgeInsets.all(32),
                child: Text(
                  '$_output',
                  textAlign: TextAlign.end,
                  style: Theme.of(context).textTheme.headline4.merge(
                    TextStyle(
                      fontSize: findFontSize(),
                    )
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      CustomButton(
                        onPressed: () {appendNumber(1);},
                        text: '1',
                      ),
                      CustomButton(
                        onPressed: () {appendNumber(2);},
                        text: '2',
                      ),
                      CustomButton(
                        onPressed: () {appendNumber(3);},
                        text: '3',
                      ),
                      CustomButton(
                        onPressed: () {appendOperator('+');},
                        text: '+',
                        color: Colors.amber,
                      ),
                    ]
                  ),
                  TableRow(
                    children: [
                      CustomButton(
                        onPressed: () {appendNumber(4);},
                        text: '4',
                      ),
                      CustomButton(
                        onPressed: () {appendNumber(5);},
                        text: '5',
                      ),
                      CustomButton(
                        onPressed: () {appendNumber(6);},
                        text: '6',
                      ),
                      CustomButton(
                        onPressed: () {appendOperator('-');},
                        text: '-',
                        color: Colors.amber,
                      ),
                    ]
                  ),
                  TableRow(
                    children: [
                      CustomButton(
                        onPressed: () {appendNumber(7);},
                        text: '7',
                      ),
                      CustomButton(
                        onPressed: () {appendNumber(8);},
                        text: '8',
                      ),
                      CustomButton(
                        onPressed: () {appendNumber(9);},
                        text: '9',
                      ),
                      CustomButton(
                        onPressed: () {appendOperator('*');},
                        text: '*',
                        color: Colors.amber,
                      ),
                    ]
                  ),
                  TableRow(
                    children: [
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            _output = '0';
                          });
                        },
                        text: 'C',
                        color: Colors.red,
                      ),
                      CustomButton(
                        onPressed: () {appendNumber(0);},
                        text: '0',
                      ),
                      CustomButton(
                        onPressed: () {
                          setState(() {
                            evaluated = true;
                          });
                          evaluvate();
                        },
                        text: '=',
                        color: Colors.green,
                      ),
                      CustomButton(
                        onPressed: () {appendOperator('/');},
                        text: '/',
                        color: Colors.amber,
                      ),
                    ]
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final onPressed;
  final text;
  final color;

  CustomButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: InkWell(
        onTap: this.onPressed,
        splashColor: this.color,
        child: Center(
          child: Text(
            this.text,
            style: Theme.of(context).textTheme.headline4.merge(
              TextStyle(
                color: this.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}