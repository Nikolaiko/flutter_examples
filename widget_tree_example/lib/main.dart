import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:main_test/widget_tree_example.dart';
import 'package:main_test/widget_tree_example_rebuild.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("How it works")),
        body: RebuildWidgetExample()
      )
    )
  );
}
