import 'package:flutter/material.dart';
import 'custom/custombutton.dart';
import 'custom/customdropdown.dart';
import 'custom/customtextfield.dart';
import 'custom/customheader.dart';
import 'custom/custom_carousel_slider.dart';
import 'custom/custom_group_radio_btn.dart';
import 'custom/customalert.dart';
import 'custom/customgrid.dart';
import 'custom/customloader.dart';
import 'custom/customslider.dart';
import 'custom/customsubheader.dart';
import 'custom/customlist.dart';
import 'custom/customtoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Login(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final branch=[
    'ECE',
    'EEE',
    'CSE',
    'IT',
    'MECH',
    'CIVIL'
  ];
  final  section=[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('custom/Custom Widgets'),
      //   centerTitle: true,
      // ),
      appBar: CustomHeader(title: 'custom/Custom Widgets',),
      body: ListView(
        children: [
          Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * .60,
                  color: Colors.transparent,
                  child: Form(
                      child: Column(
                    children: [
                      CustomSubHeader(subtitle: 'Carousel Slider'),
                      const SizedBox(
                        height: 8,
                      ),
                      
                      CustomCarouselSlider(items: branch, activeColor: Colors.teal,
                       inactiveColor: Colors.teal[100]!,
                        itemHeight: MediaQuery.of(context).size.height*0.20,
                         itemWidth:  MediaQuery.of(context).size.width*0.25,),
                      
                      const SizedBox(
                        height: 20,
                      ),
                       CustomSubHeader(subtitle: 'Group RadioButton'),
                      const SizedBox(
                        height: 8,
                      ), 
                      CustomRadioGroup(options: branch,
                       selectedOption: branch[0],
                        onSelectionChanged: (String value) {},
                        selectedColor: Colors.teal,
                        ),
                        const SizedBox(
                        height: 20,
                      ),
                       CustomSubHeader(subtitle: 'Text Fields'),
                      const SizedBox(
                        height: 8,
                      ), 
                      
                      CustomTextField(
                          controller: _emailController,
                          hintText: 'Eg:-g62uw@gmail.com',
                          labelText: 'Enter Email Id',
                          icon: Icons.email_outlined),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                          controller: _passwordController,
                          hintText: 'Eg:-........',
                          labelText: 'Enter Password',
                          obscureText: true,
                          icon: Icons.password),
                      const SizedBox(
                        height: 20,
                      ),
                       CustomSubHeader(subtitle: 'custom/Custom DropDown'),
                      const SizedBox(
                        height: 8,
                      ), 
                      CustomDropDown(items: branch,hint: 'Select Branch',),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomDropDown(items: section,hint: 'Select Section',),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height:400,child: CustomList(data: branch, color: Colors.teal)),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomLoader(text: 'Loading',),
                       const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width:MediaQuery.of(context).size.width*0.30,
                        height:MediaQuery.of(context).size.height*0.4,
                        child: CustomGrid(data: branch, color: Colors.teal)),
                        const SizedBox(height: 20,),
                       
                      CustomSlider(initialValue: 40, onChanged: (value){}),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(text: 'Login', onPressed: (){
                        showDialog(
                      context: context,
                      builder: (BuildContext context) {
                      return customalert(content: 'Login Successful!!',);
                              },
                             );
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                       CustomButton(text: 'Sign Up', onPressed: (){
                        customtoast.showToast('It is a Toast message!');
                      }),
                      
                    ],
                  )),
                ),
              ),
            
          ),
        ],
      ),
    );
  }
}

