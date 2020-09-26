import 'package:flutter/material.dart';
import 'package:value_widgets_example/underConstrationScreen.dart';
import 'package:value_widgets_example/valueWidgets/valueWidgetsList.dart';

class AllWidgetsList extends StatelessWidget {
  final List<String> widgetTypes = ["Value Widgets"];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widgetTypes.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(widgetTypes[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => _buildWidgetsListScreen(index)
              )
            );            
          }
        );
      }
    );
  }

  Widget _buildWidgetsListScreen(int index) {
    switch(index) {
      case 0: {
        return ValueWidgetsListScreen();
      }
      default: {
        return UnderConstructionScreen();
      }
    }
  }
}