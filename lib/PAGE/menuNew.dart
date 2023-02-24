import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jitsi_meet_wrapper_example/chart/bloodSugar.dart';
import 'package:jitsi_meet_wrapper_example/chart/bloodpressure.dart';
import 'package:jitsi_meet_wrapper_example/chart/heartRatechart4.dart';
import 'package:jitsi_meet_wrapper_example/chart/oxygenChart.dart';
import 'package:jitsi_meet_wrapper_example/chart/temperatureChart.dart';
import 'package:jitsi_meet_wrapper_example/jitsi.dart';
import 'add.dart';
import 'add_data/addinfo.dart';
import 'manupage/history/history1.dart';
import 'manupage/other.dart';
import 'manupage/setting/Setting.dart';
import '../config.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class menuNew extends StatefulWidget {
  @override
  State<menuNew> createState() => _menuNewState();
}

class _menuNewState extends State<menuNew> {
  var styleText = TextStyle(fontSize: 12);
  List<dynamic> dataList = [];
  static var _data;
  String? idcard;

  Future<void> fetchProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    String? idcardNumberpatients = prefs.getString("ID");
    setState(() {
      idcard = idcardNumberpatients;
    });

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(baseUrl + '/homepage/'));
    request.body = json.encode({"user_id": idcardNumberpatients});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      print(jsonResponse);

      print(jsonResponse);

      setState(() {
        _data = jsonResponse;

        dataList = jsonResponse["patients"]
            .map((data) => {
                  "first_name": data['patient']['first_name'],
                  "last_name": data['patient']['last_name'],
                  "image": data['patient']['image'],
                  "date": data['patient']['last_record_custom']
                      .split(" ")
                      .take(3)
                      .join(" "),
                  "status": data['status'],
                })
            .toList();
      });
      final SharedPreferences sheredPreferences =
          await SharedPreferences.getInstance();
      sheredPreferences.setString('Name_User',
          " ${_data["user"]["first_name"]}  ${_data["user"]["last_name"]}");
    }
  }

  int dateToInt(String date) {
    DateTime dateTime = DateTime.parse(date);

    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    String formattedDate =
        "${day.toString().padLeft(2, '0')}${month.toString().padLeft(2, '0')}${year.toString()}";
    return int.parse(formattedDate);
  }

  // Future<void> fetchinfoData() async {
  //   final prefs = await SharedPreferences.getInstance();

  //   String? idcardNumberpatients = prefs.getString("ID");
  //   var headers = {'Content-Type': 'application/json'};
  //   var request = http.Request(
  //       'GET', Uri.parse('http://192.168.1.163:8000/get_patientdata/'));
  //   request.body = json.encode(
  //       {"user_id": idcardNumberpatients, "patient_id": idcardNumberpatients});
  //   request.headers.addAll(headers);

  //   http.StreamedResponse response = await request.send();

  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     var jsonResponse = json.decode(await response.stream.bytesToString());
  //     print(jsonResponse);

  //     setState(() {
  //       _data = jsonResponse;
  //     });
  //   }
  // }
  bool check = false;
  // โหลด
  Future<void> loading() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove("id_card_Number_patients");
    prefs.remove("full_name");

    String? idcardNumberpatients = prefs.getString("ID");
    if (idcardNumberpatients == null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          settings: RouteSettings(name: "/InputLogin"),
          builder: (context) => InputLogin(),
        ),
      );
      setState(() {
        check = true;
      });
    }
    await fetchProfileData();
    setState(() {
      check = true;
    });

    // Code to be executed after fetchInfoData is complete
  }

  @override
  void initState() {
    loading();
    super.initState();
    Future.delayed(Duration(seconds: 2), () {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        body: _data == null
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
            : Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 170,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 80, bottom: 20),
                                          child: textstyle(
                                            text:
                                                "สวัดดีคุณ  ${_data["user"]["first_name"]}",
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10.0),
                                          child: textstyle(
                                              text: _data["status"] == null
                                                  ? "ค่าความเสี่ยง: --"
                                                  : "ค่าความเสี่ยง: ${_data["status"]}",
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 26),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 20.0, right: 10),
                                      child: SizedBox(
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
                                                  "$baseUrl ${_data["user"]["image"]}"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )),
                      Stack(alignment: Alignment.topCenter, children: [
                        SizedBox(
                          height: 900,
                          width: double.infinity,
                          child: Card(
                            color: Color(0xffFAFAFA),
                            margin: const EdgeInsets.only(top: 24.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30)),
                            ),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 50,
                                ),
                                Container(
                                  height: 190,
                                  width: 330,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          offset: Offset(0, 3),
                                          blurRadius: 7,
                                        )
                                      ],
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      )),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      dataList.isEmpty
                                          ? SizedBox(
                                              height: 100,
                                              child: Center(
                                                  child: textstyle(
                                                text: "ไม่มีข้อมูล",
                                                fontSize: 15,
                                              )))
                                          : ListView.builder(
                                              padding: EdgeInsets.zero,
                                              shrinkWrap: true,
                                              itemCount: dataList.length,
                                              itemBuilder: (context, index) {
                                                final data = dataList[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 10,
                                                                top: 10),
                                                        child: SizedBox(
                                                            height: 40,
                                                            child: CircleAvatar(
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                "$baseUrl${data["image"]}",
                                                              ),
                                                            )),
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        children: [
                                                          textstyle(
                                                            text:
                                                                "${data["first_name"]}  ${data["last_name"]}",
                                                            fontSize: 15,
                                                          ),
                                                          textstyle(
                                                              text:
                                                                  "เข้าเยี่ยมล่าสุด ${data["date"]}",
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFFA0A0A0),
                                                              fontSize: 12)
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10),
                                                        child: Container(
                                                            child: textstyle(
                                                              text: data[
                                                                  "status"],
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            height: 30,
                                                            width: 70,
                                                            alignment: Alignment
                                                                .center,
                                                            decoration: BoxDecoration(
                                                                color: data["status"] ==
                                                                        "สูง"
                                                                    ? Color(
                                                                        0xffDC294E)
                                                                    : Color(
                                                                        0xff61D2A4),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            30)))),
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                      Container(
                                          child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      history1(),
                                                ),
                                              );
                                              setState(() {
                                                check = false;
                                              });
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                SizedBox(
                                                    child: Icon(
                                                  Icons.article_outlined,
                                                  color: Colors.white,
                                                )),
                                                Expanded(
                                                  child: textstyle(
                                                    text: "ประวัติคนไข้ล่าสุด",
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 30),
                                                  child: Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    color: Colors.white54,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Color(0xff61D2A4),
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(20),
                                                bottomRight:
                                                    Radius.circular(20)),
                                          ))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 17, right: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Icon(Icons.cast_connected,
                                                color: Color(0xff61D2A4),
                                                size: 30),
                                          ),
                                          Expanded(
                                              child: textstyle(
                                            text: "เชื่อมต่อ   :",
                                            fontSize: 12,
                                          )),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 15.0),
                                            child: Icon(Icons.document_scanner,
                                                color: Color(0xff61D2A4),
                                                size: 30),
                                          ),
                                          Expanded(
                                              child: textstyle(
                                                  text: "คู่มือ   :",
                                                  fontSize: 12)),
                                          Icon(Icons.install_mobile_outlined,
                                              color: Color(0xff61D2A4),
                                              size: 30),
                                          Expanded(
                                              child: TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      Setting_page(),
                                                ),
                                              );
                                              setState(() {
                                                check = false;
                                              });
                                            },
                                            child: textstyle(
                                              text: "ตั่งค่า",
                                              fontSize: 12,
                                              color: Colors.black,
                                            ),
                                          ))
                                        ],
                                      ),
                                    ),
                                    height: 50,
                                    width: 320,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          spreadRadius: 1,
                                          offset: Offset(0, 3),
                                          blurRadius: 7,
                                        )
                                      ],
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
                                                    status: _data["heartrate"]
                                                                ['status_hr'] ==
                                                            null
                                                        ? "--"
                                                        : "${_data["heartrate"]['status_hr']}",
                                                    sensor: _data["heartrate"]
                                                                ['pulse'] ==
                                                            null
                                                        ? "--"
                                                        : "${_data["heartrate"]['pulse']}",
                                                    typesen: "bpm",
                                                    textinfo:
                                                        "อัตตราการเต้นหัวใจ",
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
                                                    status: _data["temp"]
                                                                ['status'] ==
                                                            null
                                                        ? "--"
                                                        : "${_data["temp"]['status']}",
                                                    sensor: _data["temp"][
                                                                'temperature'] ==
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
                                                    builder: (context) =>
                                                        other()));
                                          },
                                          child: SizedBox(
                                              height: 251,
                                              width: 156,
                                              child: ContainaerW(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20.0, top: 20),
                                                  child: Row(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                  Icons
                                                                      .border_outer_sharp,
                                                                  color: Color(
                                                                      0xff61D2A4),
                                                                  size: 30),
                                                              _data["symptom"] ==
                                                                      null
                                                                  ? Text("--")
                                                                  : Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        _data["symptom"]['symptom_cough'] ==
                                                                                true
                                                                            ? textstyle(
                                                                                text: "ไอแห้ง เจ็บคอ",
                                                                                fontSize: 12,
                                                                                color: Color(0xff8A8A8A),
                                                                              )
                                                                            : SizedBox(),
                                                                        _data["symptom"]['symptom_tightness'] ==
                                                                                true
                                                                            ? textstyle(
                                                                                text: "แน่นหน้าอก",
                                                                                fontSize: 12,
                                                                                color: Color(0xff8A8A8A))
                                                                            : SizedBox(),
                                                                        _data["symptom"]['symptom_tired'] ==
                                                                                true
                                                                            ? textstyle(
                                                                                text: "เหนื่อยง่าย",
                                                                                fontSize: 12,
                                                                                color: Color(0xff8A8A8A))
                                                                            : SizedBox(),
                                                                        _data["symptom"]['symptom_loss_smellandtaste'] ==
                                                                                true
                                                                            ? textstyle(
                                                                                text: "สูญเสียการได้กลิ่น..",
                                                                                fontSize: 12,
                                                                                color: Color(0xff8A8A8A))
                                                                            : SizedBox(),
                                                                        _data["symptom"]['symptom_body_aches'] ==
                                                                                true
                                                                            ? textstyle(
                                                                                text: "ปวดเมื่อยตามร่างกาย",
                                                                                fontSize: 12,
                                                                                color: Color(0xff8A8A8A))
                                                                            : SizedBox(),
                                                                        _data["symptom"]['symptom_red_patches'] ==
                                                                                true
                                                                            ? textstyle(
                                                                                text: "ผื่นแดงขึ้นตามตัว",
                                                                                fontSize: 12,
                                                                                color: Color(0xff8A8A8A))
                                                                            : SizedBox(),
                                                                        _data["symptom"]['symptom_etc'] ==
                                                                                true
                                                                            ? textstyle(
                                                                                text: "ข้อมูลเพิ่มเติม ${_data["symptom"]['symptom_etc']}",
                                                                                fontSize: 12,
                                                                                color: Color(0xff8A8A8A))
                                                                            : SizedBox(),
                                                                      ],
                                                                    ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        10.0),
                                                            child: textstyle(
                                                                text:
                                                                    "อาการอื่นๆ",
                                                                fontSize: 15,
                                                                color: Color(
                                                                    0xff8A8A8A)),
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
                                                            builder:
                                                                (context) =>
                                                                    Meeting()));
                                                  },
                                                  child: SizedBox(
                                                    height: 75,
                                                    width: 156,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .local_hospital_sharp,
                                                          size: 35,
                                                          color: Colors.white,
                                                        ),
                                                        textstyle(
                                                          text: " ฉุกเฉิน",
                                                          color: Colors.white,
                                                          fontSize: 26,
                                                        ),
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
                                                    status: _data["glucos"]
                                                                ['status'] ==
                                                            null
                                                        ? "--"
                                                        : "${_data["glucos"]['status']}",
                                                    sensor: _data["glucos"]
                                                                ['glucos'] ==
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
                                                    status: _data["oxygen"]
                                                                ['status'] ==
                                                            null
                                                        ? "--"
                                                        : "${_data["oxygen"]['status']}",
                                                    sensor: _data["oxygen"]
                                                                ['oxygen'] ==
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
                                                        bpchartScreen(
                                                          id_user: idcard,
                                                        )));
                                          },
                                          child: SizedBox(
                                              height: 160,
                                              width: 156,
                                              child: ContainaerW(
                                                color: Colors.white,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Icon(Icons.ac_unit,
                                                              color: Color(
                                                                  0xff61D2A4),
                                                              size: 20),
                                                          Container(
                                                              child: textstyle(
                                                                text: _data["bloodpressure"]
                                                                            [
                                                                            "status_bp"] ==
                                                                        null
                                                                    ? "--"
                                                                    : "${_data["bloodpressure"]["status_bp"]}",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 15,
                                                              ),
                                                              height: 28,
                                                              width: 51,
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              decoration: BoxDecoration(
                                                                  color: _data["bloodpressure"]['status_bp'] == null
                                                                      ? Color(0xff61D2A4)
                                                                      : _data["bloodpressure"]['status_bp'] == "ต่ำ"
                                                                          ? Color(0xffF8D277)
                                                                          : _data["bloodpressure"]['status_bp'] == "สูง"
                                                                              ? Color(0xffDC294E)
                                                                              : Color(0xff61D2A4),
                                                                  borderRadius: BorderRadius.all(Radius.circular(30)))),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            _data["bloodpressure"] ==
                                                                    null
                                                                ? "--"
                                                                : "${_data["bloodpressure"]['systolic']}",
                                                            style: GoogleFonts.notoSans(
                                                                textStyle: TextStyle(
                                                                    fontSize:
                                                                        32,
                                                                    color: Colors
                                                                        .black)),
                                                          ),
                                                          Expanded(
                                                              child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0),
                                                            child: textstyle(
                                                              text: "SYS",
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                          ))
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            _data["bloodpressure"] ==
                                                                    null
                                                                ? "--"
                                                                : "${_data["bloodpressure"]['diastolic']}",
                                                            style: GoogleFonts.notoSans(
                                                                textStyle: TextStyle(
                                                                    fontSize:
                                                                        32,
                                                                    color: Colors
                                                                        .black)),
                                                          ),
                                                          Expanded(
                                                              child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 10.0),
                                                            child: textstyle(
                                                              text: "DIA",
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .black45,
                                                            ),
                                                          ))
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 25.0),
                                                        child: textstyle(
                                                          text: "ความดันโลหิต",
                                                          fontSize: 15,
                                                          color:
                                                              Color(0xff8A8A8A),
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
                        SizedBox(
                          height: 55,
                          width: 328,
                          child: Submitfiled(
                            child: TextButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add_circle_outline,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    textstyle(
                                        text: "เพิ่มข้อมูล",
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => add()));
                                  setState(() {
                                    check = false;
                                  });
                                }),
                          ),
                        )
                      ])
                    ],
                  ),
                ),
                color: _data["status"] == "ปกติ"
                    ? Color.fromARGB(255, 45, 148, 107)
                    : Color(0xffDC294E),
              ),
      ),
    );
  }
}

