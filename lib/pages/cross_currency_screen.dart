import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myproject/models/account_model.dart';
import 'package:myproject/models/payer_model.dart';
import 'package:myproject/service/api_service.dart';
import 'addPayee.dart';
// import 'package:instabiz_uk/core/constants/color_palette.dart';

class CrossCurrencyScreen extends StatefulWidget {
  final int userId;
  const CrossCurrencyScreen({super.key, required this.userId});

  @override
  State<CrossCurrencyScreen> createState() => _CrossCurrencyScreenState();
}

class _CrossCurrencyScreenState extends State<CrossCurrencyScreen> {
  String? _selectedAccBal;
  String? _selectedPayee;
  String? selectedAmountType = "Buy";
  String? _selectedRemark;
  bool isVisible1 = true;
// Custom validation for a valid amount
  final RegExp amountRegex =
      RegExp(r'^\d+(\.\d{1,2})?$'); // Allows up to 2 decimal places
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();

  Account? currentAccount;
  List<Account>? userAccounts;
  List<Payer>? payers;

  List<String> remarks = ["Remark 1", "Remark 2", "Remark 3"];

  @override
  void initState() {
    // getAllAccounts(widget.userId);
    // getAllPayers(widget.userId);
    getAllAccounts(widget.userId);
    getAllPayers(widget.userId);

    // selectedMap = radio1Values;
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

  Future getAllPayers(int userId) async {
    try {
      final data = await ApiService().getAllPayers(widget.userId);
      setState(() {
        payers = data;
      });
    } catch (e) {
      throw Exception('Failed to fetch payers: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: _appBar(context),
      body: payers != null && userAccounts != null
          ? SafeArea(
              child: ListView(
                children: [
                  Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 16.0, left: 16.0),
                            child: Text("From Account",
                                style: TextStyle(
                                    color: Palette.grey, fontSize: 16)),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 10.0, top: 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Current Account',
                                  style: TextStyle(
                                      color: Palette.grey, fontSize: 14),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(right: 50.0),
                                  child: Text(
                                    'Available Balance',
                                    style: TextStyle(
                                        color: Palette.grey, fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 200,
                                  height: 50,
                                  child: DropdownButtonFormField(
                                    validator: (value) {
                                      if (value == null) {
                                        return 'Please select an option';
                                      }
                                      // Add additional validation as needed
                                      return null; // Return null if the input is valid
                                    },
                                    value: _selectedAccBal,
                                    hint: const Text('Account Number',
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 207, 202, 202),
                                            fontSize: 14)),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        // _selectedAccBal = newValue;
                                        isVisible1 = false;
                                        int accNo =
                                            int.parse(newValue!.split(' ')[0]);
                                        currentAccount =
                                            userAccounts?.firstWhere((acc) =>
                                                acc.accountNumber == accNo);
                                        // isTypeVisible = true;
                                      });
                                      _formKey.currentState!.validate();
                                    },
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                    items: userAccounts?.map((acc) {
                                      String value =
                                          "${acc.accountNumber} (${acc.currency}) - ${acc.branch}";
                                      return DropdownMenuItem(
                                        value: value,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: 120,
                                                child: Text(
                                                  value,
                                                  style: const TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      color: Color.fromARGB(
                                                          178, 0, 0, 0)),
                                                )),
                                            Visibility(
                                                visible: isVisible1,
                                                child: Radio(
                                                    value: value,
                                                    groupValue: _selectedAccBal,
                                                    onChanged: (value) {}))
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                // const SizedBox(width: 10),
                                // Text("￡"),
                                Container(
                                  width: 170,
                                  height: 50,
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 10),
                                  child: Text(
                                      "￡ ${currentAccount != null ? currentAccount!.balance : ''}",
                                      style: const TextStyle(
                                          color: Color.fromARGB(178, 0, 0, 0),
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 14.0, left: 10.0),
                            child: SizedBox(
                              width: 90,
                              child: Stack(
                                children: [
                                  Text(
                                    'Transfer To',
                                    style: TextStyle(
                                      color: Palette.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Positioned(
                                    top:
                                        -4, // Adjust to position asterisk above text
                                    right: 12,
                                    child: Text(
                                      '*',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: DropdownButtonFormField<String>(
                              validator: (value) {
                                if (value == null) {
                                  return 'Please select an option';
                                }
                                // Add additional validation as needed
                                return null; // Return null if the input is valid
                              },
                              key: const Key('key'),
                              value: _selectedPayee,
                              decoration: const InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Palette.red))),
                              onChanged: (value) {
                                setState(() {
                                  _selectedPayee = value!;
                                  // isPayeeSelected = !isPayeeSelected;
                                });
                                _formKey.currentState!.validate();
                              },
                              hint: const Text('Select Payee',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 207, 202, 202),
                                      fontSize: 14)),
                              items: payers!.map((payer) {
                                return DropdownMenuItem<String>(
                                  value: payer.accountNumber.toString(),
                                  child: dropDownOption(
                                      int.parse(payer.accountNumber),
                                      payer.payerName,
                                      payer.currency),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 10),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AddPayee()));
                              },
                              child: const Text(
                                "Add Payee",
                                style: TextStyle(
                                    color: Palette
                                        .red, // Set the text color to red
                                    decoration: TextDecoration.underline,
                                    decorationColor: Palette.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (_selectedAccBal != null && _selectedPayee != null)
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0, left: 16.0),
                              child: Text("Amount",
                                  style: TextStyle(
                                      color: Palette.grey, fontSize: 16)),
                            ),
                          if (_selectedAccBal != null && _selectedPayee != null)
                            Container(
                              padding: const EdgeInsets.only(left: 20, top: 16),
                              width: screenWidth * 0.7,
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Radio(
                                            value: "Buy",
                                            groupValue: selectedAmountType,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedAmountType = value;
                                              });
                                            },
                                            activeColor: Palette
                                                .red, // Set the color for the selected radio button
                                          ),
                                          const Text('Buy',
                                              style: TextStyle(
                                                  color: Palette.grey,
                                                  fontSize: 16,
                                                  letterSpacing: 0.8)),
                                        ]),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Radio(
                                          value: "Sell",
                                          groupValue: selectedAmountType,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedAmountType = value;
                                            });
                                          },
                                        ),
                                        const Text('Sell',
                                            style: TextStyle(
                                                color: Palette.grey,
                                                fontSize: 16)),
                                      ],
                                    ),
                                  ]),
                            ),
                          // const SizedBox(height: 20),
                          if (_selectedAccBal != null && _selectedPayee != null)
                            Container(
                              padding: const EdgeInsets.only(left: 28, top: 16),
                              child: Row(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 2.0),
                                  child: const Text('EUR',
                                      style: TextStyle(
                                          color: Palette.grey, fontSize: 14)),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: _amountController,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Amount cannot be empty';
                                      }

                                      if (!amountRegex.hasMatch(value)) {
                                        return 'Enter a valid amount';
                                      }
                                      return null;
                                    },
                                    onChanged: (value) =>
                                        {_formKey.currentState!.validate()},
                                    keyboardType: TextInputType.number,
                                    // inputFormatters: [
                                    //   FilteringTextInputFormatter.digitsOnly
                                    // ],
                                    cursorColor: Palette.lightGrey,
                                    decoration: const InputDecoration(
                                        border: InputBorder
                                            .none, // Remove the border
                                        focusedBorder: InputBorder
                                            .none, // Remove the focused border
                                        hintText: 'Enter Amount',
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 164, 179, 197))),
                                  ),
                                )
                              ]),
                            ),
                          if (_selectedAccBal != null && _selectedPayee != null)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(
                                color: Palette.lightGrey,
                                height: 2,
                                thickness: 1,
                              ),
                            ),
                          const SizedBox(height: 10),
                          if (_selectedAccBal != null && _selectedPayee != null)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text("Remarks",
                                  style: TextStyle(
                                      color: Palette.grey, fontSize: 12)),
                            ),
                          if (_selectedAccBal != null && _selectedPayee != null)
                            Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: DropdownButtonFormField<String>(
                                  value: _selectedRemark,
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select an option';
                                    }
                                    // Add additional validation as needed
                                    return null; // Return null if the input is valid
                                  },
                                  decoration: InputDecoration(
                                    labelText:
                                        _selectedRemark != null ? '' : 'Remark',
                                    labelStyle:
                                        TextStyle(color: Colors.grey[400]),
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none,
                                  ), // Set label color to light grey
                                  // border:none,
                                  onChanged: (newValue) {
                                    setState(() {
                                      _selectedRemark = newValue;
                                    });
                                    _formKey.currentState!.validate();
                                  },
                                  items: remarks.map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  178, 0, 0, 0))),
                                    );
                                  }).toList(),
                                )),
                          if (_selectedAccBal != null && _selectedPayee != null)
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Divider(
                                color: Palette.lightGrey,
                                height: 2,
                                thickness: 1,
                              ),
                            ),
                        ],
                      )),
                ],
              ),
            )
          : const Center(child: CircularProgressIndicator()),
      bottomNavigationBar: _bottomButton(screenWidth, context),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Palette.red,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, size: 16, color: Palette.white)),
      title: Row(
        children: [
          Container(
              margin: EdgeInsets.only(right: 20),
              child: const Icon(Icons.menu, size: 16, color: Palette.white)),
          const Text(
            "Cross Currency Transfer",
            style: TextStyle(
                color: Palette.white,
                fontSize: 16,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
      // centerTitle: true,
    );
  }

  SizedBox _bottomButton(screenWidth, context) {
    return SizedBox(
      width: screenWidth,
      height: 40,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            showModalBottomSheet(
              shape: const BeveledRectangleBorder(),
              context: context,
              builder: (BuildContext context) {
                // return _myBottomSheetContent();
                return BottomSheetContent();
              },
            );
          }
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: Palette.lightBlue,
            shape: const BeveledRectangleBorder()),
        child: const Text(
          'PROCEED',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  SizedBox _myBottomSheetContent() {
    return SizedBox(
      width: double.maxFinite,
      height: 300,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 50,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Palette.red,
                width: 2,
              ))),
              child: Stack(
                children: [
                  const Center(
                      child: Text(
                    'Verify OTP',
                    style: TextStyle(
                        color: Palette.red,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  )),
                  Positioned(
                      top: 2,
                      right: 0,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('X',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20))))
                ],
              )),
          Expanded(
              child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
                  decoration: BoxDecoration(color: Colors.grey[100]),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text(
                          "Please enter the OTP sent to the registered mobile number 76**45**90",
                          style: TextStyle(
                            fontSize: 10,
                          )),
                      SizedBox(height: 16),
                      SizedBox(
                        width: 250,
                        child: TextField(
                          autofocus: true,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          cursorColor: Palette.deepBlue,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Palette.white,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Palette.deepBlue)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Palette.deepBlue)),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                          "if you do not receive your OTP within 00:04:53 seconds",
                          style: TextStyle(
                            fontSize: 11,
                          ))
                    ],
                  ))),
          SizedBox(
            height: 40,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Palette.lightBlue,
                  shape: BeveledRectangleBorder()),
              child: const Text(
                'PROCEED',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget dropDownOption(int value, String data, String currency) {
  final number = value.toString();
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
              '$currency($number)',
              style: TextStyle(fontSize: 7.5, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    ),
  );
}

