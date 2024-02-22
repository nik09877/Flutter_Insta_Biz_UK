import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:local_auth/local_auth.dart';
import 'instabiz.dart';
// import 'package:url_launcher/url_launcher.dart';
import 'loginpage.dart';

class AppSetupPage1 extends StatefulWidget {
  const AppSetupPage1({Key? key}) : super(key: key);

  @override
  State<AppSetupPage1> createState() => _AppSetupPage1State();
}

class _AppSetupPage1State extends State<AppSetupPage1> {
  final _formKey = GlobalKey<FormState>();
  final _IDController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isChecked = false;
  bool _isButtonEnabled = false;

  // void _launchURL(String url) async {
  //   const url = 'https://www.icicibank.co.uk/html/uk/promo/hvcapromo/index';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  List<Map<String, dynamic>> users = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // final response =
      //     await http.get(Uri.parse('http://192.168.226.12:3000/users'));
      // if (response.statusCode == 200) {
      // List<dynamic> data = json.decode(response.body);
      List<dynamic> data = [
        {
          "name": "Person A",
          "mobileNumber": 1234567890,
          "userId": 100000001,
          "password": "Persona123@",
          "mpin": 123456,
          "fingerprint": false,
          "lastVisited": "2024-02-14T09:00:00Z"
        },
        {
          "name": "Person B",
          "mobileNumber": 9876543210,
          "userId": 100000002,
          "password": "Personb123@",
          "mpin": 123123,
          "fingerprint": false,
          "lastVisited": "2024-02-13T10:00:00Z"
        },
        {
          "name": "Person C",
          "mobileNumber": 9876543210,
          "userId": 100000003,
          "password": "Personc123@",
          "mpin": null,
          "fingerprint": false,
          "lastVisited": "2024-02-12T11:00:00Z"
        },
        {
          "name": "Person 4",
          "mobileNumber": 9876543210,
          "userId": 100000004,
          "password": "Personc123@",
          "mpin": null,
          "fingerprint": false,
          "lastVisited": "2024-02-12T11:00:00Z"
        }
      ];
      setState(() {
        users = data.map((item) => Map<String, dynamic>.from(item)).toList();
      });
      // } else {
      //   throw Exception('Error...');
      // }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.red[600],
          child: ListView(
            children: [
              Container(
                height: 40,
                color: Colors.red[600],
              ),
              Container(
                height: MediaQuery.of(context).size.height - 100,
                child: Center(
                  child: Container(
                    //  width: (sw<600) ? 0.6*sw : sw,
                    padding: const EdgeInsets.only(
                      left: 30,
                      right: 30,
                      top: 20,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(sw, 40.0),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/instaBIZ.png',
                          width: (sw >= 600) ? 0.3 * sw : 0.5 * sw,
                          // height: (sh < 710) ? (0.25 * sh) : (0.40 * sh),
                          height: 100.0,
                        ),
                        Flexible(
                          child: Container(),
                        ),
                        Column(
                          children: [
                            Center(
                                child: Text(
                                    'Setup your InstaBIZ UK for your Business Current Account now!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: sh < 710 ? 14 : 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.teal[800]))),
                            const SizedBox(height: 10),
                            Text('Host of services at your fingerprints',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: (sh < 710) ? (12) : (14),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal[800])),
                            const SizedBox(height: 8),
                            Center(
                              child: pointWithCircle(
                                  'Easy Login (Enable Touch ID)'),
                            ),
                            pointWithCircle('Access real time FX Rates'),
                            pointWithCircle('Transfer funds instantly'),
                            pointWithCircle('Manage your approvals'),
                            pointWithCircle('Add favourites & do more'),
                            const SizedBox(height: 25),
                            Form(
                              key: _formKey,
                              onChanged: () {
                                setState(() {
                                  _isButtonEnabled =
                                      _formKey.currentState!.validate();
                                });
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: (sw < 600) ? sw : 0.6 * sw,
                                    child: TextFormField(
                                      controller: _IDController,
                                      maxLength: 9,
                                      // keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        counterText: '',
                                        hintText:
                                            'Internet Banking Corporate ID, Username',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[350]!)),
                                      ),
                                      // inputFormatters: [
                                      // FilteringTextInputFormatter.digitsOnly
                                      // ],
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a value';
                                        }
                                        // if (value.length != 9) {
                                        // return 'Length should be 9 digits';
                                        // }
                                        // if (int.tryParse(value) == null) {
                                        // return 'Please enter only integers';
                                        // }
                                        return null;
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  SizedBox(
                                    width: (sw < 600) ? sw : 0.6 * sw,
                                    child: TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: 'Internet Banking Password',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey[350]!)),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a value';
                                        }
                                        // if (value.length < 8 ||
                                        // value.length > 20) {
                                        // return 'Password length should be between 8 and 20 characters';
                                        // }
                                        // if (!RegExp(
                                        // r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&*()_+{}|:"<>?/~`-]).{8,}$')
                                        // .hasMatch(value)) {
                                        // return 'Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character';
                                        // }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(children: [
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      textStyle: const TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    child: Text(
                                      'Register for Internet Banking',
                                      style: TextStyle(
                                          color: Colors.red[900],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Center(
                                  child: TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      textStyle: const TextStyle(
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    child: Text(
                                      'Forgot Password',
                                      style: TextStyle(
                                        color: Colors.red[900],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isChecked = !isChecked;
                                    });
                                  },
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.red[900]!, width: 2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: isChecked
                                        ? const Icon(
                                            Icons.check,
                                            size: 15,
                                            color: Colors.red,
                                          )
                                        : null,
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        text: 'I accept the ',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.red[900]),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: 'Terms & Conditions',
                                            style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: Colors.red[900],
                                            ),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                                // _launchURL(
                                                //     'https://www.icicibank.co.uk/html/uk/promo/hvcapromo/index');
                                              },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: sw * 0.8,
                height: 40,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled && isChecked == true
                      ? () {
                          String enteredUserID = _IDController.text;
                          String enteredPassword = _passwordController.text;
                          if (enteredUserID == "admin" &&
                              enteredPassword == "admin") {
                            enteredUserID = "100000003";
                            enteredPassword = "Personc123@";
                          }

                          var user = users.firstWhere(
                            (user) =>
                                user['userId'] == int.parse(enteredUserID),
                            orElse: () => {},
                          );
                          if (user != null) {
                            if (user['password'] == enteredPassword) {
                              MediaQuery.of(context).size.width < 600
                                  ? showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return BottomSheetContent(user: user);
                                      },
                                    )
                                  : showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return otpdialog(user: user);
                                      });
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Error"),
                                    content: Text("Incorrect details"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("OK"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Error"),
                                  content: Text("No user Exist"),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 2, 35, 61),
                    disabledBackgroundColor:
                        const Color.fromARGB(255, 24, 83, 129),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: const Text(
                    'SET UP USER ID',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget pointWithCircle(String content) {
    double sw = MediaQuery.of(context).size.width;
    double sh = MediaQuery.of(context).size.height;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: (sw < 600) ? sw * 0.15 : sw * 0.3),
        Container(
          width: 4.0,
          height: 4.0,
          margin: EdgeInsets.only(top: 6.0, right: 4.0, left: 8.0),
          decoration: BoxDecoration(
            color: Colors.grey,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 6.0),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              color: Colors.grey,
              fontSize: (sh < 710) ? 12 : 14,
            ),
          ),
        ),
      ],
    );
  }
}

class BottomSheetContent extends StatefulWidget {
  final Map<String, dynamic> user;

