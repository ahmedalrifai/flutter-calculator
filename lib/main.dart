import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String result = '0';
  String operand;
  String operationHistory = '';

  bool isInteger(num value) => value is int || value == value.roundToDouble();

  dynamic insertOperand(String op) {
    setState(() {
      bool insertOperandCondition = operationHistory.endsWith('-') != true &&
          operationHistory.endsWith('+') != true &&
          operationHistory.endsWith('×') != true &&
          operationHistory.endsWith('÷') != true;

      if (insertOperandCondition == true)
        this.operationHistory += op;
      this.result = '0';
    });
  }

  dynamic insertNumber(stringNum) {
    setState(() {
      if (this.result == '0')
        this.result = stringNum;
      else
        this.result += stringNum;

      this.operationHistory += stringNum;
    });
  }

  void backSpace() {
    setState(() {
      if (this.result.isNotEmpty) {
        this.result = this.result.substring(0, this.result.length - 1);
        this.operationHistory = this.operationHistory.substring(
            0, this.operationHistory.length - 1);
      }
    });
  }

  void clear() {
    setState(() {
      this.result = '0';
      this.operand = null;
      this.operationHistory = '';
    });
  }

  String eval() {
    String expString =
        this.operationHistory.replaceAll('×', '*').replaceAll('÷', '/');
    Expression expression = Expression.parse(expString);
    var context = {'': ''};
    final evaluator = const ExpressionEvaluator();
    return evaluator.eval(expression, context).toString();
  }

  Widget generateNumberButton(String num) {
    return Expanded(
      child: FlatButton(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        shape: CircleBorder(),
        onPressed: () {
          insertNumber(num);
        },
        child: Center(
          child: Text(
            num,
            style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 32),
          ),
        ),
      ),
    );
  }

  Widget generateOperandButton(String operand, {double outerPadding = 0}) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(outerPadding),
        child: FlatButton(
          padding: EdgeInsets.all(16),
          color: Colors.grey.shade200,
          shape: CircleBorder(),
          onPressed: () {
            insertOperand(operand);
          },
          child: Center(
            child: Text(
              operand,
              style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 32),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 12),
                child: Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '$operationHistory',
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 20),
                        ),
                      ),
                    ),
                    Container(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          '$result',
                          style: TextStyle(
                              color: Colors.grey.shade700, fontSize: 45),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(left: 12),
                            child: FlatButton(
                              padding: EdgeInsets.all(12),
                              color: Colors.grey.shade200,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              onPressed: () {
                                clear();
                              },
                              child: Center(
                                child: Text(
                                  'C',
                                  style: TextStyle(
                                      color: Colors.purple.shade300,
                                      fontSize: 32),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            padding: EdgeInsets.all(20),
                            color: Colors.grey.shade200,
                            shape: CircleBorder(),
                            onPressed: () {
                              backSpace();
                            },
                            child: Center(
                              child: Icon(
                                Icons.backspace,
                                color: Colors.grey.shade600,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        generateOperandButton('÷'),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      generateNumberButton('7'),
                      generateNumberButton('8'),
                      generateNumberButton('9'),
                      generateOperandButton('×', outerPadding: 8)
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        generateNumberButton('4'),
                        generateNumberButton('5'),
                        generateNumberButton('6'),
                        generateOperandButton('-')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        generateNumberButton('1'),
                        generateNumberButton('2'),
                        generateNumberButton('3'),
                        generateOperandButton('+')
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: FlatButton(
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            shape: CircleBorder(),
                            onPressed: () {
                              setState(() {
                                String stringResult = this.result.toString();
                                if (stringResult.endsWith('.') == false) {
                                  this.operationHistory += '.';
                                  this.result += '.';
                                }
                              });
                            },
                            child: Center(
                              child: Text(
                                '.',
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 32),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: FlatButton(
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            shape: CircleBorder(),
                            onPressed: () {
                              insertNumber('0');
                            },
                            child: Center(
                              child: Text(
                                '0',
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 32),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.only(right: 12),
                            child: FlatButton(
                              padding: EdgeInsets.all(12),
                              color: Colors.purple.shade300,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                              onPressed: () {
                                setState(() {
                                  this.result = eval();
                                  this.operationHistory = this.result;
                                  this.operand = null;
                                });
                              },
                                child: Center(
                                  child: Text(
                                    '=',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 32),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
