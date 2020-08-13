import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Checkbox Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Checkbox Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _firstCheckBoxValue = false;
  bool _secondCheckBoxValue = false;
  bool _tripleState = false;
  bool _listTileState = false;
  String _stringState = false.toString();

  void _firstCheckBoxValueChange(bool newValue) {
    setState(() {
      _firstCheckBoxValue = newValue;
    });
  }

  void _secondCheckBoxValueChange(bool newValue) {
    setState(() {
      _secondCheckBoxValue = newValue;
    });
  }

  void _tripleCheckBoxValueChange(bool newValue) {
    setState(() {
      _tripleState = newValue;
      _stringState = "Triple state : ${_tripleState.toString()}"; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_stringState),
            Checkbox(value: _tripleState, onChanged: _tripleCheckBoxValueChange, tristate: true),            
            Checkbox(value: _firstCheckBoxValue, onChanged: _firstCheckBoxValueChange),
            Checkbox(
              activeColor: Colors.red,
              checkColor: Colors.blueGrey,
              hoverColor: Colors.yellow,              
              value: _secondCheckBoxValue, 
              onChanged: _secondCheckBoxValueChange
            ),
            CheckboxListTile(
              value: _listTileState, 
              onChanged: (bool value) {
                setState(() {
                  _listTileState = value;
                });
              },
              title: Text("Checkbox Title"),
              controlAffinity: ListTileControlAffinity.trailing,
              secondary: Icon(Icons.access_alarms),
            )
          ],
        ),
      ),
    );
  }
}
