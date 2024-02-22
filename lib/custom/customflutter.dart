import 'package:flutter/material.dart';
// import 'package:flutter1/customalert.dart';
import 'customtoast.dart';

class customflutter extends StatefulWidget {
  const customflutter({super.key});

  @override
  State<customflutter> createState() => _customflutterState();
}

class _customflutterState extends State<customflutter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Flutter Custom Widgets'),
      ),
      body:Center(
        child: Container(
          child:Column(
            children: [
              ElevatedButton(
               
                onPressed:(){
                  
                  // showDialog(
                  // context: context,
                  // builder: (BuildContext context) {
                  // return customalert();
                  //         },
                  //        );
                },
                child:Text('Alert'),
              ),
              SizedBox(height:20),
              ElevatedButton(
                onPressed:(){
                  
                
                  //  customtoast.showToast('It is a Toast message!');
                         
                },
                child:Text('Toast popup'),
              ),
            ],
          )
        ),
      )
    );
  }
}