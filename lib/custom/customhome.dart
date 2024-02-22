import 'package:flutter/material.dart';
import 'customlist.dart';
import 'customgrid.dart';
import 'customloader.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: 600,
            height: 300,
            child: CustomList(
                data: ['CUSTOM', 'LIST', 'WIDGET'], color: Colors.red),
          ),
          SizedBox(
            height: 8.0,
          ),
          Container(
            width: 400,
            height: 300,
            child: CustomGrid(
                data: ['THIS IS', 'CUSTOM', 'GRID', 'WIDGET'],
                color: Colors.blue),
          ),
          SizedBox(
            height: 15.0,
          ),
          CustomLoader(text: 'Loading...'),
          // SizedBox(
          //   height: 8.0,
          // ),
          // Container(
          //   width: 600,
          //   height: 300,
          //   child: CustomList(
          //       data: ['LI 1', 'LI 2', 'LI 3', 'LI 4'], color: Colors.red),
          // ),
          SizedBox(
            height: 8.0,
          ),
          CustomLoader(text: 'Waiting...'),
        ],
      ),
    );
  }
}
