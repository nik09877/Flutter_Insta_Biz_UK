import "package:flutter/material.dart";

class CustomRadioButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onSelect;
  final Color selectedColor;
  final Color unselectedColor;
  final Color borderColor;
  final double iconSize;
  final double borderWidth;
  final TextStyle textStyle;
  final EdgeInsetsGeometry contentPadding;
  final BoxShape shape;

  CustomRadioButton({
    required this.label,
    required this.isSelected,
    required this.onSelect,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.transparent,
    this.borderColor = Colors.grey,
    this.iconSize = 20.0,
    this.borderWidth = 2.0,
    this.textStyle = const TextStyle(fontSize: 16.0, color: Colors.black),
    this.contentPadding = const EdgeInsets.all(8.0),
    this.shape = BoxShape.circle, // Default shape is a circle
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelect,
      child: Padding(
        padding: contentPadding,
        child: Row(
          children: [
            Container(
              width: iconSize,
              height: iconSize,
              decoration: BoxDecoration(
                shape: shape,
                border: Border.all(
                  color: isSelected ? selectedColor : borderColor,
                  width: borderWidth,
                ),
                color: isSelected ? selectedColor : unselectedColor,
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: iconSize - 2 * borderWidth,
                        height: iconSize - 2 * borderWidth,
                        decoration: BoxDecoration(
                          shape: shape,
                          color: selectedColor,
                        ),
                      ),
                    )
                  : Container(),
            ),
            SizedBox(width: 8.0),
            Text(
              label,
              style: textStyle.copyWith(
                color: isSelected ? selectedColor : textStyle.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
