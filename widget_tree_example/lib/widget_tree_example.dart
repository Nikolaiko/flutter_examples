import 'package:flutter/material.dart';

class ExampleWidget extends StatefulWidget {
  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {  
  String elementTitle = "Yes";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(elementTitle),
        FlatButton(
          onPressed: changeText, 
          child: Text("Change Text Button")
        )
      ]
    );
  }

  void changeText() {
    setState(() {
      elementTitle = (elementTitle == "Yes") ? "No" : "Yes";
    });
  }
}