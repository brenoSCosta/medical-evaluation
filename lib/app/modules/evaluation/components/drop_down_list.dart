import 'package:flutter/material.dart';

class DropDownListEdit extends StatelessWidget {
  final String? selectedValue;
  final Function onChanged;
  final List items;
  const DropDownListEdit(
      {required this.selectedValue,
      required this.onChanged,
      required this.items,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text('Gênero'),
      value: selectedValue,
      onChanged: (value) {
        onChanged(value);
      },
      items: items.map((valueItem) {
        return DropdownMenuItem<String>(
          value: valueItem,
          child: Text(valueItem),
        );
      }).toList(),
    );
  }
}
