import 'package:flutter/material.dart';
import 'package:value_widgets_example/valueWidgets/dateTimePickers.dart';

class ValueWidgetsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        title: Text("Value Widgets"),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("Date Pickers"),
            onTap: () {                
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DatePickers()
                )
              );
            },
          );          
        }      
      )
    );
  }
}