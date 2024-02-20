import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class AddPayee extends StatefulWidget {
  const AddPayee({Key? key}) : super(key: key);
  static bool showAlert = true;
  @override
  _AddPayeeState createState() => _AddPayeeState();
}

class _AddPayeeState extends State<AddPayee> {
  final _formKey = GlobalKey<FormState>();

  int radioValue = 1;
  bool showSelect = false;
  final r1f1 = TextEditingController();
  final r1f2 = TextEditingController();
  final r1f3 = TextEditingController();
  final r1f4 = TextEditingController();
  final r1f5 = TextEditingController();
  // String  dropdownValue="";
  final r2f1 = TextEditingController();
  final r2f2 = TextEditingController();
  final r2f3 = TextEditingController();
  final r2f4 = TextEditingController();
  final r2f5 = TextEditingController();
  final r2f6 = TextEditingController();
  final r2f7 = TextEditingController();
  final r2f8 = TextEditingController();
  final r3f9 = TextEditingController();

  final r3f1 = TextEditingController();
  final r3f2 = TextEditingController();
  final r3f3 = TextEditingController();
  final r3f4 = TextEditingController();
  final r3f5 = TextEditingController();
  final r3f6 = TextEditingController();
  final r3f7 = TextEditingController();
  final r3f8 = TextEditingController();
  Map<String, String> dropdownValues = {};
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          Timer(Duration(seconds: 10), () {
            Navigator.of(context).pop();
            setState(() {
              AddPayee.showAlert = false;
            });
          });

