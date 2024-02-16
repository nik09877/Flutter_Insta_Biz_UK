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
      final response =
          await get(Uri.parse('http://10.101.151.42:3000/accounts'));
      final jsonData = jsonDecode(response.body) as List;
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
              onPressed: () {}),
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
