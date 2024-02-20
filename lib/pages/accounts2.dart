import 'package:flutter/material.dart';
import 'dart:core';
import 'package:http/http.dart';
import 'dart:convert';

class AccountsPage2 extends StatefulWidget {
  const AccountsPage2({super.key});

  @override
  State<AccountsPage2> createState() => _AccountsPage2State();
}

class _AccountsPage2State extends State<AccountsPage2> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  var accountList = [];
  void fetchData() async {
    try {
      // final response =
      //     await get(Uri.parse('http://192.168.226.12:3000/accounts'));
      // final jsonData = jsonDecode(response.body) as List;
      final jsonData = [
        {
          "name": "John Doe",
          "userId": 100000001,
          "accountNumber": 1001,
          "currency": "USD",
          "balance": 5000,
          "openingDate": "2023-05-10",
          "branch": "Main Street",
          "customerId": 5001,
          "accountType": "Savings"
        },
        {
          "name": "Jane Smith",
          "userId": 100000002,
          "accountNumber": 1002,
          "currency": "EUR",
          "balance": 8000,
          "openingDate": "2023-08-20",
          "branch": "Downtown",
          "customerId": 5002,
          "accountType": "Checking"
        },
        {
          "name": "Alice Johnson",
          "userId": 100000003,
          "accountNumber": 1003,
          "currency": "GBP",
          "balance": 12000,
          "openingDate": "2022-12-05",
          "branch": "Uptown",
          "customerId": 5003,
          "accountType": "Savings"
        },
        {
          "name": "Bob Brown",
          "userId": 100000001,
          "accountNumber": 1004,
          "currency": "JPY",
          "balance": 3000,
          "openingDate": "2024-01-15",
          "branch": "Suburb",
          "customerId": 5004,
          "accountType": "Checking"
        },
        {
          "name": "Charlie Wilson",
          "userId": 100000002,
          "accountNumber": 1005,
          "currency": "CAD",
          "balance": 15000,
          "openingDate": "2023-11-30",
          "branch": "Midtown",
          "customerId": 5005,
          "accountType": "Savings"
        },
        {
          "name": "Diana Garcia",
          "userId": 100000003,
          "accountNumber": 1006,
          "currency": "AUD",
          "balance": 10000,
          "openingDate": "2023-02-22",
          "branch": "Downtown",
          "customerId": 5006,
          "accountType": "Checking"
        },
        {
          "name": "Eva Martinez",
          "userId": 100000001,
          "accountNumber": 1007,
          "currency": "EUR",
          "balance": 7500,
          "openingDate": "2024-03-05",
          "branch": "Uptown",
          "customerId": 5007,
          "accountType": "Savings"
        },
        {
          "name": "Frank Miller",
          "userId": 100000002,
          "accountNumber": 1008,
          "currency": "USD",
          "balance": 9000,
          "openingDate": "2023-06-12",
          "branch": "Main Street",
          "customerId": 5008,
          "accountType": "Checking"
        },
        {
          "name": "Grace Taylor",
          "userId": 100000003,
          "accountNumber": 1009,
          "currency": "GBP",
          "balance": 11000,
          "openingDate": "2024-04-18",
          "branch": "Downtown",
          "customerId": 5009,
          "accountType": "Savings"
        },
        {
          "name": "Henry Lewis",
          "userId": 100000001,
          "accountNumber": 1010,
          "currency": "CAD",
          "balance": 6000,
          "openingDate": "2023-09-25",
          "branch": "Midtown",
          "customerId": 5010,
          "accountType": "Checking"
        },
        {
          "name": "Ivy Turner",
          "userId": 100000002,
          "accountNumber": 1011,
          "currency": "USD",
          "balance": 9500,
          "openingDate": "2023-10-08",
          "branch": "Suburb",
          "customerId": 5011,
          "accountType": "Savings"
        },
        {
          "name": "Jack Harris",
          "userId": 100000003,
          "accountNumber": 1012,
          "currency": "JPY",
          "balance": 13000,
          "openingDate": "2024-05-14",
          "branch": "Uptown",
          "customerId": 5012,
          "accountType": "Checking"
        },
        {
          "name": "Kelly White",
          "userId": 100000001,
          "accountNumber": 1013,
          "currency": "CAD",
          "balance": 7200,
          "openingDate": "2023-07-01",
          "branch": "Downtown",
          "customerId": 5013,
          "accountType": "Savings"
        },
        {
          "name": "Leo Rodriguez",
          "userId": 100000002,
          "accountNumber": 1014,
          "currency": "GBP",
          "balance": 10500,
          "openingDate": "2024-02-28",
          "branch": "Main Street",
          "customerId": 5014,
          "accountType": "Checking"
        },
        {
          "name": "Mia Brown",
          "userId": 100000003,
          "accountNumber": 1015,
          "currency": "USD",
          "balance": 8800,
          "openingDate": "2023-04-16",
          "branch": "Midtown",
          "customerId": 5015,
          "accountType": "Savings"
        }
      ];
      setState(() {
        accountList = jsonData;
        // debugPrint(accountList[0]);
      });
    } catch (er) {
      //error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[600],
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {}),
              Expanded(
                  child: Text(
                'Accounts',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
              SizedBox(
                width: 55,
              )
            ],
          )),
      body: ListView.builder(
          itemCount: accountList.length,
          itemBuilder: (context, index) {
            return Column(children: [
              AccountTile(accountList[index]),
              Divider(
                color: Colors.grey[200],
                height: 1,
                //thickness:1,
              ),
            ]);
          }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horizontal_circle, color: Colors.indigo),
            label: 'Fund Transfer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compare_arrows, color: Colors.indigo),
            label: 'Cross Currency',
          ),
        ],
        selectedLabelStyle: TextStyle(
            color: Colors.indigo), // Set the color for selected label text
        unselectedLabelStyle: TextStyle(color: Colors.grey[700]),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget AccountTile(acc) {
    return ListTile(
        title: Container(
          width: 0.65 * MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(acc["name"],
                  style: TextStyle(fontSize: 14, color: Colors.blue)),
              SizedBox(height: 4),
              Text('A/C No : ${acc["ac_no"]}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]))
            ],
          ),
        ),
        trailing: Container(
          width: 0.35 * MediaQuery.of(context).size.width,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('${CurrencyConverter(acc["currency"])} ${acc["balance"]}',
                style: TextStyle(fontSize: 12, color: Colors.red[600])),
            IconButton(
                icon: Icon(Icons.chevron_right, color: Colors.red[600]),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => accdetails(acc: acc),
                    ),
                  );
                }),
          ]),
        ));
  }

  String CurrencyConverter(String currencyName) {
    switch (currencyName.toLowerCase()) {
      case 'dollar':
        return '\$';
      case 'euro':
        return '€';
      case 'gbp':
        return '£';
      default:
        return currencyName; // Return the original name if not found
    }
  }
}

