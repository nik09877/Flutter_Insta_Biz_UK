import 'package:flutter/material.dart';
import 'package:myproject/models/account_model.dart';
import 'package:myproject/models/payer_model.dart';
import 'package:myproject/service/api_service.dart';
import 'package:myproject/pages/addpayee.dart';

class fundtransfer extends StatefulWidget {
  final int userId;
  const fundtransfer({super.key, required this.userId});

  @override
  State<fundtransfer> createState() => _fundtransferState();
}

class _fundtransferState extends State<fundtransfer> {
  final _formKey = GlobalKey<FormState>();
  bool currentAccountSelected = false;
  Account? currentAccount;
  bool isPayeeSelected = false;
  int radioValue = 0;
  String? radioVal;
  int selectedRadio = 1;
  double balanace = 1.88;
  final amountValue = TextEditingController();
  final remarks = TextEditingController();
  Map<String, String?> dropdownValues = {};
  Map<int, String> selectedMap = {};
  List<Payer>? payers;
  List<Account>? userAccounts;
  final RegExp amountRegex = RegExp(r'^\d+(\.\d{1,2})?$');
  final Map<int, String> radio1Values = {
    75617697: 'four',
    76261111: 'nov23adb',
    76260962: 'SRIDHAR',
    76260961: 'TESTERRORE',
  };

  final Map<int, String> radio2Values = {
    147258369: 'xamz',
    12345636: 'bhavni',
    14789001: 'gj',
    12457800: 'zam',
  };

  final Map<int, String> radio3Values = {
    8749067: 'PAY1',
    123: 'MANIKANDAN',
    98745632: 'SEEMAA',
    23456789: 'SDFSDF',
  };

  bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600;
  bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  @override
  void initState() {
    getAllAccounts(widget.userId);
    getAllPayers(widget.userId);

    selectedMap = radio1Values;
    super.initState();
  }

  setSelectedRadio(int val) {
    setState(() {
      // selectedRadio = val;
      dropdownValues['dropdownKey4'] = null;
      switch (val) {
        case 1:
          selectedMap = radio1Values;
          break;
        case 2:
          selectedMap = radio2Values;
          break;
        case 3:
          selectedMap = radio3Values;
          break;
      }
    });
  }

