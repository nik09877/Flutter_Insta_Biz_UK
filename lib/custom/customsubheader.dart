import 'package:flutter/material.dart';

class CustomSubHeader extends StatelessWidget {
  final String subtitle;

  const CustomSubHeader({Key? key, required this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          
          
        ],
      ),
    );
  }
}
