import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:function_tree/function_tree.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var expressionText = "";
  var expressionResult = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Calculator'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    overflow: TextOverflow.fade,
                    expressionResult,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 65),
                  ),
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Text(
                    expressionText,
                    textAlign: TextAlign.right,
                    style: const TextStyle(fontSize: 50, color: Colors.grey),
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton('C', Colors.amber, Colors.white),
                numButton('+/-', Colors.amber, Colors.white),
                numButton('%', Colors.amber, Colors.white),
                numButton('/', Colors.amber, Colors.white)
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton('7', Colors.amber, Colors.white),
                numButton('8', Colors.amber, Colors.white),
                numButton('9', Colors.amber, Colors.white),
                numButton('x', Colors.amber, Colors.white)
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton('4', Colors.amber, Colors.white),
                numButton('5', Colors.amber, Colors.white),
                numButton('6', Colors.amber, Colors.white),
                numButton('-', Colors.amber, Colors.white)
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton('1', Colors.amber, Colors.white),
                numButton('2', Colors.amber, Colors.white),
                numButton('3', Colors.amber, Colors.white),
                numButton('+', Colors.amber, Colors.white)
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: numZeroButton('0', Colors.pink, Colors.white),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: numButton('.', Colors.amber, Colors.white),
                ),
                Expanded(
                  flex: 1,
                  child: numButton('=', Colors.amber, Colors.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget numButton(String text, Color backgroundColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {
        calculate(text);
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 30, color: textColor),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(80, 70),
        shape: const CircleBorder(),
        primary: backgroundColor,
      ),
    );
  }

  Widget numZeroButton(String text, Color backgroundColor, Color textColor) {
    return ElevatedButton(
      onPressed: () {
        calculate(text);
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 30, color: textColor),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(120, 70),
        shape: const StadiumBorder(),
        primary: Colors.amber,
      ),
    );
  }

  void calculate(String buttonText) {
    var tempText = "";
    var resultTextLastChar = "";
    var expressionResultTemp = "";
    if (expressionText.isNotEmpty) {
      resultTextLastChar = expressionText.characters.last;
    }

    if (buttonText == "/" ||
        buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "x" ||
        buttonText == "." ||
        buttonText == "%") {
      if (resultTextLastChar == '.' ||
          resultTextLastChar == "/" ||
          resultTextLastChar == "+" ||
          resultTextLastChar == "-" ||
          resultTextLastChar == "x" ||
          resultTextLastChar == "%") {
        //supress user from pressing operator after another operator
        tempText = expressionText;
      } else {
        tempText = expressionText + buttonText;
      }
    } else if (buttonText == "C") {
      tempText = "";
    } else if (buttonText == "=") {
      tempText = expressionText;
    } else {
      tempText = expressionText + buttonText;
    }

    if (buttonText == "=") {
      //calculate result

      //Parser p = Parser();
      //Expression exp = p.parse("1+1-6");
      //expressionResultTemp = exp.simplify().toString();
      var newExpression = expressionText.replaceAll("x", "*");
      if (resultTextLastChar == '.' ||
          resultTextLastChar == "/" ||
          resultTextLastChar == "+" ||
          resultTextLastChar == "-" ||
          resultTextLastChar == "x" ||
          resultTextLastChar == "%") {
        //do nothing if last char is operator and result is asked
      } else if (expressionText.isEmpty) {
        //do nothing if expresion is empty
      } else {
        expressionResultTemp = newExpression.interpret().toString();
      }
    }

    setState(() {
      expressionText = tempText;
      if (expressionResultTemp == "NaN") {
        expressionResult = "Bsdk Sahi se Number dal!!";
      } else {
        expressionResult = expressionResultTemp;
      }
    });
  }
}
