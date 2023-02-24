import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../add_data/addinfo.dart';
import '../add_data/capture_person.dart';
import '../../config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Info extends StatefulWidget {
  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  bool checkname = true;
  bool checkid_card = true;
  bool checkbirthdate = true;
  bool checkexpiredate = true;
  bool checkHN = true;
  TextEditingController dateinput = TextEditingController();
  TextEditingController enddateinput = TextEditingController();
  String id_card_Number = "";
  String full_name = "";
  String birthdate = "";
  String expiredate = "";
  String HN_number = "";

  saveData() async {
    //save data to local storage
    if (full_name.contains(" ") &&
        id_card_Number.length == 13 &&
        birthdate != "" &&
        expiredate != "" &&
        HN_number != "") {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("id_card_Number_patients", id_card_Number);
      prefs.setString("full_name", full_name);
      prefs.setString("birthdate", birthdate);
      prefs.setString("expiredate", expiredate);
      prefs.setString("HN_number", HN_number);
      print(birthdate);
      print(birthdate.runtimeType);
      print(expiredate);
      print(expiredate.runtimeType);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Cap_person()));
    }
    if (!full_name.contains(" ")) {
      checkname = false;
    } else {
      checkname = true;
    }
    if (id_card_Number.length != 13) {
      checkid_card = false;
    } else {
      checkid_card = true;
    }
    if (birthdate == "") {
      checkbirthdate = false;
    } else {
      checkbirthdate = true;
    }
    if (expiredate == "") {
      checkexpiredate = false;
    } else {
      checkexpiredate = true;
    }
    if (HN_number == "") {
      checkHN = false;
    } else {
      checkHN = true;
    }
  }

  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100.0, left: 30, right: 20, bottom: 20),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "ยืนยันข้อมูลบัตรประชาชน",
                    style: GoogleFonts.notoSansThai(
                        textStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  )),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 240.0),
                    child: Text("เลขบัตรประชาชน",
                        style: GoogleFonts.notoSansThai(
                            textStyle: TextStyle(
                          fontSize: 15,
                        ))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      if (checkid_card == false)
                        textstyle(
                          fontSize: 15,
                          text: "กรุณากรอกรหัสบัตรประชาชนให้ถูกต้อง",
                          color: Color(0xFFDC294E),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFEFEFEF),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color(0xFFEFEFEF), width: 0.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 0.0),
                              borderRadius: BorderRadius.circular(10),
                            )),
                        cursorColor: const Color(0xCC61D2A4),
                        onSaved: (info) {
                          setState(() {
                            id_card_Number = info!;
                          });
                        },
                        keyboardType: TextInputType.number),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 260.0),
                    child: Text("ชื่อ-นามสกุล",
                        style: GoogleFonts.notoSansThai(
                            textStyle: TextStyle(
                          fontSize: 15,
                        ))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      if (checkname == false)
                        textstyle(
                          fontSize: 15,
                          text: "กรุณาเว้นชื่อจริงกับนามสกุล",
                          color: Color(0xFFDC294E),
                        )
                    ],
                  ),
                  SizedBox(
                      height: 50,
                      width: 350,
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFEFEFEF),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFEFEFEF), width: 0.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius: BorderRadius.circular(10),
                              )),
                          cursorColor: const Color(0xCC61D2A4),
                          onSaved: (info) {
                            setState(() {
                              full_name = info!;
                            });
                          },
                          keyboardType: TextInputType.name)),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 250.0),
                    child: Text("วันเดือนปีเกิด",
                        style: GoogleFonts.notoSansThai(
                            textStyle: TextStyle(
                          fontSize: 15,
                        ))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      if (checkbirthdate == false)
                        textstyle(
                          fontSize: 15,
                          text: "กรุณากรอกวันเดือนปีเกิด",
                          color: Color(0xFFDC294E),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: dateinput,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEFEFEF),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFEFEFEF), width: 0.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.0),
                            borderRadius: BorderRadius.circular(10),
                          )

                          //label text of field
                          ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                1), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            birthdate = formattedDate;
                            dateinput.text =
                                formattedDate; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 235.0),
                    child: Text("วันบัตรหมดอายุ",
                        style: GoogleFonts.notoSansThai(
                            textStyle: TextStyle(
                          fontSize: 15,
                        ))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      if (checkexpiredate == false)
                        textstyle(
                          fontSize: 15,
                          text: "กรุณากรอกวันหมดอายุบัตรประชาชน",
                          color: Color(0xFFDC294E),
                        )
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: 350,
                    child: TextField(
                      textAlign: TextAlign.center,
                      controller: enddateinput,
                      //editing controller of this TextField
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEFEFEF),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFFEFEFEF), width: 0.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 0.0),
                            borderRadius: BorderRadius.circular(10),
                          )

                          //label text of field
                          ),
                      readOnly:
                          true, //set it true, so that user will not able to edit text
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(
                                2000), //DateTime.now() - not to allow to choose before today.
                            lastDate: DateTime(2101));

                        if (pickedDate != null) {
                          print(
                              pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                          String formattedDate2 =
                              DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(
                              formattedDate2); //formatted date output using intl package =>  2021-03-16
                          //you can implement different kind of Date Format here according to your requirement

                          setState(() {
                            expiredate = formattedDate2;
                            enddateinput.text =
                                formattedDate2; //set output date to TextField value.
                          });
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 240.0),
                    child: textstyle(
                      text: "หมายเลข H/N",
                      fontSize: 15,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Column(
                    children: [
                      if (checkHN == false)
                        textstyle(
                          fontSize: 15,
                          text: "กรุณากรอกหมายเลข H/N",
                          color: Color(0xFFDC294E),
                        )
                    ],
                  ),
                  SizedBox(
                      height: 50,
                      width: 350,
                      child: TextFormField(
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFEFEFEF),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xFFEFEFEF), width: 0.0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.white, width: 0.0),
                                borderRadius: BorderRadius.circular(10),
                              )),
                          cursorColor: const Color(0xCC61D2A4),
                          onSaved: (info) {
                            setState(() {
                              HN_number = info!;
                            });
                          },
                          keyboardType: TextInputType.name)),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                      child: TextButton(
                          onPressed: () {
                            formkey.currentState!.save();
                            saveData();
                          },
                          child: Submitfiled(
                            child: Center(
                              child: textstyle(
                                  text: "ยืนยัน",
                                  color: Colors.white,
                                  fontSize: 20),
                            ),
                          )))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
