import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MiniStatementPage extends StatefulWidget {
  final int userId;
  const MiniStatementPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<MiniStatementPage> createState() => _MiniStatementPageState();
}

class _MiniStatementPageState extends State<MiniStatementPage> {
  int selectedTabPage = 0;

  List tabPages = [
    // DefaultHomePage(),
    const Center(
      child: Text(
        "Fund Transfer",
      ),
    ),
    const Center(
      child: Text(
        "Cross Currency",
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: selectedTabPage == 0
                  ? DefaultHomePage(userId: widget.userId)
                  : tabPages[selectedTabPage]
              // tabPages[selectedTabPage],
              ),
          navBar(context),
          const SizedBox(height: 50),
        ],
      ),
      // bottomNavigationBar: navBar(context),
    );
  }

  Container navBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                selectedTabPage = 1;
              });
            },
            icon: Image.asset(
              'assets/fundtransfer.png',
              height: 30,
              width: 50,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                selectedTabPage = 2;
              });
            },
            icon: Image.asset(
              'assets/crosscurrency.png',
              height: 30,
              width: 50,
            ),
          ),
        ],
      ),
    );
  }
}

// class MiniStatements {
//   String date;
//   String remarks;
//   String amount;

//   MiniStatements(
//       {required this.date, required this.remarks, required this.amount});
// }

class DefaultHomePage extends StatefulWidget {
  final int userId;
  const DefaultHomePage({Key? key, required this.userId}) : super(key: key);

  @override
  State<DefaultHomePage> createState() => _DefaultHomePageState();
}

class _DefaultHomePageState extends State<DefaultHomePage> {
  // final List<MiniStatements> mslist = [
  //   MiniStatements(
  //       date: "20-05-2022", remarks: "UBR/CIB-4653123/GBP/bcx", amount: "0.01"),
  //   MiniStatements(
  //       date: "20-02-2022", remarks: "UBR/CIB-4653122/GBP/bcx", amount: "0.01"),
  //   MiniStatements(
  //       date: "19-05-2022", remarks: "CUK/000046522341/Utility", amount: "1.0"),
  //   MiniStatements(
  //       date: "04-03-2022",
  //       remarks: "UBR/CIB-4647104/GBP/ABANS GLOBAL",
  //       amount: "0.01"),
  //   MiniStatements(
  //       date: "04-03-2022", remarks: "CUK/000046450031/test", amount: "1.0"),
  // ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  var ministatement1 = [];
  List<Map<String, dynamic>> ministatements = [];

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.101.151.42:3000/transactions'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          // Filter data based on userId
          ministatements = data
              .where((transaction) => transaction['userId'] == widget.userId)
              .map((item) => Map<String, dynamic>.from(item))
              .toList();
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
  // void fetchData() async {
  //   try {
  //     final response =
  //         await get(Uri.parse('http://10.101.151.42:3000/transactions'));
  //     final jsonData = jsonDecode(response.body) as List;
  //     setState(() {
  //       ministatement1 = jsonData;
  //     });
  //   } catch (er) {
  //     //error
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ministatements.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey),
            ),
          ),
          child: ListTile(
            title: Container(
              width: 0.65 * MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date: ${ministatements[index]["transactionDate"]}',
                    style: const TextStyle(
                      color: Color.fromARGB(255, 17, 90, 150),
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 3.0,
                  ),
                  Text(
                    'Remarks: ${ministatements[index]["remarks"]}',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10.0,
                    ),
                  ),
                ],
              ),
            ),
            trailing: Container(
              width: 0.30 * MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "\u20Ac ${ministatements[index]["amount"]} ",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 179, 14, 14),
                      fontSize: 10.0,
                    ),
                  ),
                  const Text(
                    "Cr",
                    style: TextStyle(color: Colors.green, fontSize: 10.0),
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.chevron_right,
                      color: Color.fromARGB(255, 179, 14, 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Widget mstile(BuildContext context, i) {
  //   // final m = ministatements[i];
  //   return Container(
  //     decoration: const BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(color: Colors.grey),
  //       ),
  //     ),
  //     child: ListTile(
  //       title: Container(
  //         width: 0.65 * MediaQuery.of(context).size.width,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Date: ${ministatements[i]["transactionDate"]}',
  //               style: const TextStyle(
  //                 color: Color.fromARGB(255, 17, 90, 150),
  //                 fontSize: 12.0,
  //               ),
  //             ),
  //             const SizedBox(
  //               height: 3.0,
  //             ),
  //             Text(
  //               'Remarks: ${ministatements[i]["remarks"]}',
  //               style: const TextStyle(
  //                 color: Colors.grey,
  //                 fontSize: 10.0,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       trailing: Container(
  //         width: 0.30 * MediaQuery.of(context).size.width,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.end,
  //           children: [
  //             Text(
  //               "\u20Ac ${ministatements[i]["amount"]} ",
  //               style: const TextStyle(
  //                 color: Color.fromARGB(255, 179, 14, 14),
  //                 fontSize: 10.0,
  //               ),
  //             ),
  //             const Text(
  //               "Cr",
  //               style: TextStyle(color: Colors.green, fontSize: 10.0),
  //             ),
  //             const SizedBox(
  //               width: 4.0,
  //             ),
  //             IconButton(
  //               onPressed: () {},
  //               icon: const Icon(
  //                 Icons.chevron_right,
  //                 color: Color.fromARGB(255, 179, 14, 14),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //     itemCount: ministatements.length,
  //     itemBuilder: (context, index) {
  //       return mstile(context, index);
  //     },
  //   );
  // }
}
