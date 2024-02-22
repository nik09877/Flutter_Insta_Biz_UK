import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final String text;

  const CustomLoader({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(width: 10),
          CircularProgressIndicator(
            color: Colors.teal,
          ),
        ],
      ),
    );
  }
}