class BottomSheetContent extends StatelessWidget {
  final _otpcontroller = TextEditingController();
  final mobileNumber = 9876543210;

  String formatNumber(String number) {
    List<String> digits = number.split('');
    digits[2] = '*';
    digits[3] = '*';
    digits[6] = '*';
    digits[7] = '*';
    return digits.join();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          child: Column(
            children: [
              Container(
                height: 50,
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          'Verify OTP',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
              Container(
                height: 2,
                color: Colors.red[900],
              ),
              Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Please enter the OTP sent to the registered mobile number ${formatNumber(mobileNumber.toString())}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 0.5 * MediaQuery.of(context).size.width,
                      height: 40,
                      child: TextField(
                        controller: _otpcontroller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                              color: Colors.grey[700]!,
                            ),
                          ),
                        ),
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CountdownTimer(),
                    SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => AppSetupPage2(),
                    //   ),
                    // );
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
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CountdownTimer extends StatefulWidget {
  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _secondsRemaining = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_secondsRemaining == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _secondsRemaining--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'If you do not receive your OTP within $_secondsRemaining seconds',
      style: TextStyle(
        fontSize: 14,
        color: Colors.grey[700],
      ),
    );
  }
}

class Palette {
  static const red = const Color.fromARGB(255, 181, 39, 29);
  static const lightBlue = Color(0xFF5BB5FF);
  static const white = Colors.white;
  static const Color background = Colors.white;
  static const Color lightGrey = Color(0xffB8C7D9);
  static const Color grey = Color.fromARGB(255, 126, 137, 153);
  static const Color navyBlue = Color(0xff0A1016);
  static const Color deepBlue = Color(0xff2E4B5D);
}
