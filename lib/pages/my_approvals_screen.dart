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
      final data = await ApiService().getAllAccounts(widget.userId);

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
