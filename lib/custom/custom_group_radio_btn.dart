import 'custom_radio_btn.dart';
import 'package:flutter/material.dart';

class CustomRadioGroup extends StatefulWidget {
  final List<String> options;
  final String selectedOption;
  final Function(String) onSelectionChanged;
  final Color selectedColor;
  final Color unselectedColor;
  final Color borderColor;
  final double iconSize;
  final double borderWidth;
  final TextStyle textStyle;
  final EdgeInsetsGeometry contentPadding;
  final BoxShape shape;

  CustomRadioGroup({
    required this.options,
    required this.selectedOption,
    required this.onSelectionChanged,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.transparent,
    this.borderColor = Colors.grey,
    this.iconSize = 20.0,
    this.borderWidth = 2.0,
    this.textStyle = const TextStyle(fontSize: 16.0, color: Colors.black),
    this.contentPadding = const EdgeInsets.all(8.0),
    this.shape = BoxShape.circle,
  });

  @override
  _CustomRadioGroupState createState() => _CustomRadioGroupState();
}

class _CustomRadioGroupState extends State<CustomRadioGroup> {
  late String _selectedOption;

  @override
  void initState() {
    super.initState();
    _selectedOption = widget.selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.options.map((option) {
        bool isSelected = option == _selectedOption;
        
        return CustomRadioButton(
          label: option,
          isSelected: isSelected,
          onSelect: () {
            setState(() {
              _selectedOption = option;
              widget.onSelectionChanged(option);
            });
          },
          selectedColor: widget.selectedColor,
          unselectedColor: widget.unselectedColor,
          borderColor: widget.borderColor,
          iconSize: widget.iconSize,
          borderWidth: widget.borderWidth,
          textStyle: widget.textStyle,
          contentPadding: widget.contentPadding,
          shape: widget.shape,
        );
      }).toList(),
    );
  }
}
