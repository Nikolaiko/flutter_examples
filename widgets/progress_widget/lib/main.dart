import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Progress bar demo'),
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
  int _progress = 0;
  bool _isLoading = false;
  Timer _loadingTimer;

  @override
  void initState() {
    super.initState();    
  }

  void _loadingProgress(Timer timer) {
    setState(() {
        _progress = _progress + 10;   
        if (_progress >= 100) {
          _isLoading = false;
          timer.cancel();
        }
      });
  }

  void _startLoading() {
    _loadingTimer = Timer.periodic(Duration(seconds: 1), _loadingProgress);
    setState(() {
      _isLoading = true;
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
            Text(
              'Progress :',
            ),
            Text(
              '$_progress',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _isLoading ? null : _startLoading,        
        child: Icon(Icons.add),
      ),
    );
  }
}
