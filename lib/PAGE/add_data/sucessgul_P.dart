import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../add_data/addinfo.dart';
import '../menuNew.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';

class successful_p extends StatefulWidget {


  @override
  State<successful_p> createState() => _successfulState();
}

class _successfulState extends State<successful_p> {
  @override
  void initState() {
    _uploadPhoto();
    // TODO: implement initState
    super.initState();
  }

  String? idcardNumberpatients_info;
  String? ID_info;

  Future<void> _uploadPhoto() async {
    final prefs = await SharedPreferences.getInstance();

    String? idcardNumberpatients = prefs.getString("full_name");

    setState(() {
      idcardNumberpatients_info = idcardNumberpatients;
    });
    print(ID_info);
    print(idcardNumberpatients_info);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: idcardNumberpatients_info == null
          ? Center(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoActivityIndicator(
                      radius: 15,
                    )
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Column(
                  children: [
                    Container(
                        child: Center(
                          child: Icon(
                            Icons.check,
                            size: 100,
                            color: Color(0xFF61D2A4),
                          ),
                        ),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF61D2A4),
                                offset: Offset(0, 0),
                                spreadRadius: 4,
                              )
                            ])),
                    SizedBox(
                      height: 10,
                    ),
                    textstyle(
                      text: "บันทึกข้อมูลเรียบร้อย",
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                    textstyle(
                      text: "คุณ $idcardNumberpatients_info",
                      fontSize: 20,
                      color: Color(0xFFA0A0A0),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 50.0),
                  child: SizedBox(
                    height: 55,
                    width: 330,
                    child: Submitfiled(
                      child: TextButton(
                          onPressed: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => menuNew()));
                          },
                          child: Center(
                              child: textstyle(
                                  text: "ดูผลการประเมิน",
                                  fontSize: 20,
                                  color: Colors.white))),
                    ),
                  ),
                )
              ],
            )),
    );
  }
}
