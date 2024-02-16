import 'package:flutter/material.dart';
import 'accounts.dart';
// import 'fundtransfer1.dart';
import 'fund_transfer_screen.dart';
import 'cross_currency_screen.dart';
import 'managepayee.dart';
// import 'approvalpage.dart';
import 'my_approvals_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class InstaBIZPage extends StatefulWidget {
  final int userId;

  const InstaBIZPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<InstaBIZPage> createState() => _InstaBIZPageState();
}

class _InstaBIZPageState extends State<InstaBIZPage> {
  int selectedPageIndex = 0;
  // late int userId;
  // List pageOptions = ;
  List pageOptions = [
    // DefaultPage(userId: widget.userId),
    const Center(
      child: Text(
        "My Profile",
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Center(
      child: Text(
        "Manage Payee",
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Center(
      child: Text(
        "Exchange Rate",
        style: TextStyle(color: Colors.white),
      ),
    ),
    const Center(
      child: Text(
        "Favourites",
        style: TextStyle(color: Colors.white),
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 67, 18, 0),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 179, 14, 14),
          title: Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'What would you like to do today?',
                      hintStyle: TextStyle(
                          color: Color.fromARGB(255, 218, 207, 207),
                          fontSize: 8.0),
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.white,
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.logout),
                  color: Colors.white,
                )
              ],
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
      ),
      body: selectedPageIndex == 0
          ? DefaultPage(userId: widget.userId)
          : pageOptions[selectedPageIndex],
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('InstaBIZ'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: buildNavBar(context),
    );
  }

  Container buildNavBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      height: 75,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 1;
                  });
                },
                icon: Image.asset(
                  'assets/myprofile.png',
                  height: 30,
                  width: 50,
                ),
              ),
              const Text(
                "My Profile",
                style: TextStyle(
                    color: Color.fromARGB(255, 199, 196, 196), fontSize: 10.0),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 2;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PayeeSelection(userId: widget.userId)));
                },
                icon: Image.asset(
                  'assets/managepayee.png',
                  height: 30,
                  width: 50,
                ),
              ),
              const Text(
                "Manage Payee",
                style: TextStyle(
                    color: Color.fromARGB(255, 199, 196, 196), fontSize: 10.0),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 3;
                  });
                },
                icon: Image.asset(
                  'assets/exchangerate.png',
                  height: 30,
                  width: 50,
                ),
              ),
              const Text(
                "Exchange Rate",
                style: TextStyle(
                    color: Color.fromARGB(255, 199, 196, 196), fontSize: 10.0),
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedPageIndex = 4;
                  });
                },
                icon: Image.asset(
                  'assets/favourites.png',
                  height: 30,
                  width: 50,
                ),
              ),
              const Text(
                "Favourites",
                style: TextStyle(
                    color: Color.fromARGB(255, 199, 196, 196), fontSize: 10.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DefaultPage extends StatefulWidget {
  final int userId;
  const DefaultPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  List<Map<String, dynamic>> accounts = [];

  Future<void> fetchData() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.101.151.42:3000/accounts'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Map<String, dynamic>> accountData =
            data.cast<Map<String, dynamic>>();
        List<Map<String, dynamic>> userAccounts = accountData
            .where((account) => account['userId'] == widget.userId)
            .toList();
        setState(() {
          accounts = userAccounts;
        });
      } else {
        throw Exception('Error...');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  // List<Map<String, String>> cardDataList = [
  //   {
  //     'accountName': 'LOUIWOLPUKLIMIPAQ',
  //     'currency': 'Currency-  GBP',
  //     'accountNumber': '75734188',
  //     'balance': '1.88',
  //   },
  //   {
  //     'accountName': 'Another Account',
  //     'currency': 'Currency-  USD',
  //     'accountNumber': '12345678',
  //     'balance': '100.00',
  //   },
  //   // Add more data as needed
  // ];

  List<CardWidget> generateCardWidgets(List<Map<String, dynamic>> dataList) {
    return dataList.map((data) {
      return CardWidget(
        accountName: data['name']!,
        currency: data['currency']!,
        accountNumber: data['accountNumber']!,
        balance: data['balance']!,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Container(
              height: 206,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(10.0),
                children: generateCardWidgets(accounts),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Container(
              alignment: Alignment.center,
              height: 60.0,
              width: 340.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color: const Color.fromARGB(255, 224, 219, 175),
                    width: 2.0),
              ),
              child: const Text(
                "Welcome to instaBIZ",
                style: TextStyle(
                    color: Color.fromARGB(255, 244, 219, 175), fontSize: 14.0),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: 184.0,
              width: 320,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AccountsPage(userId: widget.userId)));
                        },
                        icon: Image.asset(
                          'assets/accounts.png',
                          height: 60,
                          width: 60,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40.0),
                        height: 90.0,
                        width: 1.0,
                        color: Colors.grey,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Approval(
                                        userId: widget.userId,
                                      )));
                        },
                        icon: Image.asset(
                          'assets/approvals.png',
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 1.0,
                    // width: 1.0,
                    color: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => fundtransfer(
                                        userId: widget.userId,
                                      )));
                        },
                        icon: Image.asset(
                          'assets/fundtransfer.png',
                          height: 60,
                          width: 60,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 40.0),
                        height: 90.0,
                        width: 1.0,
                        color: Colors.grey,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CrossCurrencyScreen(
                                        userId: widget.userId,
                                      )));
                        },
                        icon: Image.asset(
                          'assets/crosscurrency.png',
                          height: 70,
                          width: 70,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              "Last visited 17-Nov-2022, 12:09pm",
              style: TextStyle(
                  color: Color.fromARGB(255, 244, 219, 175), fontSize: 10.0),
            ),
          ],
        ),
      ),
    );
  }
}

class CardWidget extends StatelessWidget {
  final String accountName;
  final String currency;
  final int accountNumber;
  final int balance;

  CardWidget({
    required this.accountName,
    required this.currency,
    required this.accountNumber,
    required this.balance,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      margin: EdgeInsets.only(right: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/cardbg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(child: SizedBox(height: 20)),
              Image.asset(
                'assets/banklogo.png',
                height: 40,
                width: 100,
              ),
            ],
          ),
          Text(
            accountName,
            style: TextStyle(color: Colors.white, fontSize: 14.0),
          ),
          const SizedBox(height: 4.0),
          Text(
            'Currency $currency',
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
          const SizedBox(height: 4.0),
          Text(
            "Current Account (A/C No: $accountNumber)",
            style: TextStyle(color: Colors.white, fontSize: 12.0),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                width: 80.0,
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white,
                    width: 1.8,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "\$ $balance",
                  style: TextStyle(color: Colors.white, fontSize: 10.0),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.refresh,
                  color: Colors.white,
                ),
              )
            ],
          ),
          const SizedBox(height: 2.0),
          Container(
            height: 1.0,
            color: Colors.red,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Statement",
                    style: TextStyle(color: Colors.white, fontSize: 8.0),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: 1.0,
                  color: Colors.white,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "View Details",
                    style: TextStyle(color: Colors.white, fontSize: 8.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
