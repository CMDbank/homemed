import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:jitsi_meet_wrapper_example/PAGE/manupage/setting/call.dart';
import '../../pinC.dart';
import '../../pinchange.dart';
import '../../pincreate.dart';
import '../../../main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../config.dart';

class Setting_page extends StatefulWidget {
  @override
  State<Setting_page> createState() => _Setting_pageState();
}

class _Setting_pageState extends State<Setting_page> {
  String? sessionTokens;
  bool nottify = false;
  bool scan = false;

  void notc(var value) {
    if (value == false) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF61D2A4)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Color(0xFF61D2A4),
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                textstyle(
                  text: "การตั่งค่า",
                  color: Colors.black,
                  fontSize: 20,
                ),
              ],
            ),
            SizedBox(
              width: 50,
            )
          ],
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black26,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textstyle(
                            text: "การแจ้งเตือน",
                            fontSize: 15,
                          ),
                          Switch(
                            activeTrackColor: Color(0xFF61D2A4),
                            activeColor: Colors.white,
                            value: nottify,
                            onChanged: ((value) {
                              setState(() {
                                nottify = value;
                              });
                              print(nottify);
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black26,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          textstyle(
                            text: "เปิดใช้งาน Scan ลายนิ้วมือ",
                            fontSize: 15,
                          ),
                          Switch(
                            activeTrackColor: Color(0xFF61D2A4),
                            activeColor: Colors.white,
                            value: scan,
                            onChanged: ((value) {
                              setState(() {
                                scan = value;
                              });
                              print(scan);
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 40,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        (pinC())));
                          },
                          child: textstyle(
                            text: "เปลี่ยน Pin",
                            fontSize: 15,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => (Call())));
                        },
                        child: SizedBox(
                          height: 40,
                          child: Row(
                            children: [
                              textstyle(
                                text: "เบอร์โทรติดต่อ",
                                color: Colors.black,
                                fontSize: 15,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(
                    height: 40,
                    child: TextButton(
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.remove('ID');
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    (InputLogin())));
                      },
                      child: textstyle(
                        text: "ออกจากระบบ",
                        fontSize: 15,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