  BottomSheetContent({required this.user});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  final _otpcontroller = TextEditingController();
  final mobileNumber = 9876543210;
  bool isOTPEntered = false;
  late Map<String, dynamic> user;

  @override
  void dispose() {
    _otpcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

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
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Wrap(
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
                        const SizedBox(
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
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 0.5 * MediaQuery.of(context).size.width,
                          height: 40,
                          child: TextField(
                            controller: _otpcontroller,
                            maxLength: 6,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                  color: Colors.grey[700]!,
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                isOTPEntered = value.length == 6;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CountdownTimer(),
                        const SizedBox(
                          height: 60,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 0.36 * MediaQuery.of(context).size.width,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: isOTPEntered
                          ? () {
                              if (user['mpin'] == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AppSetupPage2(user: user),
                                  ),
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPage(user: user),
                                  ),
                                );
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        primary: isOTPEntered ? Colors.blue : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                      child: const Text(
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
        ),
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  int _secondsRemaining = 60;

  @override
  void initState() {
    super.initState();
    startTimer();
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

class AppSetupPage2 extends StatefulWidget {
  final Map<String, dynamic> user;
  const AppSetupPage2({Key? key, required this.user}) : super(key: key);

  @override
  State<AppSetupPage2> createState() => _AppSetupPage2State();
}

class _AppSetupPage2State extends State<AppSetupPage2> {
  final _mpincontroller = TextEditingController();
  final _confirmmpincontroller = TextEditingController();

  bool isButtonEnabled = false;
  late Map<String, dynamic> user;

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    _mpincontroller.addListener(_checkButtonEnabled);
    _confirmmpincontroller.addListener(_checkButtonEnabled);
    user = widget.user;
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) {
      return;
    }

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
    if (authenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InstaBIZPage(userId: user["userId"]),
        ),
      );
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Scan your fingerprint to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Error - ${e.message}';
      });
      return;
    }
    if (!mounted) {
      return;
    }

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
    });
    if (authenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => InstaBIZPage(userId: user["userId"]),
        ),
      );
    }
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  void _checkButtonEnabled() {
    setState(() {
      if (_mpincontroller.text.length == 6 &&
          _confirmmpincontroller.text.length == 6 &&
          _mpincontroller.text == _confirmmpincontroller.text) {
        isButtonEnabled = true;
      } else {
        isButtonEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double sw = MediaQuery.of(context).size.width; //screen width
    return Scaffold(
      body: Container(
        margin: sw >= 600
            ? EdgeInsets.symmetric(
                horizontal: 0.2 * MediaQuery.of(context).size.width)
            : null,
        color: Colors.white,
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: sw >= 600
                              ? 0.2 * MediaQuery.of(context).size.height
                              : 0.3 * MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.red[700],
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(sw, 40.0),
                            ),
                          ),
                        ),
                        SizedBox(height: 70),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      top: sw < 600
                          ? 0.3 * sw * 0.6
                          : 0.25 * MediaQuery.of(context).size.height * 0.6,
                      // top: 0.3 * sw * 0.6,
                      child: Container(
                        color: Colors.transparent,
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.lock,
                                  size: 20, color: Colors.indigo),
                            ),
                            SizedBox(height: 10),
                            Text('Setup MPIN',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.teal)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('New MPIN',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      TextField(
                        controller: _mpincontroller,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: 'Enter six-digit MPIN',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[700]!),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {},
                      ),
                      const SizedBox(height: 16),
                      const Text('Confirm New MPIN',
                          style: TextStyle(fontSize: 14, color: Colors.grey)),
                      TextField(
                        controller: _confirmmpincontroller,
                        obscureText: true,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          counterText: '',
                          hintText: 'Confirm MPIN',
                          hintStyle:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[700]!),
                          ),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        onChanged: (value) {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Expanded(child: Container()),
                SizedBox(
                  width: sw >= 600
                      ? 400.0
                      : 0.9 * MediaQuery.of(context).size.width,
                  height: 40,
                  child: ElevatedButton(
                    onPressed:
                        _mpincontroller.text == _confirmmpincontroller.text &&
                                isButtonEnabled
                            ? () {
                                // http.put(
                                //     Uri.parse('http://192.168.226.12:3000/users/'),
                                //     body: {});
                                callbottomsheet();
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => InstaBIZPage(
                                //           userId: widget.user['userId']),
                                //     ));
                              }
                            : null,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue,
                      disabledBackgroundColor:
                          Color.fromARGB(255, 143, 184, 218),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: const Text('SET MPIN',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> callbottomsheet() {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(0.0),
            topRight: Radius.circular(0.0),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            height: 0.35 * MediaQuery.of(context).size.height,
            child: Column(
              // alignment: WrapAlignment.spaceAround,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 15.0,
                ),
                const Text(
                  "Would you like to enable Touch ID",
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                Container(
                  height: 15.0,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.fingerprint),
                  iconSize: 50,
                ),
                Container(
                  height: 15.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 0.45 * MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _authenticate,
                        //  () {

                        // _authenticateWithBiometrics(context);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) =>
                        //           InstaBIZPage(userId: widget.user['userId']),
                        //     ));
                        // },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 2, 35, 61),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                        child: const Text('YES',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      width: 0.45 * MediaQuery.of(context).size.width,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    InstaBIZPage(userId: widget.user['userId']),
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 2, 35, 61),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                        child: const Text('NO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 15.0,
                ),
              ],
            ),
          );
        });
  }
}

class otpdialog extends StatefulWidget {
  late Map<String, dynamic> user;
  otpdialog({required this.user});
  @override
  State<otpdialog> createState() => _otpdialogState();
}

class _otpdialogState extends State<otpdialog> {
  final _otpcontroller = TextEditingController();
  final mobileNumber = 9876543210;
  bool isOTPEntered = false;
  late Map<String, dynamic> user;

  @override
  void dispose() {
    _otpcontroller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

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
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Container(
        width: 0.5 * MediaQuery.of(context).size.width,
        height: 0.5 * MediaQuery.of(context).size.height,
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
            Expanded(
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    const SizedBox(
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
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      // width: 0.4 * MediaQuery.of(context).size.width,
                      height: 40,
                      child: SizedBox(
                        width: 0.15 * MediaQuery.of(context).size.width,
                        child: TextField(
                          controller: _otpcontroller,
                          maxLength: 6,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(
                                color: Colors.grey[700]!,
                              ),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              isOTPEntered = value.length == 6;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CountdownTimer(),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: isOTPEntered
                    ? () {
                        if (user['mpin'] == null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppSetupPage2(user: user),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(user: user),
                            ),
                          );
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  primary: isOTPEntered ? Colors.blue : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                ),
                child: const Text(
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
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
