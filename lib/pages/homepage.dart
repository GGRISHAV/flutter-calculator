import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Homepage extends StatefulWidget {

  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

// BounceButton widget
class BounceButton extends StatefulWidget {

  final Widget child;
  final VoidCallback onTap;

  const BounceButton({super.key , required this.child , required this.onTap});

  @override
  State<BounceButton> createState() => _BounceButtonState();
}

class _BounceButtonState extends State<BounceButton> {

  double scale = 1.0;

  void _ontapdown(_) => setState(() => scale = 0.9);
  void _ontapup(_) => setState(() => scale = 1.0);
  void _ontapcancel() => setState(() => scale = 1.0);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _ontapdown,
      onTapUp: _ontapup,
      onTapCancel: _ontapcancel,
      child: AnimatedScale(
        scale: scale,
        duration: Duration(milliseconds: 100),
        child: widget.child,
      ),
    );
  }
}

class _HomepageState extends State<Homepage> {

  String _input = '';
  String _result = '';

  final List<dynamic> buttons = [
    'C', '( )', '%', '/',
    '7', '8', '9', '*',
    '4', '5', '6', '-',
    '1', '2', '3', '+',
    '0', '.', Icon(Icons.settings, size: 40), '=',
  ];

  String _calculate(String expr) {
  try {
    Parser p = Parser();
    Expression exp = p.parse(expr);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    return eval.toString();
  } catch (e) {
    return 'Error';
  }
}


  Widget inputpart() {
    return Stack(
      children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 40),
              child: GridView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: BounceButton(
                      onTap: () {
                        final buttonText = buttons[index];
                
                        setState(() {
                          if (buttonText == 'C') {
                            _input = '';
                            _result = '';
                          } else if (buttonText == '=') {
                            try {
                              final expression = _input.replaceAll('×', '*').replaceAll('÷', '/');
                              _result = _calculate(expression);
                            } catch (e) {
                              _result = 'Error';
                            }
                          } else if (buttonText is String) {
                            _input += buttonText;
                          }
                        });
                      },
                
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFE9D2F4),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: buttons[index] is String
                              ? Text(
                                  buttons[index],
                                  style: TextStyle(
                                      fontSize: 35, fontWeight: FontWeight.bold),
                                )
                              : buttons[index],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
    );
  }

Widget outputpart() {
  return Stack(
    children: [
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              _input,
              style: TextStyle(fontSize: 30, color: Colors.white70),
            ),
            SizedBox(height: 10),
            Text(
              _result,
              style: TextStyle(fontSize: 50, color: Colors.white),
            ),
          ],
        ),
      ),

      Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.white, // Example color
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
    ],
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Output part
          Expanded(
            flex: 1,
            child: outputpart(),
          ),

          // Input part (buttons)
          Expanded(
            flex: 2,
            child: inputpart(),
          ),
        ],
      ),
    );
  }
}