  Future getAllAccounts(int userId) async {
    try {
      // final data = await ApiService().getAllAccounts(widget.userId);
      final data_temp = [
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
      final data = data_temp
          .map((account) => Account.fromJson(account))
          .where((account) => account.userId == userId)
          .toList();
      setState(() {
        userAccounts = data;
      });
    } catch (e) {
      throw Exception('Failed to fetch accounts: ${e.toString()}');
    }
  }

  Future getAllPayers(int userId) async {
    try {
      // final data = await ApiService().getAllPayers(widget.userId);
      final data_temp = [
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
      final data = data_temp
          .map((payer) => Payer.fromJson(payer))
          .where((payer) => payer.userId == userId)
          .toList();
      setState(() {
        payers = data;
      });
    } catch (e) {
      throw Exception('Failed to fetch payers: ${e.toString()}');
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
            },
          ),
          title: Row(
            children: [
              IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {}),
              const Expanded(
                child: Text(
                  'Fund Transfer',
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
        ),
        body: payers != null && userAccounts != null
            ? Container(
                margin: isDesktop(context)
                    ? EdgeInsets.symmetric(
                        horizontal: 0.2 * MediaQuery.of(context).size.width)
                    : null,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(16, 30, 16, 0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('From',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      SizedBox(height: 25),
                                      Text('Current Account',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      // builddropdown("Account Number", ['75617697','76261111','76260962','76260961','76260960','76261108','76261086','76261113'], 'dropdownkey1'),
                                      Container(
                                        width: isDesktop(context)
                                            ? 400.0
                                            : 0.95 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                        child: DropdownButtonFormField<String>(
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                              ),
                                            ),
                                            hintText: "Account Number",
                                            hintStyle: TextStyle(
                                              color: Color.fromRGBO(
                                                  224, 224, 224, 1),
                                              fontSize: 14.0,
                                            ),
                                          ),
                                          key: Key('dropdownkey1'),
                                          value: dropdownValues['dropdownkey1'],
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              dropdownValues['dropdownkey1'] =
                                                  newValue!;
                                              currentAccountSelected = true;
                                              int accNo = int.parse(
                                                  newValue.split(' ')[0]);
                                              currentAccount = userAccounts
                                                  ?.firstWhere((acc) =>
                                                      acc.accountNumber ==
                                                      accNo);
                                            });
                                          },
                                          items: userAccounts?.map((acc) {
                                            String value =
                                                "${acc.accountNumber} (${acc.currency}) - ${acc.branch}";
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    // width: 0.7 *
                                                    //     MediaQuery.of(context)
                                                    //         .size
                                                    //         .width,
                                                    child: Text(
                                                      value,
                                                      style: TextStyle(
                                                          fontSize: 12),
                                                    ),
                                                  ),
                                                  if (radioVal != value)
                                                    Radio<String>(
                                                      value: value,
                                                      groupValue: radioVal,
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          radioVal = value;
                                                        });
                                                      },
                                                    ),
                                                ],
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Visibility(
                                        visible: currentAccountSelected,
                                        child: Text(
                                          'Available Balance \u20Ac${currentAccount != null ? currentAccount!.balance : ''}',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 20),
                                      _customRadio('ICICI Bank Self/BFX', 1),
                                      SizedBox(height: 30),
                                      _customRadio('Benefeciary CHAPS', 2),
                                      SizedBox(height: 30),
                                      _customRadio('Same day Payee', 3),
                                      SizedBox(height: 30),
                                      Text('Transfer To',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey)),
                                      SizedBox(height: 20),
                                      Container(
                                        width: isDesktop(context)
                                            ? 400.0
                                            : 0.95 *
                                                MediaQuery.of(context)
                                                    .size
                                                    .width,
                                        child: DropdownButtonFormField<String>(
                                          key: Key('dropdownKey4'),
                                          value: dropdownValues['dropdownkey4'],
                                          onChanged: (value) {
                                            setState(() {
                                              dropdownValues['dropdownkey4'] =
                                                  value!;
                                              isPayeeSelected =
                                                  !isPayeeSelected;
                                            });
                                          },
                                          hint: Text('Select Payee',
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 139, 135, 135),
                                                  fontSize: 14)),
                                          items: payers!.map((payer) {
                                            return DropdownMenuItem<String>(
                                              value: payer.accountNumber
                                                  .toString(),
                                              child: dropDownOption(
                                                  int.parse(
                                                      payer.accountNumber),
                                                  payer.payerName,
                                                  payer.currency),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AddPayee()));
                                            },
                                            child: Text('Add Payee',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.red[600],
                                                    fontWeight: FontWeight.bold,
                                                    decoration: TextDecoration
                                                        .underline,
                                                    decorationColor:
                                                        Colors.red[600]))),
                                      ),
                                      SizedBox(height: 20),
                                      Visibility(
                                        visible: isPayeeSelected,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: isDesktop(context)
                                                  ? 400.0
                                                  : 0.95 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                              child: TextFormField(
                                                controller: amountValue,
                                                decoration:
                                                    const InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            174,
                                                            164,
                                                            164)),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                  ),
                                                  labelText: "Amount",
                                                  labelStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Color.fromARGB(
                                                        255, 174, 164, 164),
                                                  ),
                                                  hintText: '\u20Ac0.01',
                                                  hintStyle: TextStyle(
                                                    fontSize: 10,
                                                    color: Color.fromARGB(
                                                        255, 174, 164, 164),
                                                  ),
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                ),
                                                onChanged: (value) {
                                                  _formKey.currentState!
                                                      .validate();
                                                },
                                                validator: (value) {
                                                  if (value == null)
                                                    return "Enter Amount";
                                                  if (!amountRegex
                                                      .hasMatch(value)) {
                                                    return 'Enter a valid amount';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Text('Remarks',
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.grey)),
                                            Container(
                                              width: isDesktop(context)
                                                  ? 400.0
                                                  : 0.95 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                              child: builddropdown(
                                                  "Remarks",
                                                  [
                                                    'option 1',
                                                    'option 2',
                                                    'option 3'
                                                  ],
                                                  'dropdownkey3'),
                                            ),
                                            SizedBox(
                                              height: 5.0,
                                            ),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 10.0),
                                              width: isDesktop(context)
                                                  ? 400.0
                                                  : 0.95 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                              child: TextFormField(
                                                controller: remarks,
                                                decoration:
                                                    const InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Color.fromARGB(
                                                            255,
                                                            174,
                                                            164,
                                                            164)),
                                                  ),
                                                  focusedBorder:
                                                      UnderlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.red),
                                                  ),
                                                  hintText:
                                                      'Please enter remarks',
                                                  hintStyle: TextStyle(
                                                    fontSize: 10,
                                                    color: Color.fromARGB(
                                                        255, 174, 164, 164),
                                                  ),
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .always,
                                                ),
                                                onChanged: (value) {},
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      width: isDesktop(context)
                          ? 400.0
                          : 0.9 * MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          // _formKey.currentState!.validate();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        child: Text(
                          'PROCEED',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator()));
  }

  Widget dropDownOption(int value, String data, String currency) {
    // final number = value.toString();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            // padding: EdgeInsets.only(top: 5.0),
            height: 26.0,
            width: 26.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(255, 170, 1, 57),
            ),
            child: Text(
              data.substring(0, 2).toUpperCase(),
              style: TextStyle(color: Colors.white, fontSize: 14.0),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                data,
                style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold),
              ),
              Text(
                '$currency($currency)',
                style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget builddropdown(
      String hinttext, List<String> dropdownitems, String dropdownkey) {
    return DropdownButtonFormField(
      key: Key(dropdownkey),
      value: dropdownValues[dropdownkey],
      onChanged: (value) {
        setState(() {
          dropdownValues[dropdownkey] = value!;
        });
      },
      items: dropdownitems.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: TextStyle(color: Colors.grey, fontSize: 12)),
        );
      }).toList(),
      hint: Text(hinttext,
          style: TextStyle(color: Colors.grey[300], fontSize: 14)),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.grey[300]!), // Color of the underlined border
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Colors.red), // Color of the underlined border when focused
        ),
      ),
    );
  }

  Widget _customRadio(String label, int value) {
    return InkWell(
      onTap: () {
        setState(() {
          radioValue = value;
          setSelectedRadio(value);
        });
      },
      child: Container(
          child: Row(
        children: [
          SizedBox(width: 8),
          Container(
            width: 20.0,
            height: 20.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: radioValue == value ? Colors.red : Colors.grey,
                width: 2.0,
              ),
            ),
            child: radioValue == value
                ? Center(
                    child: Container(
                      width: 12.0,
                      height: 12.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                    ),
                  )
                : null,
          ),
          SizedBox(width: 8.0),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      )),
    );
  }
}
