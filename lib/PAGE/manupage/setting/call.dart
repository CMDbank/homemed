import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../../config.dart';

class Call extends StatefulWidget {
  const Call({Key? key}) : super(key: key);

  @override
  State<Call> createState() => _CallState();
}

class _CallState extends State<Call> {
  List<dynamic> _data = [];
  List<dynamic> _dataM = [];
  @override
  void loading() async {
    final prefs = await SharedPreferences.getInstance();

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(baseUrl + '/get_contact/'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      //เอา data จาก api ไปเก็บในตัวแปล list

      setState(() {
        _data = [];
        for (var data in jsonResponse) {
          _data.add({
            "name": data['name'],
            "phone": data['phone'],
            "category_th": data['category_th'],
          });
        }

        print(_data);
      });
    }
  }

  @override
  void initState() {
    loading();

    super.initState();
  }

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
            SizedBox(
              width: 10,
            ),
            textstyle(
              text: "เบอร์โทรติดต่อ",
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              width: 50,
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            textstyle(text: "โรงพยาบาล", fontSize: 15),
            SizedBox(
              height: 5,
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _data.length,
                itemBuilder: (context, index1) {
                  final data1 = _data[index1];
                  return Column(
                    children: [
                      if (data1["category_th"] == "โรงพยาบาล")
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF8A8A8A),
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textstyle(
                                    text: "${data1["name"]}",
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                  textstyle(
                                    text: "${data1["phone"]}",
                                    fontSize: 14,
                                    color: Color(0xFF8A8A8A),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  launch("tel://${data1["phone"]}");
                                },
                                child: Container(
                                    child: Center(
                                      child: Icon(
                                        Icons.call,
                                        size: 30,
                                        color: Color(0xFF61D2A4),
                                      ),
                                    ),
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF61D2A4),
                                            offset: Offset(0, 0),
                                            spreadRadius: 2,
                                          )
                                        ])),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }),
            SizedBox(
              height: 20,
            ),
            textstyle(text: "เจ้าหน้าที่", fontSize: 15),
            SizedBox(
              height: 5,
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _data.length,
                itemBuilder: (context, index1) {
                  final data1 = _data[index1];
                  return Column(
                    children: [
                      if (data1["category_th"] == "เจ้าหน้าที่")
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color(0xFF8A8A8A),
                                width: 1.0,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  textstyle(
                                      text: "${data1["name"]}",
                                      fontSize: 20,
                                      color: Colors.black),
                                  textstyle(
                                    text: "${data1["phone"]}",
                                    fontSize: 14,
                                    color: Color(0xFF8A8A8A),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                              TextButton(
                                onPressed: () {
                                  launch("tel://${data1["phone"]}");
                                },
                                child: Container(
                                    child: Center(
                                      child: Icon(
                                        Icons.call,
                                        size: 30,
                                        color: Color(0xFF61D2A4),
                                      ),
                                    ),
                                    height: 42,
                                    width: 42,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Color(0xFF61D2A4),
                                            offset: Offset(0, 0),
                                            spreadRadius: 2,
                                          )
                                        ])),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
