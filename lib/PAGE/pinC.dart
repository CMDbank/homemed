import 'menuNew.dart';
import 'pinchange.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../main.dart';

import 'package:http/http.dart' as http;

import '../config.dart';

class pinC extends StatefulWidget {
  @override
  // ignore: no_logic_in_create_state
  State<pinC> createState() => _pinState();
}

// ignore: camel_case_types
class _pinState extends State<pinC> {
  String? sessionTokens;
  late int code_api;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  bool check = true;

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? sessionToken = prefs.getString("ID");
    setState(() {
      sessionTokens = sessionToken;
    });
    print(sessionToken);
    if (sessionToken == null) {
      // The user is not logged in, navigate to the login page
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          settings: RouteSettings(name: "/InputLogin"),
          builder: (context) => InputLogin(),
        ),
      );
    }
  }

  var selectedindex = 0;
  String? ids;
  String? codes;

  String code = '';
  bool pas = true;
  String true_code = '000000';
  String url = baseUrl + '/pwcheck/';

  Future<void> submit(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    String? sessionToken = prefs.getString("ID");

    print("รหัส $sessionToken ");
    var response = await http.post(Uri.parse(url),
        body: {'id_card_number': sessionToken, 'pin': code});

    print(response.body);
    setState(() {
      code_api = response.statusCode;
    });

    if (response.statusCode == 200) {
      print("Successful login ");
      print("Successful login ");
      check = true;

      Navigator.of(context).push(
        MaterialPageRoute(
          settings: RouteSettings(name: "/menuNew"),
          builder: (context) => pinchange(),
        ),
      );

      setState(() {
        code = "";
        selectedindex = code.length;
      });
    } else {
      setState(() {
        setState(() {
          code = "";
          selectedindex = code.length;
          check = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black26.withBlue(40),
    );

    return Scaffold(
      body: sessionTokens == null
          ? Center(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 22.0),
                      child: SizedBox(
                          height: 350,
                          child: Image.asset("assets/loadingscreen.png")),
                    ),
                    textstyle_eng(
                      text: "HomeMed+",
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 70),
                        textstyle(
                          text: "ระบุรหัส PIN 6 หลัก",
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: DigitHolder(
                                width: width,
                                index: 0,
                                selectedIndex: selectedindex,
                                code: code,
                                check: check,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DigitHolder(
                                  width: width,
                                  index: 1,
                                  selectedIndex: selectedindex,
                                  code: code,
                                  check: check),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DigitHolder(
                                  width: width,
                                  index: 2,
                                  selectedIndex: selectedindex,
                                  code: code,
                                  check: check),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DigitHolder(
                                width: width,
                                index: 3,
                                selectedIndex: selectedindex,
                                code: code,
                                check: check,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DigitHolder(
                                  width: width,
                                  index: 4,
                                  selectedIndex: selectedindex,
                                  code: code,
                                  check: check),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DigitHolder(
                                  width: width,
                                  index: 5,
                                  selectedIndex: selectedindex,
                                  code: code,
                                  check: check),
                            ),
                          ],
                        ),
                        SizedBox(
                          child: check
                              ? Text("")
                              : SizedBox(
                                  child: textstyle(
                                      text: "รหัสผ่านไม่ถูกต้อง",
                                      fontSize: 15,
                                      color: Colors.red),
                                ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 60,
                              child: Buttonfiled(
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(1);
                                    },
                                    child: Text('1', style: textStyle)),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: Buttonfiled(
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(2);
                                    },
                                    child: Text('2', style: textStyle)),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: Buttonfiled(
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(3);
                                    },
                                    child: Text('3', style: textStyle)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 60,
                              child: Buttonfiled(
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(4);
                                    },
                                    child: Text('4', style: textStyle)),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: Buttonfiled(
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(5);
                                    },
                                    child: Text('5', style: textStyle)),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: Buttonfiled(
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(6);
                                    },
                                    child: Text('6', style: textStyle)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 60,
                              child: Buttonfiled(
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(7);
                                    },
                                    child: Text('7', style: textStyle)),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              child: Buttonfiled(
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(8);
                                    },
                                    child: Text('8', style: textStyle)),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: Buttonfiled(
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(9);
                                    },
                                    child: Text('9', style: textStyle)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonTheme(
                                child: SizedBox(
                              width: 60,
                            )),
                            SizedBox(
                              height: 60,
                              width: 60,
                              child: Buttonfiled(
                                child: TextButton(
                                    onPressed: () {
                                      addDigit(0);
                                    },
                                    child: Text('0', style: textStyle)),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  backspace();
                                },
                                child: Icon(Icons.backspace_outlined,
                                    color: Colors.black26, size: 30)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  // ignore: non_constant_identifier_names
  addDigit(int digit) {
    setState(() {
      if (code.length < 6) {
        code = code + digit.toString();

        selectedindex = code.length;
        if (code.length == 6) {
          submit(context);
        }
      }
    });
  }

  backspace() {
    if (code.isEmpty) {
      return;
    }
    setState(() {
      code = code.substring(0, code.length - 1);
      selectedindex = code.length;
    });
  }
}

// ignore: camel_case_types

class DigitHolder extends StatelessWidget {
  final int selectedIndex;
  final int index;
  final String code;
  final bool check;
  const DigitHolder({
    required this.selectedIndex,
    Key? key,
    required this.width,
    required this.index,
    required this.code,
    required this.check,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: width * 0.1,
      width: width * 0.1,
      decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: check
                  ? index == selectedIndex
                      ? Color(0xFF61D2A4)
                      : Colors.black26
                  : Colors.red,
              spreadRadius: 1,
            )
          ]),
      child: code.length > index
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Color(0xFF61D2A4),
                shape: BoxShape.circle,
              ),
            )
          : Container(),
    );
  }
}

class Buttonfiled extends StatelessWidget {
  final child;
  const Buttonfiled({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: child,
      height: size.height * 0.1,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 0),
              spreadRadius: 1,
            )
          ]),
    );
  }
}