class ContainaerW extends StatelessWidget {
  final child;
  final color;

  const ContainaerW({Key? key, this.child, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: child,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1,
              offset: Offset(0, 3),
              blurRadius: 7,
            )
          ],
        ));
  }
}

class infoCon extends StatelessWidget {
  final child;
  final color;
  final status;
  final sensor;
  final typesen;
  final textinfo;
  final icon;
  const infoCon({
    Key? key,
    this.child,
    this.color,
    required this.status,
    required this.sensor,
    required this.typesen,
    required this.textinfo,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: Color(0xff61D2A4), size: 20),
              Container(
                  child: textstyle(
                    text: status,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15,
                  ),
                  height: 30,
                  width: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: status == "ต่ำ"
                          ? Color(0xffF8D277)
                          : status == "สูง" || status == "ต่ำมาก"
                              ? Color(0xffDC294E)
                              : Color(0xff61D2A4),
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
            ],
          ),
          Row(
            children: [
              Text(
                sensor,
                style: GoogleFonts.notoSans(
                    textStyle: TextStyle(fontSize: 32, color: Colors.black)),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: textstyle(
                  text: typesen,
                  fontSize: 15,
                  color: Colors.black45,
                ),
              ))
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 25.0),
              child: textstyle(
                text: textinfo,
                fontSize: 15,
                color: Color(0xff8A8A8A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
