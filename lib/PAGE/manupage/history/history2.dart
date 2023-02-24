import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jitsi_meet_wrapper_example/PAGE/manupage/other.dart';
import 'package:jitsi_meet_wrapper_example/chart/bloodSugar.dart';
import 'package:jitsi_meet_wrapper_example/chart/bloodpressure.dart';
import 'package:jitsi_meet_wrapper_example/chart/heartRatechart4.dart';
import 'package:jitsi_meet_wrapper_example/chart/oxygenChart.dart';
import 'package:jitsi_meet_wrapper_example/chart/temperatureChart.dart';
import 'package:jitsi_meet_wrapper_example/jitsi.dart';
import '../history/history1.dart';
import '../../menuNew.dart';
import '../../../config.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class history2 extends StatefulWidget {
  @override
  State<history2> createState() => _history2State();
}

class _history2State extends State<history2> {
  static var _data;
  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    String? idcardNumberpatients = prefs.getString("ID");
    String? patient_id = prefs.getString("id_partirntinfo");

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(baseUrl + '/get_patientdata/'));
    request.body = json
        .encode({"user_id": idcardNumberpatients, "patient_id": patient_id});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      print(jsonResponse);

      setState(() {
        _data = jsonResponse;
        check = true;
      });
    }
  }

  bool check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF61D2A4)),
              onPressed: () {
                setState(() {
                  check = false;
                  Navigator.of(context).pop();
                });
              }),
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.history_edu_rounded,
                    color: Color(0xFF61D2A4),
                    size: 35,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  textstyle(
                    text: "ประวัติคนไข้",
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              SizedBox(
                width: 50,
              )
            ],
          ),
        ),
        body: check == false
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
            : SingleChildScrollView(
                child: Center(
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                            width: 330,
                            height: 100,
                            child: ContainaerW(
                              color: _data["status"] == "ปกติ"
                                  ? Color(0xff61D2A4)
                                  : Color(0xffDC294E),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 70,
                                    width: 70,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 10,
                                      child: SizedBox(
                                        height: 60,
                                        width: 60,
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              "$baseUrl ${_data["patient"]["image"]}"),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      textstyle(
                                          text:
                                              "คุณ ${_data["patient"]["first_name"]}",
                                          fontSize: 20,
                                          color: Colors.white),
                                      textstyle(
                                        text:
                                            "ค่าความเสี่ยง : ${_data["status"]} ",
                                        fontSize: 26,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                hrchartScreen()));
                                  },
                                  child: SizedBox(
                                      height: 110,
                                      width: 156,
                                      child: ContainaerW(
                                          color: Colors.white,
                                          child: infoCon(
                                            status: {
                                                      _data["heartrate"]
                                                          ['status_hr']
                                                    } ==
                                                    null
                                                ? "--"
                                                : "${_data["heartrate"]['status_hr']}",
                                            sensor: {
                                                      _data["heartrate"]
                                                          ['pulse']
                                                    } ==
                                                    null
                                                ? "--"
                                                : "${_data["heartrate"]['pulse']}",
                                            typesen: "bpm",
                                            textinfo: "อัตตราการเต้นหัวใจ",
                                            icon: Icons.heart_broken,
                                          ))),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                tmpchartScreen()));
                                  },
                                  child: SizedBox(
                                      height: 110,
                                      width: 156,
                                      child: ContainaerW(
                                          color: Colors.white,
                                          child: infoCon(
                                            status: {_data["temp"]['status']} ==
                                                    null
                                                ? "--"
                                                : "${_data["temp"]['status']}",
                                            sensor: {
                                                      _data["temp"]
                                                          ['temperature']
                                                    } ==
                                                    null
                                                ? "--"
                                                : "${_data["temp"]['temperature']}",
                                            typesen: " ํC",
                                            textinfo: "อุณหภูมิร่างกาย",
                                            icon: Icons.heart_broken,
                                          ))),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => other()));
                                  },
                                  child: SizedBox(
                                      height: 251,
                                      width: 156,
                                      child: ContainaerW(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20.0, top: 20),
                                          child: Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Icon(
                                                          Icons
                                                              .border_outer_sharp,
                                                          color:
                                                              Color(0xff61D2A4),
                                                          size: 30),
                                                      _data["temp"] == null
                                                          ? Text(
                                                              "--",
                                                            )
                                                          : Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                _data["symptom"]
                                                                            [
                                                                            'symptom_cough'] ==
                                                                        true
                                                                    ? textstyle(
                                                                        text:
                                                                            "ไอแห้ง เจ็บคอ",
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff8A8A8A),
                                                                      )
                                                                    : SizedBox(),
                                                                _data["symptom"]
                                                                            [
                                                                            'symptom_tightness'] ==
                                                                        true
                                                                    ? textstyle(
                                                                        text:
                                                                            "แน่นหน้าอก",
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff8A8A8A))
                                                                    : SizedBox(),
                                                                _data["symptom"]
                                                                            [
                                                                            'symptom_tired'] ==
                                                                        true
                                                                    ? textstyle(
                                                                        text:
                                                                            "เหนื่อยง่าย",
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff8A8A8A))
                                                                    : SizedBox(),
                                                                _data["symptom"]
                                                                            [
                                                                            'symptom_loss_smellandtaste'] ==
                                                                        true
                                                                    ? textstyle(
                                                                        text:
                                                                            "สูญเสียการได้กลิ่น..",
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff8A8A8A))
                                                                    : SizedBox(),
                                                                _data["symptom"]
                                                                            [
                                                                            'symptom_body_aches'] ==
                                                                        true
                                                                    ? textstyle(
                                                                        text:
                                                                            "ปวดเมื่อยตามร่างกาย",
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff8A8A8A))
                                                                    : SizedBox(),
                                                                _data["symptom"]
                                                                            [
                                                                            'symptom_red_patches'] ==
                                                                        true
                                                                    ? textstyle(
                                                                        text:
                                                                            "ผื่นแดงขึ้นตามตัว",
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff8A8A8A))
                                                                    : SizedBox(),
                                                                _data["symptom"]
                                                                            [
                                                                            'symptom_etc'] ==
                                                                        true
                                                                    ? textstyle(
                                                                        text:
                                                                            "ข้อมูลเพิ่มเติม ${_data["symptom"]['symptom_etc']}",
                                                                        fontSize:
                                                                            12,
                                                                        color: Color(
                                                                            0xff8A8A8A))
                                                                    : SizedBox(),
                                                              ],
                                                            ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 10.0),
                                                    child: textstyle(
                                                        text: "อาการอื่นๆ",
                                                        fontSize: 15,
                                                        color:
                                                            Color(0xff8A8A8A)),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              children: [
                                SizedBox(
                                  height: 18,
                                ),
                                SizedBox(
                                    height: 75,
                                    width: 156,
                                    child: ContainaerW(
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Meeting()));
                                          },
                                          child: SizedBox(
                                            height: 75,
                                            width: 156,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.local_hospital_sharp,
                                                  size: 35,
                                                  color: Colors.white,
                                                ),
                                                textstyle(
                                                    text: " ฉุกเฉิน",
                                                    color: Colors.white,
                                                    fontSize: 26),
                                              ],
                                            ),
                                          )),
                                      color: Color(0xffDC294E),
                                    )),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                bschartScreen()));
                                  },
                                  child: SizedBox(
                                      height: 110,
                                      width: 156,
                                      child: ContainaerW(
                                          color: Colors.white,
                                          child: infoCon(
                                            status: {
                                                      _data["glucos"]['status']
                                                    } ==
                                                    null
                                                ? "--"
                                                : "${_data["glucos"]['status']}",
                                            sensor: {
                                                      _data["glucos"]['glucos']
                                                    } ==
                                                    null
                                                ? "--"
                                                : "${_data["glucos"]['glucos']}",
                                            typesen: "mg/dl",
                                            textinfo: "น้ำตาลในเลือด",
                                            icon: Icons.heart_broken,
                                          ))),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                oxgchartScreen()));
                                  },
                                  child: SizedBox(
                                      height: 110,
                                      width: 156,
                                      child: ContainaerW(
                                          color: Colors.white,
                                          child: infoCon(
                                            status: {
                                                      _data["oxygen"]['status']
                                                    } ==
                                                    null
                                                ? "--"
                                                : "${_data["oxygen"]['status']}",
                                            sensor: {
                                                      _data["oxygen"]['oxygen']
                                                    } ==
                                                    null
                                                ? "--"
                                                : "${_data["oxygen"]['oxygen']}",
                                            typesen: "%",
                                            textinfo: "ออกซิเจนในเลือด",
                                            icon: Icons.heart_broken,
                                          ))),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                bpchartScreen()));
                                  },
                                  child: SizedBox(
                                      height: 160,
                                      width: 156,
                                      child: ContainaerW(
                                        color: Colors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Icon(Icons.ac_unit,
                                                      color: Color(0xff61D2A4),
                                                      size: 20),
                                                  Container(
                                                      child: textstyle(
                                                        text: {
                                                                  _data["bloodpressure"]
                                                                      [
                                                                      'status_bp']
                                                                } ==
                                                                null
                                                            ? "--"
                                                            : "${_data["bloodpressure"]['status_bp']}",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 15,
                                                      ),
                                                      height: 28,
                                                      width: 51,
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                          color: _data["bloodpressure"]
                                                                      [
                                                                      'status_bp'] ==
                                                                  null
                                                              ? Color(
                                                                  0xff61D2A4)
                                                              : _data["bloodpressure"]
                                                                          [
                                                                          'status_bp'] ==
                                                                      "ต่ำ"
                                                                  ? Color(
                                                                      0xffF8D277)
                                                                  : _data["bloodpressure"]
                                                                              [
                                                                              'status_bp'] ==
                                                                          "สูง"
                                                                      ? Color(
                                                                          0xffDC294E)
                                                                      : Color(
                                                                          0xff61D2A4),
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          30)))),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    _data["bloodpressure"]
                                                                ['systolic'] ==
                                                            null
                                                        ? "--"
                                                        : "${_data["bloodpressure"]['systolic']}",
                                                    style: GoogleFonts.notoSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 32,
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                  Expanded(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0),
                                                    child: textstyle(
                                                      text: "SYS",
                                                      fontSize: 15,
                                                      color: Colors.black45,
                                                    ),
                                                  ))
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    _data["bloodpressure"]
                                                                ['diastolic'] ==
                                                            null
                                                        ? "--"
                                                        : "${_data["bloodpressure"]['diastolic']}",
                                                    style: GoogleFonts.notoSans(
                                                        textStyle: TextStyle(
                                                            fontSize: 32,
                                                            color:
                                                                Colors.black)),
                                                  ),
                                                  Expanded(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10.0),
                                                    child: textstyle(
                                                      text: "DIA",
                                                      fontSize: 15,
                                                      color: Colors.black45,
                                                    ),
                                                  ))
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 25.0),
                                                child: textstyle(
                                                  text: "ความดันโลหิต",
                                                  fontSize: 15,
                                                  color: Color(0xff8A8A8A),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}
