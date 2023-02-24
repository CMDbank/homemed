import 'pincon.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

import '../main.dart';

import '../config.dart';

class pinchange extends StatefulWidget {
  
  @override
  @override
  // ignore: no_logic_in_create_state
  State<pinchange> createState() => _pinchangeState();
}

// ignore: camel_case_types
class _pinchangeState extends State<pinchange> {
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
    print(sessionToken);
    if (sessionToken == null) {
      // The user is not logged in, navigate to the login page
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => InputLogin()));
    }
  }

  var selectedindex = 0;
  String? ids;
  String? codes;

  String pin = '';
  String pinF = '';
  String pinL = '';
  bool pas = true;

  String url = baseUrl + '/create_pin/';

  Future<void> submit(BuildContext context) async {
    final SharedPreferences sheredPreferences =
        await SharedPreferences.getInstance();
    sheredPreferences.setString('pin', pin);

    Navigator.push(context, MaterialPageRoute(builder: (context) => pincon()));
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      color: Colors.black26.withBlue(40),
    );

    return Scaffold(
      body: SingleChildScrollView(
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
                          code: pin,
                          check: check,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DigitHolder(
                            width: width,
                            index: 1,
                            selectedIndex: selectedindex,
                            code: pin,
                            check: check),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DigitHolder(
                            width: width,
                            index: 2,
                            selectedIndex: selectedindex,
                            code: pin,
                            check: check),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DigitHolder(
                          width: width,
                          index: 3,
                          selectedIndex: selectedindex,
                          code: pin,
                          check: check,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DigitHolder(
                            width: width,
                            index: 4,
                            selectedIndex: selectedindex,
                            code: pin,
                            check: check),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DigitHolder(
                            width: width,
                            index: 5,
                            selectedIndex: selectedindex,
                            code: pin,
                            check: check),
                      ),
                    ],
                  ),
                  SizedBox(
                    child: check
                        ? Text("")
                        : SizedBox(
                            child: textstyle(
                                text: " ไม่ถูกต้อง",
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: 60,
                          child: ButtonTheme(child: SizedBox()),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: Buttonfiled(
                            child: TextButton(
                                onPressed: () {
                                  addDigit(0);
                                },
                                child: Text('0', style: textStyle)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                            onPressed: () {
                              backspace();
                            },
                            child: Icon(Icons.backspace_outlined,
                                color: Colors.black26, size: 30)),
                      ),
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
      if (pin.length < 6) {
        pin = pin + digit.toString();

        selectedindex = pin.length;
        if (pin.length == 6) {
          submit(context);
        }
      }
    });
  }

  backspace() {
    if (pin.length == 0) {
      return;
    }
    setState(() {
      pin = pin.substring(0, pin.length - 1);
      selectedindex = pin.length;
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
      width: size.width * 0.2,
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
