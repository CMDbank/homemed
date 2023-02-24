import 'dart:convert';
import 'package:flutter/material.dart';
import 'add_data/addinfo.dart';
import 'pin.dart';
import 'pincreate.dart';
import '../config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Otp extends StatefulWidget {


  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Submit(context);
  }

  String? Otp;
  String? status;
  String? token;
  String? refno;
  var OTPController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  Future<void> Submit(BuildContext context) async {
    final SharedPreferences sheredPreferences =
        await SharedPreferences.getInstance();
    var phone = sheredPreferences.getString('phone');
    var response = await http
        .post(Uri.parse("https://otp.thaibulksms.com/v2/otp/request"), body: {
      'key': "1756530926486558",
      'secret': "9ae33da1b40881ddf4441e595ac70260",
      'msisdn': phone,
    });
    print(response.body);
    Map<String, dynamic> json1 = jsonDecode(response.body);
    setState(() {
      status = json1["status"];
      token = json1["token"];
      refno = json1["refno"];
    });
    print("status: $status refno:$refno  token:$token");
  }

  Future<void> Submit2(BuildContext context) async {
    final SharedPreferences sheredPreferences =
        await SharedPreferences.getInstance();
    var phone = sheredPreferences.getString('phone');
    var pincheck = sheredPreferences.getString('pincheck');
    var response = await http
        .post(Uri.parse("https://otp.thaibulksms.com/v2/otp/verify"), body: {
      'key': "1756530926486558",
      'secret': "9ae33da1b40881ddf4441e595ac70260",
      'token': token,
      'pin': Otp,
    });
    print(response.body);
    if (response.statusCode == 200) {
      if (pincheck == "Please create a PIN") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => pincreate()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (context) => pin()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
              width: 330,
              child: Form(
                key: formkey,
                child: TextFormField(
                    controller: OTPController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFEFEFEF),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xCC61D2A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xCC61D2A4), width: 1.0),
                          borderRadius: BorderRadius.circular(10),
                        )),
                    cursorColor: const Color(0xCC61D2A4),
                    onChanged: (info) {
                      if (refno != null) {
                        if (info.length == 4) {
                          print(OTPController);
                          Submit2(context);
                          setState(() {
                            Otp = info;
                          });
                        }
                      } else if (info.length > 4) {
                        OTPController.clear();
                      }

                      setState(() {
                        Otp = info;
                      });
                    },
                    keyboardType: TextInputType.number),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            textstyle(
              text: "กรอกเลข OTP ที่ส่งไปยังหมายเลข",
              fontSize: 15,
            ),
            textstyle_eng(
              text: "( REF: $refno )",
              fontSize: 15,
            ),
            TextButton(
              onPressed: () {
                Submit(context);
              },
              child: Submitfiled(
                child: Center(
                    child: textstyle(
                  text: "ส่งรหัสอีกครั้ง",
                  fontSize: 20,
                  color: Colors.white,
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
