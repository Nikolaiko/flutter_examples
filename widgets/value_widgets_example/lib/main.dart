import 'package:flutter/material.dart';
import 'package:value_widgets_example/allWidgetsListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        appBar: AppBar(        
          title: Text("Widgets"),
        ),
        body: AllWidgetsList()
      )
    );
  }
}