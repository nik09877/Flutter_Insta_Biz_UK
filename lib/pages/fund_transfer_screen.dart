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
            ? Column(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('From',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                    SizedBox(height: 25),
                                    Text('Current Account',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                    // builddropdown("Account Number", ['75617697','76261111','76260962','76260961','76260960','76261108','76261086','76261113'], 'dropdownkey1'),
                                    Container(
                                      width: 0.95 *
                                          MediaQuery.of(context).size.width,
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
                                                    acc.accountNumber == accNo);
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
                                                  width: 0.7 *
                                                      MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                  child: Text(
                                                    value,
                                                    style:
                                                        TextStyle(fontSize: 12),
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
                                            fontSize: 12, color: Colors.grey)),
                                    SizedBox(height: 20),
                                    DropdownButtonFormField<String>(
                                      key: Key('dropdownKey4'),
                                      value: dropdownValues['dropdownkey4'],
                                      onChanged: (value) {
                                        setState(() {
                                          dropdownValues['dropdownkey4'] =
                                              value!;
                                          isPayeeSelected = !isPayeeSelected;
                                        });
                                      },
                                      hint: Text('Select Payee',
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 139, 135, 135),
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
                                                  decoration:
                                                      TextDecoration.underline,
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
                                          TextFormField(
                                            controller: amountValue,
                                            decoration: const InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 174, 164, 164)),
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
                                                  FloatingLabelBehavior.always,
                                            ),
                                            onChanged: (value) {},
                                          ),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          Text('Remarks',
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.grey)),
                                          builddropdown(
                                              "Remarks",
                                              [
                                                'option 1',
                                                'option 2',
                                                'option 3'
                                              ],
                                              'dropdownkey3'),
                                          SizedBox(
                                            height: 5.0,
                                          ),
                                          TextFormField(
                                            controller: remarks,
                                            decoration: const InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 174, 164, 164)),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.red),
                                              ),
                                              hintText: 'Please enter remarks',
                                              hintStyle: TextStyle(
                                                fontSize: 10,
                                                color: Color.fromARGB(
                                                    255, 174, 164, 164),
                                              ),
                                              floatingLabelBehavior:
                                                  FloatingLabelBehavior.always,
                                            ),
                                            onChanged: (value) {},
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
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        child: Text('PROCEED',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white))),
                  ),
                ],
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
