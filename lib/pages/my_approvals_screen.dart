import 'package:flutter/material.dart';
import 'package:myproject/models/account_model.dart';
import 'package:myproject/service/api_service.dart';

class Approval extends StatefulWidget {
  final int userId;
  const Approval({super.key, required this.userId});

  @override
  State<Approval> createState() => _ApprovalState();
}

class _ApprovalState extends State<Approval> {
  String? _selectedAccountNumber;
  String? _selectedType;
  bool isVisible1 = true;
  bool isVisible2 = true;
  bool isTypeVisible = false;
  bool isListVisible = false;
  List<String> accounts = [
    '75734188 (GBP)-LOUIWOLPUKLIMIPAQ',
    '75762269 (GBP)-NFRN CREDIT UNION LTD',
    '75785778 (USD)-INTERNATIONAL FINANCE AND EQUIPMENT',
    '75785776 (GBP)-INTERNATIONAL FINANCE AND EQUIPMENT'
  ];
  List<Pending> list = [
    Pending(isChecked: false, accountInfo: '75734188 (GBP)-LOUIWOLPUKLIMIPAQ'),
  ];

  Account? currentAccount;
  List<Account>? userAccounts;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

  @override
  void initState() {
    getAllAccounts(widget.userId);
    super.initState();
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

  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: const Text('No Pending Approvals List Available'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.blue),
                    ))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Approvals'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.redAccent[700],
        centerTitle: true,
      ),
      body: userAccounts != null
          ? Form(
              key: _formKey,
              child: Column(
                children: [
                  DropdownButtonFormField(
                    value: _selectedAccountNumber,
                    validator: (value) {
                      if (value == null) {
                        return 'This is required';
                      }
                      return null;
                    },
                    hint: const Text('Account Number'),
                    onChanged: (value) {
                      setState(() {
                        _selectedAccountNumber = value;
                        isVisible1 = false;
                        isTypeVisible = true;
                        int accNo = int.parse(value.split(' ')[0]);
                        currentAccount = userAccounts
                            ?.firstWhere((acc) => acc.accountNumber == accNo);
                        list = [
                          (Pending(isChecked: false, accountInfo: value))
                        ];
                      });
                    },
                    decoration: const InputDecoration(
                        label: Row(
                      children: [
                        Text(
                          'Account Number',
                          style: TextStyle(color: Colors.black),
                        ),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    )),
                    items: userAccounts?.map<DropdownMenuItem>((acc) {
                      String value =
                          "${acc.accountNumber} (${acc.currency}) - ${acc.branch}";
                      return DropdownMenuItem(
                        value: value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                                width: 250,
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                )),
                            Visibility(
                                visible: isVisible1,
                                child: Radio(
                                    value: value,
                                    groupValue: _selectedAccountNumber,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedAccountNumber = value;
                                      });
                                    }))
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  Visibility(
                    visible: isTypeVisible,
                    child: DropdownButtonFormField(
                      value: _selectedType,
                      validator: (value) {
                        if (value == null) {
                          return 'This is required';
                        }
                        return null;
                      },
                      hint: const Text('Select Transaction Type'),
                      onChanged: (value) {
                        setState(() {
                          _selectedType = value;
                          isVisible2 = false;
                          if (_selectedType == 'Fund Transfer') {
                            if (list.isNotEmpty) {
                              isListVisible = true;
                            } else {
                              _showAlertDialog();
                            }
                          }
                        });
                      },
                      decoration: const InputDecoration(
                          label: Row(
                        children: [
                          Text(
                            'Transaction Type',
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            '*',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      )),
                      items: ['Fund Transfer', 'Cross Currency']
                          .map<DropdownMenuItem>((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(value),
                              Visibility(
                                  visible: isVisible2,
                                  child: Radio(
                                      value: value,
                                      groupValue: _selectedType,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedType = value;
                                        });
                                      }))
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Select account number & Transaction type to get list of pending Approvals',
                    ),
                  ),
                  Visibility(
                    visible: isListVisible,
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('                '),
                        Text('Debit A/C'),
                        Text('Amount'),
                        Text(
                          'Beneficiary\nDetails',
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Visibility(
                      visible: isListVisible,
                      child: ListView.builder(
                          itemCount: list.length,
                          itemBuilder: ((context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Form(
                                  key: _formKey2,
                                  child: FormField(
                                    builder: (state) {
                                      return Checkbox(
                                          value: list[index].isChecked,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              list[index].isChecked = value!;
                                              state.validate();
                                            });
                                          });
                                    },
                                    validator: (value) {
                                      if (list[index].isChecked == false) {
                                        return 'Please check the box';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                Text(list[index].accountInfo.split(' ')[0]),
                                Text(
                                    '£${currentAccount != null ? currentAccount!.balance : ''}'),
                                Text(
                                  currentAccount != null
                                      ? currentAccount!.name
                                      : '',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      color: Colors.red[600]),
                                )
                              ],
                            );
                          })),
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _formKey2.currentState!.validate()) {}
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.blue[800],
                              foregroundColor: Colors.white,
                              shape: const LinearBorder(side: BorderSide.none)),
                          child: const Text('Approve'),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate() &&
                                _formKey2.currentState!.validate()) {}
                          },
                          style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.blue[800],
                              foregroundColor: Colors.white,
                              shape: const LinearBorder(side: BorderSide.none)),
                          child: const Text('Reject'),
                        ),
                      ),
                    ],
                  )
                ],
              ))
          : const Center(child: CircularProgressIndicator()),
    );
  }
}

class Pending {
  bool isChecked;
  String accountInfo;

  Pending({required this.isChecked, required this.accountInfo});
}
