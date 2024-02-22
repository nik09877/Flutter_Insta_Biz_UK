import 'package:flutter/material.dart';

class CustomList extends StatelessWidget {
  final List<String> data;
  final Color color;

  const CustomList({
    Key? key,
    required this.data,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          height: 80,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
    );
  }
}
