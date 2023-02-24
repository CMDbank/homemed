import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../add_data/blood%20pressure.dart';

import '../../config.dart';

class oxygen_info extends StatefulWidget {
  

  @override
  State<oxygen_info> createState() => _oxygen_infoState();
}

class _oxygen_infoState extends State<oxygen_info> {
  final formkey = GlobalKey<FormState>();
  String? ox;
  bool check = false;
  String url = baseUrl + '/add_oxygen/';

  Future<void> submit(BuildContext context) async {
    int oxinfo = int.parse(ox!);
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("ox", oxinfo);

//     String? idcardNumberpatients = prefs.getString("id_card_Number_patients");
//     String? user = prefs.getString("ID");
//     Map<String, dynamic> body = {
//       'user_id': user,
//       'patient_id': idcardNumberpatients,
//       'oxygen': oxinfo,
//     };
//     String jsonBody = jsonEncode(body);

// // Make the POST request

//     var response = await http.post(Uri.parse(url),
//         headers: {'Content-Type': 'application/json'}, body: jsonBody);

//     print(response.body);
//     if (response.statusCode == 200) {
//       print("Successful Temp is $oxinfo ");

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => bloodPressure_info()));
    // }
    // if (response.statusCode == 201) {
    //   print("Successful Temp is $oxinfo ");

    //   Navigator.push(context,
    //       MaterialPageRoute(builder: (context) => bloodPressure_info()));
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
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      textstyle(
                        text: "กรุณากรอกตัวเลข",
                        fontSize: 15,
                      ),
                      textstyle(
                        text: "ระดับออกซิเจน",
                        fontSize: 15,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 70,
                        width: 130,
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
                                ox = value;
                                check = true;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "%",
                              hintStyle: TextStyle(
                                  fontSize: 30, color: Color(0xFF949494)),
                              focusedErrorBorder: new OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: Color(0xFFEFEFEF), width: 0.0),
                              ),
                              filled: true,
                              fillColor: Color(0xFFEFEFEF),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFEFEFEF), width: 0.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFEFEFEF), width: 0.0),
                                borderRadius: BorderRadius.circular(10),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      check
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
                                  child: textstyle(
                                text: "ยืนยัน",
                                color: Colors.white,
                                fontSize: 20,
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
                height: 220,
                width: 180,
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
