import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:permission_handler/permission_handler.dart';

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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;
  String _message = "Empty";
  String _location = "Last location";

  static const platform = const MethodChannel("native_channel");

  Future<void> _getStartService() async {
    String got = "Ok";
    try {
      await platform.invokeMethod('start_service');
    } on PlatformException catch (e) {
      got = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _message = got;
    });
  }

  Future<void> _addHandler() async {
    print("Added");
    platform.setMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == "locationCallback") {
        Map locationData = Map.from(methodCall.arguments);
        print(locationData);
      }
    });
  }

  static _getPermissions({Function onGranted, Function onDenied}) async {
    await PermissionHandler()
        .requestPermissions([PermissionGroup.locationAlways]);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationAlways);
    if (permission == PermissionStatus.granted) {
      if (onGranted != null) {
        onGranted();
      }
    } else if (permission == PermissionStatus.denied ||
        permission == PermissionStatus.restricted ||
        permission == PermissionStatus.unknown) {
      if (onDenied != null) {
        onDenied();
      }
    }
  }

  static Future<PermissionStatus> checkPermissions() async {
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.locationAlways);
    return permission;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _message,
            ),
            Text(
              _location,
              style: Theme.of(context).textTheme.headline4,
            ),
            RaisedButton(
              child: Text('Get Permission'),
              onPressed: _getPermissions,
            ),
            RaisedButton(
              child: Text('Add handler'),
              onPressed: _addHandler,
            ),
            RaisedButton(
              child: Text('Start service'),
              onPressed: _getStartService,
            ),
          ],
        ),
      ),
    );
  }
}
