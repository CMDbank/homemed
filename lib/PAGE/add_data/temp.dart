import 'dart:convert';
import 'package:flutter/material.dart';
import '../add_data/oxygen.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';

class Temp_info extends StatefulWidget {


  @override
  State<Temp_info> createState() => _Temp_infoState();
}

class _Temp_infoState extends State<Temp_info> {
  final formkey = GlobalKey<FormState>();
  String url = baseUrl + '/add_Temp/';

  String? temp;
  bool check = false;

  Future<void> submit(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    double tempinfo = double.parse(temp!);
    prefs.setDouble("temp", tempinfo);
    // String? idcardNumberpatients = prefs.getString("id_card_Number_patients");
    // String? user = prefs.getString("ID");
    // Map<String, dynamic> body = {
    //   'user_id': user,
    //   'patient_id': idcardNumberpatients,
    //   'temp': tempinfo,
    // };
    // String jsonBody = jsonEncode(body);

// Make the POST request

    // var response = await http.post(Uri.parse(url),
    //     headers: {'Content-Type': 'application/json'}, body: jsonBody);

    // print(response.body);
    // if (response.statusCode == 200) {
    //   print("Successful Temp is $temp ");

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => oxygen_info()));
    // }
    // if (response.statusCode == 201) {
    //   print("Successful Temp is $temp ");

    //   Navigator.push(
    //       context, MaterialPageRoute(builder: (context) => oxygen_info()));
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
                        text: "กรุณากรอกอุณหภูมิ",
                        fontSize: 15,
                      ),
                      textstyle(
                        text: "ระดับอุณหภูม",
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
                                temp = value;
                                check = true;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "ํC",
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
