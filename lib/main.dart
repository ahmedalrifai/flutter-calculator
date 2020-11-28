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
  String tempResult = '0';
  String operand;
  String operationHistory = '';

  bool isInteger(num value) => value is int || value == value.roundToDouble();

  dynamic insertOperator(String op) {
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
      if (this.result.endsWith('.'))
        this.result += stringNum;
      else if (this.result == '0')
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

  dynamic eval() {
    String expString =
        this.operationHistory.replaceAll('×', '*').replaceAll('÷', '/');
    Expression expression = Expression.parse(expString);
    var context = {'': ''};
    final evaluator = const ExpressionEvaluator();
    return evaluator.eval(expression, context).toString();
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
                  mainAxisAlignment: MainAxisAlignment.end,
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
                          flex: 1,
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
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                            child: FlatButton(
                              padding: EdgeInsets.all(16),
                              color: Colors.grey.shade200,
                              shape: CircleBorder(),
                              onPressed: () {
                                insertOperator('÷');
                              },
                              child: Center(
                                child: Text(
                                  '÷',
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 32),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: FlatButton(
                            padding: EdgeInsets.all(16),
                            color: Colors.white,
                            shape: CircleBorder(),
                            onPressed: () {
                              insertNumber('7');
                            },
                            child: Center(
                              child: Text(
                                '7',
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
                            insertNumber('8');
                          },
                          child: Center(
                            child: Text(
                              '8',
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
                            insertNumber('9');
                          },
                          child: Center(
                            child: Text(
                              '9',
                              style: TextStyle(
                                  color: Colors.grey.shade800,
                                  fontSize: 32),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FlatButton(
                            padding: EdgeInsets.all(16),
                            color: Colors.grey.shade200,
                            shape: CircleBorder(),
                            onPressed: () {
                              insertOperator('×');
                            },
                            child: Center(
                              child: Text(
                                '×',
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 32),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
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
                              insertNumber('4');
                            },
                            child: Center(
                              child: Text(
                                '4',
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
                              insertNumber('5');
                            },
                            child: Center(
                              child: Text(
                                '5',
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
                              insertNumber('6');
                            },
                            child: Center(
                              child: Text(
                                '6',
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
                            color: Colors.grey.shade200,
                            shape: CircleBorder(),
                            onPressed: () {
                              insertOperator('-');
                            },
                            child: Center(
                              child: Text(
                                '-',
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 32),
                              ),
                            ),
                          ),
                        ),
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
                              insertNumber('1');
                            },
                            child: Center(
                              child: Text(
                                '1',
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
                              insertNumber('2');
                            },
                            child: Center(
                              child: Text(
                                '2',
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
                              insertNumber('3');
                            },
                            child: Center(
                              child: Text(
                                '3',
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
                            color: Colors.grey.shade200,
                            shape: CircleBorder(),
                            onPressed: () {
                              insertOperator('+');
                            },
                            child: Center(
                              child: Text(
                                '+',
                                style: TextStyle(
                                    color: Colors.grey.shade800,
                                    fontSize: 32),
                              ),
                            ),
                          ),
                        ),
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