          return CartDialog(
              dialogWidth: 0.9 * MediaQuery.of(context).size.width);
        },
      );
    });
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
                icon: Icon(Icons.menu, color: Colors.white), onPressed: () {}),
            Expanded(
              child: Text(
                'Add Payee',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            SizedBox(width: 55),
          ],
        ),
      ),
      body: buildPage(),
    );
  }

  Widget buildPage() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Beneficiary Account',
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                              SizedBox(height: 20),
                              buildradiobuttons(),
                            ]),
                      ),
                    ),
                  ],
                ),
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
              child: Text('ADD BENEFICIARY',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white))),
        ),
      ],
    );
  }

  Widget buildradiobuttons() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _customRadio(' ICICI Bank UK', 1),
      SizedBox(height: 25),
      _customRadio(' Other UK Banks (For Chaps and Same Day Payments)', 2),
      SizedBox(height: 25),
      _customRadio(' Outside UK Banks (For SWIFT based payments)', 3),
      SizedBox(height: 30),
      buildtextfields(),
    ]);
  }

  Widget buildtextfields() {
    if (radioValue == 1) {
      return Column(
        children: [
          _buildUnderlinedTextField(
            controller: r1f1,
            labelText: 'Name',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r1f2,
            labelText: 'Nick Name',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r1f3,
            labelText: 'Account number',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r1f4,
            labelText: 'Re-Enter Account Number',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r1f5,
            labelText: 'Email',
            isMandatory: true,
          ),
          _buildDropdown(
              'Currency', ['Euro', 'Dollar', 'Rupee', 'GBP'], 'dropdown1'),
          _buildDropdown('Branches', ['8956', '8989', '7879'], 'dropdown2'),
        ],
      );
    } else if (radioValue == 2) {
      return Column(
        children: [
          _buildUnderlinedTextField(
            controller: r2f1,
            labelText: 'Name',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r2f2,
            labelText: 'Nick Name',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r2f3,
            labelText: 'Account Number',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r2f4,
            labelText: 'Re-Enter Account Number',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r2f5,
            labelText: 'Phone Number',
            isMandatory: false,
          ),
          _buildUnderlinedTextFieldwithprefix(
            controller: r2f6,
            labelText: 'SORT CODE',
            isMandatory: false,
          ),
          _buildUnderlinedTextField(
            controller: r2f7,
            labelText: 'Bank Name',
            isMandatory: false,
          ),
          _buildUnderlinedTextField(
            controller: r2f8,
            labelText: 'Branch Name',
            isMandatory: false,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUnderlinedTextField(
            controller: r3f1,
            labelText: 'Name',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r3f2,
            labelText: 'Nick Name',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r3f3,
            labelText: 'Account Number/IBAN Number',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r3f4,
            labelText: 'Re-Enter Account Number/IBAN Number',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r3f5,
            labelText: 'Email',
            isMandatory: true,
          ),
          _buildUnderlinedTextFieldwithprefix(
            controller: r3f6,
            labelText: 'SWIFT/IFSC CODE',
            isMandatory: true,
          ),
          _buildUnderlinedTextField(
            controller: r3f7,
            labelText: 'Bank Name',
            isMandatory: false,
          ),
          _buildUnderlinedTextField(
            controller: r3f8,
            labelText: 'Branch Name',
            isMandatory: false,
          ),
          Text('Currency', style: TextStyle(color: Colors.grey, fontSize: 12)),
          _buildDropdown(
              'Currency', ['Euro', 'Dollar', 'Rupee', 'GBP'], 'dropdown3',
              showSelect: true),
          SizedBox(height: 8),
          Text('Beneficiary Address',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue)),
          _buildUnderlinedTextField(
            controller: r3f9,
            labelText: 'Address',
            isMandatory: true,
          ),
          _buildDropdown(
              'Country', ['UK', 'Canada', 'USA', 'India'], 'dropdown4'),
        ],
      );
    }
  }

  Widget _buildUnderlinedTextFieldwithprefix({
    required TextEditingController controller,
    required String labelText,
    required bool isMandatory,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        labelText: labelText,
        //suffixText:isMandatory ? '*':'',
        // suffixStyle:TextStyle(color:Colors.red),
        suffixIcon: Visibility(
          visible: true,
          child: Container(
              height: 30,
              width: 150,
              //padding:EdgeInsets.symmetric(horizontal:15,vertical: 4 ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search, color: Colors.blue, size: 14)),
                    SizedBox(width: 0),
                    Text(
                      'Look Up',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
        ),
        labelStyle: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      /* validator: (value) {
        if (isMandatory && value!.isEmpty) {
          return '$labelText is required';
        }
        return null;
      },*/
      onChanged: (value) {},
    );
  }

  Widget _buildDropdown(
      String labelText, List<String> dropdownItems, String dropdownkey,
      {bool showSelect = false}) {
    // String? dropdownValue=showSelect? 'Select Currency':dropdownItems.firstOrNull;
    return DropdownButtonFormField<String>(
      key: Key(dropdownkey),
      value: dropdownValues[dropdownkey],
      onChanged: (value) {
        setState(() {
          dropdownValues[dropdownkey] = value!;
        });
      },
      items: dropdownItems.map((item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item, style: TextStyle(color: Colors.grey, fontSize: 12)),
        );
      }).toList(),
      hint: Text(showSelect ? "Select Currency" : labelText,
          style: TextStyle(color: Colors.grey, fontSize: 12)),
      decoration: InputDecoration(
        // labelText: showSelect ? "currency":"",
        //labelStyle: TextStyle(color: Colors.grey,fontSize:12),
        //contentPadding:showSelect ? EdgeInsets.only(bottom:10):EdgeInsets.only(bottom:0),
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

  Widget _buildUnderlinedTextField({
    required TextEditingController controller,
    required String labelText,
    required bool isMandatory,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        labelText: labelText,
        //suffixText:isMandatory ? '*':'',
        // suffixStyle:TextStyle(color:Colors.red),
        // prefix: isMandatory
        //     ? Text(
        //         ' *',
        //         style: TextStyle(fontSize: 12, color: Colors.red),
        //       )
        //     : null,
        labelStyle: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      /* validator: (value) {
        if (isMandatory && value!.isEmpty) {
          return '$labelText is required';
        }
        return null;
      },*/
      onChanged: (value) {},
    );
  }

  Widget _customRadio(String label, int value) {
    return InkWell(
      onTap: () {
        setState(() {
          radioValue = value;
        });
      },
      child: Container(
          child: Row(
        children: [
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
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      )),
    );
  }
}

class CartDialog extends StatefulWidget {
  final double dialogWidth;

  CartDialog({required this.dialogWidth});

  @override
  _CartDialogState createState() => _CartDialogState();
}

class _CartDialogState extends State<CartDialog> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0.0),
      ),
      child: Container(
        //  width: widget.dialogWidth,
        width: 0.9 * MediaQuery.of(context).size.width,
        height: 0.5 * MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                color: Colors.grey[200],
                height: 60,
                child: Center(
                  child: Text(
                    'Fraud Alert',
                    style: TextStyle(
                      color: Colors.red[600],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
                // padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),

                ),
            Container(height: 2, color: Colors.red[600]),
            Text(
              "Don't fall victim to a scam. Criminals pretended to be people you trust, like a company you'd pay bills to. ICICI or even the police.",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            Text(
              "ICICI UK PLC will never ask you to move money, but criminals will.",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            RichText(
              text: TextSpan(
                text: 'For more information please visit ',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                children: <TextSpan>[
                  TextSpan(
                    text: 'https://icicibank.co.uk',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.teal,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
            ),
            Expanded(child: Container()),
            SizedBox(
              height: 40,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    AddPayee.showAlert = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 2, 35, 61),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                ),
                child: Text('OK',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
