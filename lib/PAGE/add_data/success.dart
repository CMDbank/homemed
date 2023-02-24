import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../add_data/addinfo.dart';
import '../menuNew.dart';
import 'package:badges/badges.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';

class successful extends StatefulWidget {


  @override
  State<successful> createState() => _successfulState();
}

class _successfulState extends State<successful> {
  @override
  void initState() {
    _uploadPhoto();
    // TODO: implement initState
    super.initState();
  }

  String? ID_info;
  String? Name_P;

  Future<void> _uploadPhoto() async {
    final prefs = await SharedPreferences.getInstance();
    String? NameP = prefs.getString("full_name");

    String? ID = prefs.getString("Name_User");
    setState(() {
      ID_info = ID;
      Name_P = NameP;
    });
    print(ID_info);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: ID_info == null && Name_P == null
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
                      text: Name_P == null ? "คุณ $ID_info" : "คุณ $Name_P",
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
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                settings: RouteSettings(name: "/menuNew"),
                                builder: (context) => menuNew(),
                              ),
                            );
                            setState(() {
                              Name_P == null;
                            });
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
