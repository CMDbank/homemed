import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import '../add.dart';
import '../add_data/addinfo.dart';
import 'history/history1.dart';
import 'setting/Setting.dart';
import '../menuNew.dart';
import '../../config.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class other extends StatefulWidget {
  @override
  State<other> createState() => _otherState();
}

class _otherState extends State<other> {
  List<dynamic> _data = [];
  List<dynamic> _dataM = [];
  List<dynamic> _dataList = [];
  //โหลด data จาก api
  void loading() async {
    final prefs = await SharedPreferences.getInstance();

    String? id = prefs.getString("ID");
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(baseUrl + '/get_symptom/'));
    request.body = json.encode({"user_id": id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());

      //เอา data จาก api ไปเก็บในตัวแปล list

      setState(() {
        _data = [];
        for (var data in jsonResponse) {
          if (_dataM
              .every((d) => d['month_year_th'] != data['month_year_th'])) {
            _dataM.add({
              "month_year_th": data['month_year_th'],
            });
          }
          _data.add({
            "month_year_th": data['month_year_th'],
            "date_th": data['date_th'],
            "time": data['time'],
            "symptom_cough": data['symptom_cough'],
            "symptom_tightness": data['symptom_tightness'],
            "symptom_tired": data['symptom_tired'],
            "symptom_loss_smellandtaste": data['symptom_loss_smellandtaste'],
            "symptom_body_aches": data['symptom_body_aches'],
            "symptom_red_patches": data['symptom_red_patches'],
            "symptom_etc": data['symptom_etc'],
          });
        }
        print(_dataM);
        print(_data);
      });
    }
  }

  @override
  void initState() {
    loading();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF61D2A4)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Color(0xFFF5F5F5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.more_vert,
                  color: Color(0xFF61D2A4),
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                textstyle(
                  text: "อาการอื่นๆ",
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
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: _dataM.length,
                itemBuilder: (context, index1) {
                  final data1 = _dataM[index1];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 220.0),
                        child: textstyle(
                          text: data1["month_year_th"],
                          fontSize: 15,
                        ),
                      ),
                      Container(
                        width: 350,
                        child: Card(
                          semanticContainer: true,
                          child: ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: _data.length,
                            itemBuilder: (context, index) {
                              final data = _data[index];
                              return Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    if (data1["month_year_th"] ==
                                        data["month_year_th"])
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            data["date_th"] == null
                                                ? Text("")
                                                : SizedBox(
                                                    child: Container(
                                                      width: 300,
                                                      decoration: BoxDecoration(
                                                        border: Border(
                                                          bottom: BorderSide(
                                                            color: Color(
                                                                0xFF8A8A8A),
                                                            width: 1.0,
                                                          ),
                                                        ),
                                                        color: Colors.white,
                                                      ),
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              textstyle(
                                                                text:
                                                                    "${data["time"]}",
                                                                fontSize: 26,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              Text(
                                                                  "${data["date_th"]}"),
                                                            ],
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              data['symptom_cough'] ==
                                                                      true
                                                                  ? textstyle(
                                                                      text:
                                                                          "  ·ไอแห้ง เจ็บคอ",
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xff8A8A8A),
                                                                    )
                                                                  : SizedBox(),
                                                              data['symptom_tightness'] ==
                                                                      true
                                                                  ? textstyle(
                                                                      text:
                                                                          "  ·แน่นหน้าอก",
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xff8A8A8A))
                                                                  : SizedBox(),
                                                              data['symptom_tired'] ==
                                                                      true
                                                                  ? textstyle(
                                                                      text:
                                                                          "  ·เหนื่อยง่าย",
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xff8A8A8A))
                                                                  : SizedBox(),
                                                              data['symptom_loss_smellandtaste'] ==
                                                                      true
                                                                  ? textstyle(
                                                                      text:
                                                                          "  ·สูญเสียการได้กลิ่น..",
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xff8A8A8A))
                                                                  : SizedBox(),
                                                              data['symptom_body_aches'] ==
                                                                      true
                                                                  ? textstyle(
                                                                      text:
                                                                          "  ·ปวดเมื่อยตามร่างกาย",
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xff8A8A8A))
                                                                  : SizedBox(),
                                                              data['symptom_red_patches'] ==
                                                                      true
                                                                  ? textstyle(
                                                                      text:
                                                                          "  ·ผื่นแดงขึ้นตามตัว",
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xff8A8A8A))
                                                                  : SizedBox(),
                                                              data['symptom_etc'] !=
                                                                      null
                                                                  ? textstyle(
                                                                      text:
                                                                          "${data['symptom_etc']}",
                                                                      fontSize:
                                                                          15,
                                                                      color: Color(
                                                                          0xff8A8A8A),
                                                                    )
                                                                  : SizedBox(),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                            // Text(data["date"])
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
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
