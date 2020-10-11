import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Calculator',),
      debugShowCheckedModeBanner: false,
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
  final List<String> operators = <String>['+', '-', '*', '/'];

  void appendDigit(int digit) {
    if (_output != '0' || digit != 0) {
      String output = _output;

      if (output == '0') {
        output = digit.toString();
      } else {
        output += digit.toString();
      }

      setState(() {
        _output = output;
      });
    }
  }

  void appendOperator(String operator) {
    evaluate();
    if (!operators.contains(_output[_output.length-1])) {
      setState(() {
        _output += operator;
      });
    }
  }

  void evaluate() {
    String output = _output;
    operators.forEach((operator) {
      int index = output.indexOf(operator);
      if (index != -1) {
        try {
          String op1String = output.substring(0, index);
          String op2String = output.substring(index + 1);

          double op1 = double.parse(op1String);
          double op2 = double.parse(op2String);

          switch (operator) {
            case '+':
              output = (op1 + op2).toString();
              break;
            case '-':
              output = (op1 - op2).toString();
              break;
            case '*':
              output = (op1 * op2).toString();
              break;
            case '/':
              output = (op1 / op2).toString();
              break;
          }

          setState(() {
            _output = output;
          });
        } catch (ex) {
          debugPrint(ex.toString());
          setState(() {
            _output = 'NAN';
          });
        }
      }
    });
  }

  double getFontSize() {
    int step = (_output.length/4).floor() + 1;
    return (144/step);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: Theme.of(context).textTheme.headline4.merge(
                  TextStyle(
                    fontSize: getFontSize(),
                  ),
                ),
                textAlign: TextAlign.end,
              ),
            ),
          ),
          Table(
            children: [
              TableRow(
                children: [
                  CustomButton(
                    onPressed: () { appendDigit(1); },
                    text: '1',
                  ),
                  CustomButton(
                    onPressed: () { appendDigit(2); },
                    text: '2',
                  ),
                  CustomButton(
                    onPressed: () { appendDigit(3); },
                    text: '3',
                  ),
                  CustomButton(
                    onPressed: () { appendOperator('+'); },
                    text: '+',
                    color: Colors.blue,
                  ),
                ],
              ),
              TableRow(
                children: [
                  CustomButton(
                    onPressed: () { appendDigit(4); },
                    text: '4',
                  ),
                  CustomButton(
                    onPressed: () { appendDigit(5); },
                    text: '5',
                  ),
                  CustomButton(
                    onPressed: () { appendDigit(6); },
                    text: '6',
                  ),
                  CustomButton(
                    onPressed: () { appendOperator('-'); },
                    text: '-',
                    color: Colors.blue,
                  ),
                ],
              ),
              TableRow(
                children: [
                  CustomButton(
                    onPressed: () { appendDigit(7); },
                    text: '7',
                  ),
                  CustomButton(
                    onPressed: () { appendDigit(8); },
                    text: '8',
                  ),
                  CustomButton(
                    onPressed: () { appendDigit(9); },
                    text: '9',
                  ),
                  CustomButton(
                    onPressed: () { appendOperator('*'); },
                    text: '*',
                    color: Colors.blue,
                  ),
                ],
              ),
              TableRow(
                children: [
                  CustomButton(
                    onPressed: () { setState(() {
                      _output = '0';
                    }); },
                    text: 'C',
                    color: Colors.red,
                  ),
                  CustomButton(
                    onPressed: () { appendDigit(0); },
                    text: '0',
                  ),
                  CustomButton(
                    onPressed: () { evaluate(); },
                    text: '=',
                    color: Colors.green,
                  ),
                  CustomButton(
                    onPressed: () { appendOperator('/'); },
                    text: '/',
                    color: Colors.blue,
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  CustomButton({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.color
  }) : super(key: key);

  final onPressed;
  final text;
  final color;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        splashColor: this.color,
        onTap: this.onPressed,
        child: Center(
          child: Text(
            this.text,
            style: Theme.of(context).textTheme.headline4.merge(
                TextStyle(
                  color: this.color,
                )
            ),
          ),
        ),
      ),
    );
  }
}