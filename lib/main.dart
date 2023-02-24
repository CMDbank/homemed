import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jitsi_meet_wrapper_example/chart/oxygenChart.dart';

import 'PAGE/pin.dart';
import 'PAGE/pincreate.dart';
import 'PAGE/manupage/other.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pdf/pdf.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'config.dart';
import 'jitsi.dart';

void main() {
  runApp(const MaterialApp(
    home: pin(),
  ));
  Intl.defaultLocale = "th";
  initializeDateFormatting();
}

class InputLogin extends StatefulWidget {
  @override
  State<InputLogin> createState() => InputLoginState();
}

class InputLoginState extends State<InputLogin> with WidgetsBindingObserver {
  var id_card;
  var id_card_numberController = TextEditingController();
  var phone_numberController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final url = baseUrl + "/login/";
  bool onError_ID = true;
  bool onError_P = true;
  bool isLoading = true;
  String onErrorID = "";
  String onErrorP = "";
  String test = "Please create a PIN";

  var _postsJosn = [];
//โหลด data api
  Future<void> login(BuildContext context) async {
    if (id_card_numberController.text.isNotEmpty &&
        phone_numberController.text.isNotEmpty) {
      var response = await http.post(Uri.parse(url), body: {
        'id_card_number': id_card_numberController.text,
        'phone_number': phone_numberController.text,
      });
      print(response.body);
      Map<String, dynamic> json1 = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Successful login ");
        print(json1['message']);
        //เซ็ต ค่า user ลงใน SharedPreferences
        final SharedPreferences sheredPreferences =
            await SharedPreferences.getInstance();
        sheredPreferences.setString('ID', id_card);
        sheredPreferences.setString('phone', phone_numberController.text);
        sheredPreferences.setString('pincheck', json1['message']);
        if (json1['message'] == "Please create a PIN") {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              settings: RouteSettings(name: "/pincreate"),
              builder: (context) => pincreate(),
            ),
          );
        } else {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              settings: RouteSettings(name: "/pin"),
              builder: (context) => pin(),
            ),
          );
        }
      }
      // ignore: unused_local_variable

      if (response.statusCode == 400) {
        print('error');
      }
      if (response.statusCode == 500) {
        print('error code 500');
      }
    }
  }

  @override
  String phone_no = "";

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return false;
        },
        child: Scaffold(
            body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF61D2A4),
              Color(0xFF31C98B),
            ],
          )),
          child: SingleChildScrollView(
            child: Center(
                child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    child:
                        Image.asset('assets/logo-social-removebg-preview.png'),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: textstyle_eng(
                      text: "HOMEMED+",
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 30),
                        child: Column(
                          children: [
                            buildInput1(),
                            SizedBox(
                              height: 20,
                            ),
                            Buttonfiled(
                              child: buildButton(),
                            )
                          ],
                        ),
                      ),
                      height: 405,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ))),
                ],
              ),
            )),
          ),
        )));
  }

  Widget buildInput1() {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: textstyle(
                text: "เลขบัตรประชาชน",
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
                controller: id_card_numberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      onErrorID = "1";
                      onError_ID = false;
                    });
                    return null;
                  }
                  if (value.length < 13) {
                    setState(() {
                      onErrorID = "2";
                      onError_ID = false;
                    });
                    return null;
                  }
                  setState(() {
                    onError_ID = true;
                  });

                  return null;
                },
                decoration: InputDecoration(
                    focusedErrorBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(
                          color: onError_ID ? Colors.white : Colors.red,
                          width: 0.0),
                    ),
                    filled: true,
                    fillColor: Color(0xFFEFEFEF),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: onError_ID ? Colors.white : Colors.white,
                          width: 0.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: onError_ID ? Colors.white : Colors.red,
                          width: 0.0),
                      borderRadius: BorderRadius.circular(10),
                    )),
                cursorColor: const Color(0xCC61D2A4),
                // ignore: non_constant_identifier_names
                onSaved: (IdCard) {
                  id_card = IdCard;
                },
                keyboardType: TextInputType.number),
          ),
          SizedBox(
            height: 10,
          ),
          onError_ID
              ? Container()
              : onErrorID == "1"
                  ? textstyle(
                      text: "กรุณากรอกรหัสบัตรประชาชน",
                      color: Colors.red,
                      fontSize: 15,
                    )
                  : textstyle(
                      text: "กรอกรหัสบัตรประชาชนผิด",
                      color: Colors.red,
                      fontSize: 15,
                    ),
          const SizedBox(
            height: 10,
          ),
          Center(
            child: textstyle(
                text: "หมายเลขโทรศัพท์",
                fontWeight: FontWeight.w400,
                fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 50,
            child: TextFormField(
                controller: phone_numberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      onErrorP = "1";
                      onError_P = false;
                    });
                    return null;
                  }
                  if (value.length < 10) {
                    setState(() {
                      onErrorP = "2";
                      onError_P = false;
                    });
                    return null;
                  }
                  setState(() {
                    onError_P = true;
                  });

                  return null;
                },
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFEFEFEF),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: onError_P ? Colors.white : Colors.white,
                          width: 0.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: onError_P ? Colors.white : Colors.red,
                          width: 0.0),
                      borderRadius: BorderRadius.circular(10),
                    )),
                cursorColor: const Color(0xCC61D2A4),
                keyboardType: TextInputType.number),
          ),
          SizedBox(
            height: 10,
          ),
          onError_P
              ? Container()
              : onErrorP == "1"
                  ? textstyle(
                      text: "กรุณากรอกเบอร์โทรศัพท์",
                      color: Colors.red,
                      fontSize: 15,
                    )
                  : textstyle(
                      text: "กรอกเบอร์โทรศัพท์ผิด",
                      color: Colors.red,
                      fontSize: 15,
                    ),
        ],
      ),
    );
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    textStyle: const TextStyle(fontSize: 20),
    foregroundColor: Colors.white,
    backgroundColor: const Color(0xFF61D2A4),
    minimumSize: const Size(300, 50),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(30.0)),
    ),
  );
  Widget buildButton() {
    return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 20),
        ),
        onPressed: () {
          if (formkey.currentState!.validate()) {
            formkey.currentState!.save();
            login(context);
          }

          // if all are valid then go to success screen
          // Navigator.pushReplacementNamed(
          // context, LoginSuccessScreen.routeName);
        },
        child: textstyle(
          text: 'ลงชื่อเข้าใช้',
          fontSize: 20,
          color: Colors.white,
        ));
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
      height: 50,
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF61D2A4),
            Color(0xFF31C98B),
          ],
        ),
      ),
    );
  }
}

// 58mm width receipt
const width = 2.28346457 * PdfPageFormat.inch;
const height = 300.0 * PdfPageFormat.mm;
const pageFormat = PdfPageFormat(width, height);