class AccountDetails {
  String accountName;
  String accountNumber;
  String currency;
  String balance;
  String accopendate;
  String Branch;
  String AccType;
  String cid;

  AccountDetails(
      {required this.accountName,
      required this.accountNumber,
      required this.currency,
      required this.balance,
      required this.accopendate,
      required this.Branch,
      required this.AccType,
      required this.cid});
}

class accdetails extends StatefulWidget {
  //const accdetails({super.key});
  final dynamic acc;
  accdetails({Key? key, required this.acc});
  @override
  State<accdetails> createState() => _accdetailsState();
}

class _accdetailsState extends State<accdetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red[600],
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {}),
              Expanded(
                  child: Text(
                'Accounts',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
              SizedBox(
                width: 55,
              )
            ],
          )),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
                padding: EdgeInsets.all(40),
                height: 0.38 * MediaQuery.of(context).size.height,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ]),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account Number',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700])),
                          SizedBox(height: 4),
                          Text('${widget.acc["ac_no"]}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue)),
                          SizedBox(height: 4),
                          Text('Branch',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700])),
                          SizedBox(height: 4),
                          Text('${widget.acc["branch"]}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue)),
                          SizedBox(height: 4),
                          Text('Customer ID',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700])),
                          SizedBox(height: 4),
                          Text('${widget.acc["customer_id"]}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue)),
                          SizedBox(height: 4),
                          Text('Account Type',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700])),
                          SizedBox(height: 4),
                          Text('${widget.acc["account_type"]}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue)),
                          SizedBox(height: 4),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account Open date',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700])),
                          SizedBox(height: 4),
                          Text('${widget.acc["account_opening_date"]}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue)),
                          SizedBox(height: 4),
                          Text('Currency',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700])),
                          SizedBox(height: 4),
                          Text('${widget.acc["currency"]}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue)),
                          SizedBox(height: 4),
                          Text('Balance',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[700])),
                          SizedBox(height: 4),
                          Text('${widget.acc["balance"]}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue)),
                          SizedBox(height: 4),
                        ],
                      ),
                    )
                  ],
                )),
            Expanded(child: Container()),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 2, 35, 61),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text('GO TO HOME',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white))),
            ),
          ],
        ),
      ),
    );
  }
}
