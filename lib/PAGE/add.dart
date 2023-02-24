import 'package:flutter/material.dart';

import 'add_data/addinfo.dart';
import 'add_data/info_profile.dart';
import 'menuNew.dart';
import '../config.dart';

class add extends StatefulWidget {
  @override
  State<add> createState() => _addState();
}

class _addState extends State<add> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 221, 220, 220),
      appBar: AppBar(
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.white,
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(right: 50.0),
          child: textstyle(
            text: "เพิ่มข้อมูล",
            color: Colors.black,
            fontSize: 20,
          ),
        )),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Center(
                child: textstyle(
              text: "คำแนะนำ",
              fontSize: 15,
            )),
            Center(
                child: textstyle(
              text: "ภาพประกอบ",
              fontSize: 15,
            )),
            SizedBox(
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Info()));
                    },
                    child: Container(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Addinfo()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Color(0xff61D2A4),
                                  size: 70,
                                ),
                                textstyle(
                                    text: "ตนเอง",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 26,
                                    color: Color(0xff61D2A4)),
                                textstyle(
                                    text: "นางสาวอาสาสมัคร",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10,
                                    color: Colors.black38),
                              ],
                            ),
                          ),
                        ),
                        height: 160,
                        width: 160,
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
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Info()));
                    },
                    child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.add_card_rounded,
                                color: Color(0xff61D2A4),
                                size: 70,
                              ),
                              textstyle(
                                  text: "คนไข้",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 26,
                                  color: Color(0xff61D2A4)),
                              textstyle(
                                  text: "เตรียมบัตรประชาชน",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: Colors.black38),
                            ],
                          ),
                        ),
                        height: 160,
                        width: 160,
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
