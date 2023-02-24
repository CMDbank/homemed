import 'dart:io';

import 'package:flutter/material.dart';
import '../add_data/blood%20pressure.dart';
import '../add_data/success.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../add_data/sucessgul_P.dart';
import '../../config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class bloodSugar_info extends StatefulWidget {
  

  @override
  State<bloodSugar_info> createState() => _bloodSugar_infoState();
}

class _bloodSugar_infoState extends State<bloodSugar_info> {
  final formkey = GlobalKey<FormState>();
  String? glucos;
  bool check = false;
  String url = baseUrl + '/multirecord/';

  Future<void> _uploadPhoto() async {
    final prefs = await SharedPreferences.getInstance();
    String? image = prefs.getString("image");
    String? idcardNumberpatients = prefs.getString("id_card_Number_patients");
    String? fullName = prefs.getString("full_name");
    String? birthdate = prefs.getString("birthdate");
    String? expiredate = prefs.getString("expiredate");
    String? HNNumber = prefs.getString("HN_number");
    String? user = prefs.getString("ID");
    double? temp = prefs.getDouble("temp");
    int? ox = prefs.getInt("ox");
    int? systolic = prefs.getInt("systolic");
    int? diastolic = prefs.getInt("diastolic");
    int? pulse = prefs.getInt("pulse");
    bool? symptom_cough = prefs.getBool("symptom_tightness");
    bool? symptom_tightness = prefs.getBool("symptom_tightness");
    bool? symptom_tired = prefs.getBool("symptom_tired");
    bool? symptom_loss_smellandtaste =
        prefs.getBool("symptom_loss_smellandtaste");
    bool? symptom_body_aches = prefs.getBool("symptom_body_aches");
    bool? symptom_red_patches = prefs.getBool("symptom_red_patches");
    String? symptom_etc = prefs.getString("symptom_etc");
    int glucosinfo = int.parse(glucos!);
    if (prefs.getString("id_card_Number_patients") == null) {
      Map<String, dynamic> body = {
        "user_id": user,
        "patient_id": idcardNumberpatients,
        "symptom_data": {
          "symptom_cough": symptom_cough,
          "symptom_tightness": symptom_tightness,
          "symptom_tired": symptom_tired,
          "symptom_loss_smellandtaste": symptom_loss_smellandtaste,
          "symptom_body_aches": symptom_body_aches,
          "symptom_red_patches": symptom_red_patches,
          "symptom_etc": symptom_etc
        },
        "temp_data": {"temperature": temp},
        "oxygen_data": {"oxygen": ox},
        "bloodpressure_data": {
          "systolic": systolic,
          "diastolic": diastolic,
          "pulse": pulse
        },
        "glucos_data": {"glucos": glucosinfo}
      };

      String jsonBody = jsonEncode(body);

// Make the POST request

      var responseData = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json'}, body: jsonBody);

      print(responseData.body);
      if (responseData.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => successful()));
        setState(() {
          idcardNumberpatients = null;
        });
      }
      if (responseData.statusCode == 201) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => successful()));
        setState(() {
          idcardNumberpatients = null;
        });
      }
    } else {
      var request =
          http.MultipartRequest('POST', Uri.parse(baseUrl + '/add_patient/'));
      var multipartFile = await http.MultipartFile.fromPath('image', image!);
      request.files.add(multipartFile);
      request.fields['user'] = user!;
      request.fields['id_card_number'] = idcardNumberpatients!;
      request.fields['full_name'] = fullName!;
      request.fields['birthdate'] = birthdate!;
      request.fields['expiredate'] = expiredate!;
      request.fields['HN_number'] = HNNumber!;

      var response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.statusCode);

        Map<String, dynamic> body = {
          "user_id": user,
          "patient_id": idcardNumberpatients,
          "symptom_data": {
            "symptom_cough": symptom_cough,
            "symptom_tightness": symptom_tightness,
            "symptom_tired": symptom_tired,
            "symptom_loss_smellandtaste": symptom_loss_smellandtaste,
            "symptom_body_aches": symptom_body_aches,
            "symptom_red_patches": symptom_red_patches,
            "symptom_etc": symptom_etc
          },
          "temp_data": {"temperature": temp},
          "oxygen_data": {"oxygen": ox},
          "bloodpressure_data": {
            "systolic": systolic,
            "diastolic": diastolic,
            "pulse": pulse
          },
          "glucos_data": {"glucos": glucosinfo}
        };

        String jsonBody = jsonEncode(body);

// Make the POST request

        var responseData = await http.post(Uri.parse(url),
            headers: {'Content-Type': 'application/json'}, body: jsonBody);

        print(responseData.body);
        if (responseData.statusCode == 200) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => successful()));
        }
        if (responseData.statusCode == 201) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => successful()));
        }
      }
    }
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
                        text: "ระดับน้ำตาลในเลือด",
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
                                check = true;
                                glucos = value;
                              });
                            }
                          },
                          decoration: InputDecoration(
                              hintText: "mg/dl",
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
                                    _uploadPhoto();
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
                                      fontSize: 20)),
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
