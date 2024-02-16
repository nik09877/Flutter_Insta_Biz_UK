import 'package:flutter/material.dart';

class TouchIdPage extends StatefulWidget {
  const TouchIdPage({super.key});

  @override
  State<TouchIdPage> createState() => _TouchIdPageState();
}

class _TouchIdPageState extends State<TouchIdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("Set MPIN"),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 150,
                  width: 340,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Would you like to enable Touch ID",
                        style: TextStyle(color: Colors.red, fontSize: 12.0),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.fingerprint),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Text("Yes"),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: Text("No"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
