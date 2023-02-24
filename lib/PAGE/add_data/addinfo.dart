import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../add_data/temp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config.dart';

class Addinfo extends StatefulWidget {
  @override
  _AddinfoState createState() => _AddinfoState();
}

class _AddinfoState extends State<Addinfo> {
  final formkey = GlobalKey<FormState>();
  final url = baseUrl + "/adduser_symptom/";
  bool choice1 = false;
  bool choice2 = false;
  bool choice3 = false;
  bool choice4 = false;
  bool choice5 = false;
  bool choice6 = false;

  String infos = "";

  // ignore: non_constant_identifier_names
  Future<void> Submit(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setBool("symptom_cough", choice1);
    prefs.setBool("symptom_tightness", choice2);
    prefs.setBool("symptom_tired", choice3);
    prefs.setBool("symptom_loss_smellandtaste", choice4);

    prefs.setBool("symptom_body_aches", choice5);
    prefs.setBool("symptom_red_patches", choice6);
    prefs.setString("symptom_etc", infos);

    // var response = await http.post(Uri.parse(url), body: {
    //   "userid": sessionToken,
    //   "": choice1,
    //   "symptom_tightness": choice2,
    //   "symptom_tired": choice3,
    //   "symptom_loss_smellandtaste": choice4,
    //   "symptom_body_aches": choice5,
    //   "symptom_red_patches": choice6,
    //   "symptom_etc": infos
    // });
    // print(infos);
    // if (response.statusCode == 201) {
    //   print("success");
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Toggle Buttons',
      home: Scaffold(
          body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                textstyle(
                    text: "ข้อมูลอาการ",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (choice1 == false) {
                        choice1 = true;
                      } else {
                        choice1 = false;
                      }
                    });
                  },
                  child: Con_button(
                    choice: choice1,
                    text: "ไอแห้ง เจ็บคอ",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (choice2 == false) {
                        choice2 = true;
                      } else {
                        choice2 = false;
                      }
                    });
                  },
                  child: Con_button(
                    choice: choice2,
                    text: "แน่นหน้าอก",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (choice3 == false) {
                        choice3 = true;
                      } else {
                        choice3 = false;
                      }
                    });
                  },
                  child: Con_button(
                    choice: choice3,
                    text: "เหนื่อยง่าย",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (choice4 == false) {
                        choice4 = true;
                      } else {
                        choice4 = false;
                      }
                    });
                  },
                  child: Con_button(
                    choice: choice4,
                    text: "สูญเสียการได้รับกลิ่นและรส",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (choice5 == false) {
                        choice5 = true;
                      } else {
                        choice5 = false;
                      }
                    });
                  },
                  child: Con_button(
                    choice: choice5,
                    text: "ปวดเมื่อยตามร่างกาย",
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      if (choice6 == false) {
                        choice6 = true;
                      } else {
                        choice6 = false;
                      }
                    });
                  },
                  child: Con_button(
                    choice: choice6,
                    text: "ผื่นแดงขึ้นตามตัว",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 35.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 260),
                        child: textstyle(
                            text: "ข้อมูลเพิ่มเติม",
                            fontSize: 15,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                con(
                  child: TextFormField(
                    onSaved: (info) {
                      setState(() {
                        infos = info!;
                      });
                    },
                    decoration: InputDecoration(
                        hintText: "กรอกข้อมูลการอารเพิ่มเติม",
                        hintStyle: GoogleFonts.notoSansThai(
                          textStyle:
                              TextStyle(fontSize: 15, color: Color(0xFF949494)),
                        ),
                        focusedErrorBorder: new OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Color(0xFFEFEFEF), width: 0.0),
                        ),
                        filled: true,
                        fillColor: Color(0xFFEFEFEF),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEFEFEF), width: 0.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFFEFEFEF), width: 0.0),
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        Submit(context);
                        formkey.currentState!.save();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Temp_info()));
                      }
                    },
                    child: Submitfiled(
                      child: Center(
                          child: textstyle(
                              text: "ยืนยัน",
                              color: Colors.white,
                              fontSize: 20)),
                    )),
              ],
            ),
          ),
        ),
      )),
    );
  }
}

class con extends StatelessWidget {
  final child;
  const con({
    Key? key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      height: 86,
      width: 330,
      decoration: BoxDecoration(
          color: Color(0xffEFEFEF),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
    );
  }
}

class Submitfiled extends StatelessWidget {
  final child;
  const Submitfiled({
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
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 1,
            offset: Offset(0, 3),
            blurRadius: 7,
          )
        ],
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

class Con_button extends StatelessWidget {
  final choice;

  final text;

  const Con_button({
    Key? key,
    this.choice,
    this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: 350,
      decoration: BoxDecoration(
          border:
              Border.all(color: choice == true ? Colors.green : Colors.black12),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          )),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Row(
          children: [
            choice == true
                ? Container(
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                    height: size.height * 0.9,
                    width: size.width * 0.06,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF61D2A4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            spreadRadius: 1,
                          )
                        ]),
                  )
                : Container(
                    height: size.height * 0.9,
                    width: size.width * 0.06,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffEFEFEF),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 0),
                            spreadRadius: 1,
                          )
                        ]),
                  ),
            SizedBox(
              width: 30,
            ),
            choice == true
                ? textstyle(
                    text: text,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                  )
                : textstyle(
                    text: text,
                    color: Colors.black38,
                    fontWeight: FontWeight.w400,
                    fontSize: 15)
          ],
        ),
      ),
    );
  }
}
