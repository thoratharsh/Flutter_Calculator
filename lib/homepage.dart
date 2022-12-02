import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var resultText = "";
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  resultText,
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton('C'),
                numButton('+/-'),
                numButton('%'),
                numButton('/')
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton('7'),
                numButton('8'),
                numButton('9'),
                numButton('x')
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton('4'),
                numButton('5'),
                numButton('6'),
                numButton('-')
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numButton('1'),
                numButton('2'),
                numButton('3'),
                numButton('+')
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                numZeroButton('0'),
                numButton('.'),
                numButton('='),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget numButton(String text) {
    return ElevatedButton(
      onPressed: () {
        calculate(text);
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 25, color: Colors.brown),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(70, 70),
        shape: CircleBorder(),
        primary: Colors.amber,
      ),
    );
  }

  Widget numZeroButton(String text) {
    return ElevatedButton(
      onPressed: () {
        calculate(text);
      },
      child: Text(
        text,
        style: TextStyle(fontSize: 25, color: Colors.brown),
      ),
      style: ElevatedButton.styleFrom(
        fixedSize: Size(70, 70),
        shape: const StadiumBorder(),
        primary: Colors.amber,
      ),
    );
  }

  void calculate(String buttonText) {
    var tempText = "";
    var resultTextLastChar = "";
    if (resultText.isNotEmpty) {
      resultTextLastChar = resultText.characters.last;
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
        tempText = resultText;
      } else {
        tempText = resultText + buttonText;
      }
    } else if (buttonText == "C") {
      tempText = "";
    } else {
      tempText = resultText + buttonText;
    }

    if (buttonText == "=") {
      //calculate result

    }

    setState(() {
      resultText = tempText;
    });
  }
}
