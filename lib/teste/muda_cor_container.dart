import 'package:flutter/material.dart';

void main() {
  runApp(ColorContainerAltered());
}

class ColorContainerAltered extends StatefulWidget {
  @override
  _ColorContainerAlteredState createState() => _ColorContainerAlteredState();
}

class _ColorContainerAlteredState extends State<ColorContainerAltered> {
  //Initially color is set to yellow which will be changed when button is pressed
  Color color = Colors.yellow;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Change Container Color"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 300,
                height: 300,
                color:
                    color, //value of color which we will change by pressing buttons
              ),

              /* Below Row of Button when pressed will fire up
                the setState and the state of our default color variable will
                change according to Button which is pressed
             */
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    color: Colors.red,
                    child: Text("Red"),
                    onPressed: () {
                      setState(() {
                        color = Colors.red;
                      });
                    },
                  ),
                  RaisedButton(
                    color: Colors.green,
                    child: Text("Green"),
                    onPressed: () {
                      setState(() {
                        color = Colors.green;
                      });
                    },
                  ),
                  RaisedButton(
                    color: Colors.blue,
                    child: Text("Blue"),
                    onPressed: () {
                      setState(() {
                        color = Colors.blue;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
