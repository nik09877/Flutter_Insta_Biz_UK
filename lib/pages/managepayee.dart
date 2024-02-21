import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'instabiz.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: PayeeSelection(),
//     );
//   }
// }

class PayeeSelection extends StatefulWidget {
  final int userId;
  const PayeeSelection({Key? key, required this.userId}) : super(key: key);

  @override
  _PayeeSelectionState createState() => _PayeeSelectionState();
}

class _PayeeSelectionState extends State<PayeeSelection> {
  int? selectedPayee;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 179, 14, 14),
        title: Row(
          children: [
            IconButton(
                icon: Icon(Icons.menu, color: Colors.white), onPressed: () {}),
            const Expanded(
              child: Text(
                'Manage Payee',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            const SizedBox(width: 55),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => InstaBIZPage(
                        userId: widget.userId,
                      )),
            );
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        margin: isWideScreen
            ? EdgeInsets.only(
                left: 0.25 * MediaQuery.of(context).size.width,
                right: 0.25 * MediaQuery.of(context).size.width)
            : null, // Adjust the margin value as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                'Beneficiary Account',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ),
            SizedBox(height: 10),
            RadioListTile(
              title: Text('Beneficiary ICICI Bank '),
              value: 1,
              groupValue: selectedPayee,
              onChanged: (value) {
                setState(() {
                  selectedPayee = value as int?;
                });
              },
            ),
            RadioListTile(
              title: Text('Beneficiary CHAPS '),
              value: 2,
              groupValue: selectedPayee,
              onChanged: (value) {
                setState(() {
                  selectedPayee = value as int?;
                });
              },
            ),
            RadioListTile(
              title: Text('Same day Payee '),
              value: 3,
              groupValue: selectedPayee,
              onChanged: (value) {
                setState(() {
                  selectedPayee = value as int?;
                });
              },
            ),
            RadioListTile(
              title: Text(
                  'AN Account with Any other Bank (For Swift/ Wire Transfers to India and Other Countries)'),
              value: 4,
              groupValue: selectedPayee,
              onChanged: (value) {
                setState(() {
                  selectedPayee = value as int?;
                });
              },
            ),
            RadioListTile(
              title: Text(
                  'AN Account with Any other Bank In India (Payment in INR)'),
              value: 5,
              groupValue: selectedPayee,
              onChanged: (value) {
                setState(() {
                  selectedPayee = value as int?;
                });
              },
            ),
            RadioListTile(
              title:
                  Text('AN Account with ICIC Bank In India (Payment In INR)'),
              value: 6,
              groupValue: selectedPayee,
              onChanged: (value) {
                setState(() {
                  selectedPayee = value as int?;
                });
              },
            ),
            RadioListTile(
              title: Text('Any Other Account with ICICI Bank Account UK PLC'),
              value: 7,
              groupValue: selectedPayee,
              onChanged: (value) {
                setState(() {
                  selectedPayee = value as int?;
                });
              },
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PayeeListScreen(
                              userId: widget.userId,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: Text(
                        'Add Payee',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                );
              } else {
                // Mobile layout
                return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PayeeListScreen(
                          userId: widget.userId,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    'Add Payee',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class PayeeListScreen extends StatefulWidget {
  final int userId;

  PayeeListScreen({required this.userId});

  @override
  _PayeeListScreenState createState() => _PayeeListScreenState();
}

class _PayeeListScreenState extends State<PayeeListScreen> {
  List<Map<String, dynamic>> payees = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      //   final response =
      //       await http.get(Uri.parse('http://192.168.226.12:3000/payers'));
      //   if (response.statusCode == 200) {
      // List<dynamic> data = json.decode(response.body);
      List<dynamic> data = [
        {
          "payerName": "Person A Payer 1",
          "currency": "USD",
          "accountNumber": "123456789",
          "userId": 100000001,
          "payerType": "Type1"
        },
        {
          "payerName": "Person A Payer 2",
          "currency": "EUR",
          "accountNumber": "987654321",
          "userId": 100000001,
          "payerType": "Type2"
        },
        {
          "payerName": "Person A Payer 3",
          "currency": "GBP",
          "accountNumber": "111122223333",
          "userId": 100000001,
          "payerType": "Type3"
        },
        {
          "payerName": "Person A Payer 4",
          "currency": "JPY",
          "accountNumber": "444455556666",
          "userId": 100000001,
          "payerType": "Type4"
        },
        {
          "payerName": "Person B Payer 1",
          "currency": "USD",
          "accountNumber": "123456789",
          "userId": 100000002,
          "payerType": "Type1"
        },
        {
          "payerName": "Person B Payer 2",
          "currency": "EUR",
          "accountNumber": "987654321",
          "userId": 100000002,
          "payerType": "Type2"
        },
        {
          "payerName": "Person B Payer 3",
          "currency": "GBP",
          "accountNumber": "111122223333",
          "userId": 100000002,
          "payerType": "Type3"
        },
        {
          "payerName": "Person B Payer 4",
          "currency": "JPY",
          "accountNumber": "444455556666",
          "userId": 100000002,
          "payerType": "Type4"
        },
        {
          "payerName": "Person C Payer 1",
          "currency": "USD",
          "accountNumber": "123456789",
          "userId": 100000003,
          "payerType": "Type1"
        },
        {
          "payerName": "Person C Payer 2",
          "currency": "EUR",
          "accountNumber": "987654321",
          "userId": 100000003,
          "payerType": "Type2"
        },
        {
          "payerName": "Person C Payer 3",
          "currency": "GBP",
          "accountNumber": "111122223333",
          "userId": 100000003,
          "payerType": "Type3"
        },
        {
          "payerName": "Person C Payer 4",
          "currency": "JPY",
          "accountNumber": "444455556666",
          "userId": 100000003,
          "payerType": "Type4"
        }
      ];
      setState(() {
        // Filter data based on userId
        payees = data
            .where((payee) => payee['userId'] == widget.userId)
            .map((item) => Map<String, dynamic>.from(item))
            .toList();
      });
      // } else {
      //   throw Exception('Failed to load data');
      // }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 204, 23, 23),
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.menu, color: Colors.white),
              onPressed: () {},
            ),
            Expanded(
              child: Text(
                'Manage Payee',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 55),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: Container(
        margin: isWideScreen
            ? EdgeInsets.only(
                left: 0.25 * screenWidth,
                right: 0.25 * MediaQuery.of(context).size.width)
            : null,
        child: payees.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: payees.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(payees[index]['accountNumber'].toString()),
                    onDismissed: (direction) {
                      setState(() {
                        // Remove the item from the list when swiped
                        payees.removeAt(index);
                      });
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          payees[index]['payerName']![0].toUpperCase() +
                              payees[index]['payerName']![1].toUpperCase(),
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Color.fromARGB(255, 204, 23, 23),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  payees[index]['payerName']!,
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(height: 3),
                                Text(
                                  'Account No: ',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                Text('${payees[index]['accountNumber']}'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  payees[index]['currency']!,
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 204, 23, 23),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'payertype :',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(' ${payees[index]['payertype']}'),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                payees.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.cancel),
                            color: Color.fromARGB(255, 204, 23, 23),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add Payee functionality...
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: Text(
                        'Add Payee',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ),
                );
              } else {
                return ElevatedButton(
                  onPressed: () {
                    // Add Payee functionality...
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    'Add Payee',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
