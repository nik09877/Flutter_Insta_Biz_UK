import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final List<String> items;
  final String hint;
  const CustomDropDown({
    required this.items,
    this.hint='Select an option',
   super.key});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedItem,
      isExpanded: true,
      onChanged: (newValue) {
        setState(() {
          selectedItem = newValue;
        });
      },
      items: widget.items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      hint:  Text(widget.hint),
    );
  }
}
