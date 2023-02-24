import 'dart:convert';

import 'package:flutter/material.dart';
import '../add_data/bloodsugar.dart';
import 'package:http/http.dart' as http;
import '../../config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class bloodPressure_info extends StatefulWidget {
  

  @override
  State<bloodPressure_info> createState() => _bloodPressure_infoState();
}

class _bloodPressure_infoState extends State<bloodPressure_info> {
  final formkey = GlobalKey<FormState>();
  String? systolic;
  String? diastolic;
  String? pulse;
  bool check = false;
  bool check1 = false;
  bool check2 = false;
  String url = '$baseUrl/add_bp_hr/';

  Future<void> submit(BuildContext context) async {
    int systolicInfo = int.parse(systolic!);
    int diastolicInfo = int.parse(diastolic!);
    int pulseInfo = int.parse(pulse!);
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("systolic", systolicInfo);
    prefs.setInt("diastolic", diastolicInfo);
    prefs.setInt("pulse", pulseInfo);

//     String? idcardNumberpatients = prefs.getString("id_card_Number_patients");
//     String? user = prefs.getString("ID");
//     Map<String, dynamic> body = {
//       'user_id': user,
//       'patient_id': idcardNumberpatients,
//       'systolic': systolicInfo,
//       'diastolic': diastolicInfo,
//       'pulse': pulseInfo
//     };
//     String jsonBody = jsonEncode(body);

// // Make the POST request

//     var response = await http.post(Uri.parse(url),
//         headers: {'Content-Type': 'application/json'}, body: jsonBody);

//     print(response.body);
//     if (response.statusCode == 200) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => bloodSugar_info()));
    // }
    // if (response.statusCode == 201) {
    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => bloodSugar_info()));
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(115, 117, 115, 115),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                child: Form(
                  key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      textstyle(
                        text: "กรุณากรอกตัวเลข ความดันโลหิต",
                        fontSize: 15,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 40),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textstyle(
                                  text: "SYS",
                                  fontSize: 26,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 129,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        setState(() {
                                          check = false;
                                        });
                                      } else {
                                        setState(() {
                                          systolic = value;
                                          check = true;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: "mmHg",
                                        hintStyle: TextStyle(
                                            fontSize: 26,
                                            color: Color(0xFF949494)),
                                        focusedErrorBorder:
                                            new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color(0xFFEFEFEF),
                                              width: 0.0),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFEFEFEF),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFEFEFEF),
                                              width: 0.0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFEFEFEF),
                                              width: 0.0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textstyle_eng(
                                  text: "DIA",
                                  fontSize: 26,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 129,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        setState(() {
                                          check1 = false;
                                        });
                                      } else {
                                        setState(() {
                                          check1 = true;
                                          diastolic = value;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: "mmHg",
                                        hintStyle: TextStyle(
                                            fontSize: 26,
                                            color: Color(0xFF949494)),
                                        focusedErrorBorder:
                                            new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color(0xFFEFEFEF),
                                              width: 0.0),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFEFEFEF),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFEFEFEF),
                                              width: 0.0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFEFEFEF),
                                              width: 0.0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                textstyle_eng(
                                  text: "PULSE",
                                  fontSize: 26,
                                ),
                                SizedBox(
                                  height: 50,
                                  width: 129,
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        setState(() {
                                          check2 = false;
                                        });
                                      } else {
                                        setState(() {
                                          pulse = value;
                                          check2 = true;
                                        });
                                      }
                                    },
                                    decoration: InputDecoration(
                                        hintText: "/min",
                                        hintStyle: TextStyle(
                                            fontSize: 26,
                                            color: Color(0xFF949494)),
                                        focusedErrorBorder:
                                            new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Color(0xFFEFEFEF),
                                              width: 0.0),
                                        ),
                                        filled: true,
                                        fillColor: Color(0xFFEFEFEF),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFEFEFEF),
                                              width: 0.0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xFFEFEFEF),
                                              width: 0.0),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      check && check1 && check2
                          ? Container(
                              child: Center(
                                  child: SizedBox(
                                height: 60,
                                width: 130,
                                child: TextButton(
                                  onPressed: () {
                                    submit(context);
                                  },
                                  child: textstyle(
                                      text: "ยืนยัน",
                                      color: Colors.white,
                                      fontSize: 20),
                                ),
                              )),
                              height: 60,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: Color(0xFF61D2A4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))))
                          : Container(
                              child: Center(
                                  child: Text(
                                "ยืนยัน",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              )),
                              height: 60,
                              width: 130,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 132, 131, 131),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))))
                    ],
                  ),
                ),
                height: 360,
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 0),
                        spreadRadius: 1,
                        blurRadius: 2)
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                )),
          ],
        ),
      ),
    );
  }
}
