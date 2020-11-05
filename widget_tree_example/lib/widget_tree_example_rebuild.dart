import 'package:flutter/material.dart';

class RebuildWidgetExample extends StatefulWidget {
  @override
  _RebuildWidgetExampleState createState() => _RebuildWidgetExampleState();
}

class _RebuildWidgetExampleState extends State<RebuildWidgetExample> {
  static const String path = "assets/images/flutter_logo.jpg";
  bool initialType = true;

  @override
  Widget build(BuildContext context) {
    return Column(            
      children: buildElements()
    );
  }

  List<Widget> buildElements() {
    List<Widget> elements = List<Widget>();
    elements.add((initialType) ? Text("Initialtext") : Image.asset(path));
    elements.add(FlatButton( 
      onPressed: changeType, 
      child: Text("Change Text Button")
      )
    );
    if (!initialType) elements.add(Text("SomeText"));
    return elements;
  }

  void changeType() {
    setState(() {
      initialType = !initialType;
    });
  }
}