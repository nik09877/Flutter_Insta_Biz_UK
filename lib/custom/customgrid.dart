import 'package:flutter/material.dart';

class CustomGrid extends StatelessWidget {
  final List<String> data;
  final Color color;

  const CustomGrid({
    Key? key,
    required this.data,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 8.0,
      mainAxisSpacing: 8.0,
      children: List.generate(
        data.length,
        (index) {
          return Container(
            decoration: BoxDecoration(
              color: color,
            ),
            child: Center(
              child: Text(
                data[index],
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
