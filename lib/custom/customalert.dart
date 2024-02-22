import 'package:flutter/material.dart';

class customalert extends StatefulWidget {
  final String content; 
  const customalert({
    this.content='',
    super.key});

  @override
  State<customalert> createState() => _customalertState();
}

class _customalertState extends State<customalert> {
  @override
  Widget build(BuildContext context) {
    double sw=MediaQuery.of(context).size.width;
    double sh=MediaQuery.of(context).size.height;
    return Dialog(
       shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child:Container(
        width:0.9*sw,
        height:0.5*sh,
        child:Column(
          children:[
            Expanded(
              child: Container(
              //  height:0.24*sh,
                width:double.infinity,
                color:Colors.teal,
                child:Center(
                  child:Icon(
                    Icons.star,
                    color:Colors.white,
                    size:70
                  )
                ),
              ),
            ),
            Container(
              height:0.25*sh,
              color:Colors.white,
              child:Center(
                child: Column(children: [
                  Text('Success',style:TextStyle(fontSize:18,fontWeight: FontWeight.bold,color:Colors.black)),
                  SizedBox(height:30),
                  Text(widget.content,style:TextStyle(fontSize:18,color:Colors.black)),
                  SizedBox(height:40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                              primary: Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0.0),
                              ),
                            ),
                    onPressed: (){
                    Navigator.of(context).pop();
                  }, child:Text('OK',style:TextStyle(fontSize:18,fontWeight: FontWeight.bold,color:Colors.white))),
                   // SizedBox(height:40),
                ],
                ),
              )
            )
          
          ]
        )
      )
    );
  }
}