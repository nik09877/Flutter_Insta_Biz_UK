// import 'dart:isolate';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:myproject/pages/instabiz.dart';

class LoginPage extends StatefulWidget {
  final Map<String, dynamic> user;
  const LoginPage({Key? key, required this.user}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  List<TextEditingController> controllers = List.generate(
    6,
    (index) => TextEditingController(),
  );

  bool isLoginEnabled = false;
  late int enteredMpin;
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    // Add listeners to all text controllers
    for (var controller in controllers) {
      controller.addListener(_checkLoginStatus);
    }
    user = widget.user;
  }

  int convertControllersToInt(List<TextEditingController> controllers) {
    String stringValue = '';
    for (TextEditingController controller in controllers) {
      stringValue += controller.text;
    }
    return int.tryParse(stringValue) ?? 0; // Return 0 if conversion fails
  }

  void _checkLoginStatus() {
    bool allFilled = true;
    for (var controller in controllers) {
      if (controller.text.isEmpty) {
        allFilled = false;
        break;
      }
    }
    setState(() {
      isLoginEnabled = allFilled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25.0,
            ),
            Image.asset(
              'assets/instaBIZ.png',
              height: 150.0,
            ),
            const SizedBox(
              height: 40.0,
            ),
            const Text(
              "Enter 6 digit Login PIN",
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: SizedBox(
                    width: 30,
                    height: 40,
                    child: TextField(
                      controller: controllers[index],
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        counterText: '',
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        } else {
                          if (index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Forgot MPIN?",
                  style: TextStyle(color: Colors.red),
                )),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              width: 220,
              child: ElevatedButton(
                onPressed: isLoginEnabled
                    ? () {
                        enteredMpin = convertControllersToInt(controllers);
                        if (user['mpin'] == enteredMpin) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  InstaBIZPage(userId: user['userId']),
                            ),
                          );
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => InstaBIZPage(),
                          //   ),
                          // );
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Error"),
                                content: Text("Incorrect MPIN"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(14, 36, 102, 1),
                  disabledBackgroundColor: Color.fromRGBO(45, 80, 185, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                child: const Text(
                  'LOGIN',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
