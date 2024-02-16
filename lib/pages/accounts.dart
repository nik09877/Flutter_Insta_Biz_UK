import 'package:flutter/material.dart';
import 'ministatement.dart';
import 'package:intl/intl.dart';
import 'accounts2.dart';

class AccountsPage extends StatefulWidget {
  final int userId;
  const AccountsPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<AccountsPage> createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  bool _radioSelected = false;
  bool _radioSelected1 = false;

  late DateTime selectedDate;
  TextEditingController dateController = TextEditingController();
  late DateTime selectedDate1;
  TextEditingController dateController1 = TextEditingController();
  String? monthSelected;
  final _formKey = GlobalKey<FormState>();

  bool _isFormValid() {
    return _radioSelected &&
        _radioSelected1 &&
        dateController.text.isNotEmpty &&
        dateController1.text.isNotEmpty &&
        monthSelected != null;
  }

  Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      controller.text = DateFormat('dd/MM/yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 179, 14, 14),
          title: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
                color: Colors.white,
              ),
              const Expanded(
                child: Center(
                  child: Text(
                    "Accounts",
                    style: TextStyle(color: Colors.white, fontSize: 12.0),
                  ),
                ),
              ),
            ],
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Column(
                    children: [
                      Text(
                        "Account Name",
                        style: TextStyle(
                            color: Color.fromARGB(255, 17, 90, 150),
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "LOUIWOLPUKLIMIPAQ",
                        style: TextStyle(
                            color: Color.fromARGB(255, 17, 90, 150),
                            fontSize: 9.0),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    height: 39.0,
                    width: 1.0,
                    color: const Color.fromARGB(255, 166, 161, 161),
                  ),
                  const Column(
                    children: [
                      Text(
                        "Account Number",
                        style: TextStyle(
                            color: Color.fromARGB(255, 17, 90, 150),
                            fontSize: 11.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "75734188",
                        style: TextStyle(
                            color: Color.fromARGB(255, 17, 90, 150),
                            fontSize: 9.0),
                      ),
                    ],
                  ),
                ],
              ),
              DefaultTabController(
                length: 2,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 179, 14, 14),
                          width: 1.5,
                        ),
                      ),
                      child: const TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: Color.fromARGB(255, 179, 14, 14),
                        indicator: BoxDecoration(
                          color: Color.fromARGB(255, 179, 14, 14),
                        ),
                        indicatorSize: TabBarIndicatorSize.tab,
                        tabs: [
                          Tab(
                            text: "Mini Statement",
                          ),
                          Tab(
                            text: "Detailed Statement",
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 0.84 * MediaQuery.of(context).size.height,
                      child: TabBarView(
                        children: [
                          MiniStatementPage(userId: widget.userId),
                          Form(
                            key: _formKey,
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7.0),
                              // width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 3.0,
                                      ),
                                      Radio(
                                        value: true,
                                        groupValue: _radioSelected,
                                        onChanged: (value) {
                                          setState(() {
                                            _radioSelected = value as bool;
                                          });
                                        },
                                        activeColor: const Color.fromARGB(
                                            255, 179, 14, 14),
                                      ),
                                      const Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Select the statement period',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 163, 156, 156),
                                              fontSize: 11.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            '(To date cannot be more than 31 days from From date.)',
                                            style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 163, 156, 156),
                                              fontSize: 9.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: 0.4 *
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        child: TextField(
                                          controller: dateController,
                                          decoration: InputDecoration(
                                            labelText: 'From Date',
                                            labelStyle: const TextStyle(
                                                color: Colors.grey),
                                            border: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () => _selectDate(
                                                  context, dateController),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child:
                                                    Icon(Icons.calendar_today),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: 0.4 *
                                            MediaQuery.of(context).size.width,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 3.0),
                                        child: TextField(
                                          controller: dateController1,
                                          decoration: InputDecoration(
                                            labelText: 'To Date',
                                            labelStyle: const TextStyle(
                                                color: Colors.grey),
                                            border: const UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey),
                                            ),
                                            suffixIcon: GestureDetector(
                                              onTap: () => _selectDate(
                                                  context, dateController1),
                                              child: const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child:
                                                    Icon(Icons.calendar_today),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        width: 3.0,
                                      ),
                                      Radio(
                                        value: true,
                                        groupValue: _radioSelected1,
                                        onChanged: (value) {
                                          setState(() {
                                            _radioSelected1 = value as bool;
                                          });
                                        },
                                        activeColor: const Color.fromARGB(
                                            255, 179, 14, 14),
                                      ),
                                      const Text(
                                        'Download month wise',
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 163, 156, 156),
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4.0,
                                  ),
                                  Container(
                                    width:
                                        0.8 * MediaQuery.of(context).size.width,
                                    child: DropdownButtonFormField<String>(
                                      decoration: const InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 200, 188, 188)),
                                        ),
                                        hintText: "Choose month",
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 200, 188, 188),
                                          fontSize: 10.0,
                                        ),
                                      ),
                                      value: monthSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          monthSelected = value;
                                        });
                                      },
                                      items: <String>[
                                        '00',
                                        '01',
                                        '02',
                                        '03',
                                        '04',
                                        '05',
                                        '06',
                                        '07',
                                        '08',
                                        '09',
                                        '10',
                                        '11',
                                        '12'
                                      ].map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Expanded(
                                      child: SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                  )),
                                  SizedBox(
                                    width:
                                        0.9 * MediaQuery.of(context).size.width,
                                    child: ElevatedButton(
                                      // onPressed: _isFormValid() ? () {

                                      // } : null,
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: ((context) =>
                                                    const AccountsPage2())));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color.fromARGB(
                                            255, 2, 35, 61),
                                        disabledBackgroundColor:
                                            const Color.fromARGB(
                                                255, 24, 83, 129),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                        ),
                                      ),
                                      child: const Text(
                                        'DOWNLOAD',
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // drawer: Drawer(
      //   backgroundColor: Colors.white,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       ListTile(
      //         title: const Text('Accounts'),
      //         onTap: () {
      //           Navigator.pop(context);
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
