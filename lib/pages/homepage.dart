import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Your App Title'),
                background: Image.asset('assets/logo.png'),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    // Handle action
                  },
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Text 1'),
                    Text('Text 2'),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: [
                  // First Tab View with ListView.builder and BottomNavigationBar
                  Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: 20,
                          itemBuilder: (context, index) => ListTile(
                            title: Text('Item $index'),
                          ),
                        ),
                      ),
                      BottomNavigationBar(
                        items: [
                          BottomNavigationBarItem(
                            icon: Icon(Icons.home),
                            label: 'Home',
                          ),
                          BottomNavigationBarItem(
                            icon: Icon(Icons.business),
                            label: 'Business',
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Second Tab View with Text and ElevatedButton
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Some Text Here'),
                        ElevatedButton(
                          onPressed: () {
                            // Handle button press
                          },
                          child: Text('Elevated Button'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   Future<void> postData() async {
//     Uri url = Uri.parse('http://localhost:8000/creds');
//     Map<String, dynamic> data = {
//       "email": "xyz@gmail.com",
//       "password": "xyz123"
//     };

//     try {
//       // var response =
//       await http.post(
//         url,
//         body: jsonEncode(data),
//       );
//     } catch (err) {
//       print(err);
//     }
//   }

//   Future<bool> getData({email = "test@gmail.com", password = "test12"}) async {
//     Uri url = Uri.parse('http://localhost:8000/creds');
//     var response = await http.get(url);

//     if (response.statusCode == 200) {
//       List<dynamic> users = jsonDecode(response.body);

//       for (var user in users) {
//         if (user['email'] == email && user['password'] == password) {
//           // print("$user['email']");
//           // print("$user['password']");
//           return true;
//         }
//       }
//     }

//     return false;
//   }

//   int selectedPageIndex = 0;

//   List pageOptions = [
//     DefaultPage(),
//     Center(
//       child: Text("accounts"),
//     ),
//     Center(
//       child: Text("approvals"),
//     ),
//     Center(
//       child: Text("accounts1"),
//     ),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: pageOptions[selectedPageIndex],
//       bottomNavigationBar: buildNavBar(context),
//     );
//   }

//   Container buildNavBar(BuildContext context) {
//     return Container(
//       height: 100,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 selectedPageIndex = 1;
//               });
//             },
//             icon: Image.asset(
//               'assets/accounts.png',
//               height: 60,
//               width: 60,
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 selectedPageIndex = 2;
//               });
//             },
//             icon: Image.asset(
//               'assets/approvals.png',
//               height: 20,
//               width: 20,
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 selectedPageIndex = 3;
//               });
//             },
//             icon: Image.asset(
//               'assets/accounts.png',
//               height: 20,
//               width: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class DefaultPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Container(
//         child: ElevatedButton(
//           onPressed: () {
//             // Trigger POST request
//             // var res =
//             // getData();
//           },
//           child: Text('POST Request'),
//         ),
//       ),
//     );
//   }
// }
