import 'package:flutter/material.dart';

class DatePickers extends StatefulWidget {
  @override
  _DatePickersState createState() => _DatePickersState();
}

class _DatePickersState extends State<DatePickers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        title: Text("Date Picker"),
      ),
      body: Container(
        child: Column(          
          children: [
            RaisedButton(
              child: const Text("Simple Date"),
              onPressed: () => _showSimpleDatePicker(context)
            ),
            RaisedButton(
              child: const Text("Typed Date"),
              onPressed: () => _showDateTimePickerWithType(context)
            ),
            RaisedButton(
              child: const Text("Parameterized Date"),
              onPressed: () => _fullyParameterizedDateTime(context)
            )
          ],
        )
      )
    );
  }

  void _fullyParameterizedDateTime(BuildContext build) {
    showDatePicker(
      context: context, 
      helpText: "My Help Text",
      cancelText: "My Cancel Text",
      confirmText: "My Confirm Text",
      errorFormatText: "My Error Format",
      errorInvalidText: "My Invalid Text",
      fieldLabelText: "My Field Label",
      fieldHintText: "My Hint Label",
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(Duration(days: 56))
    );
  }

  void _showDateTimePickerWithType(BuildContext build) {
    showDatePicker(
      context: context, 
      initialDatePickerMode: DatePickerMode.year,
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(Duration(days: 56))
    );
  }

  void _showSimpleDatePicker(BuildContext context) {
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime.now(), 
      lastDate: DateTime.now().add(Duration(days: 56))
    );
  }
}