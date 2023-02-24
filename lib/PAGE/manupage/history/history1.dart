import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'history2.dart';
import '../../menuNew.dart';
import '../../../config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class history1 extends StatefulWidget {
  @override
  State<history1> createState() => _history1State();
}

class _history1State extends State<history1> {
  void initState() {
    super.initState();
    fetchProfileData();
  }

  var id_partient;

  bool check = false;

  List<dynamic> dataList = [];
  Future<void> loadData() async {
    final SharedPreferences sheredPreferences =
        await SharedPreferences.getInstance();
    sheredPreferences.setString('id_partirntinfo', id_partient);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => history2()));
    setState(() {
      check = false;
    });
  }

  Future<void> fetchProfileData() async {
    final prefs = await SharedPreferences.getInstance();

    String? idcardNumberpatients = prefs.getString("ID");

    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(baseUrl + '/get_allpatient/'));
    request.body = json.encode({"user_id": idcardNumberpatients});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(await response.stream.bytesToString());
      print(jsonResponse);

      print(jsonResponse);
      setState(() {
        dataList = jsonResponse
            .map((data) => {
                  "id_card_number": data['id_card_number'],
                  "first_name": data['first_name'],
                  "last_name": data['last_name'],
                  "image": data['image'],
                  "HN_number": data['HN_number'],
                  "last_record": data['last_record_custom']
                })
            .toList();
      });
    }
    setState(() {
      check = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
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
                  Icons.history_edu_rounded,
                  color: Color(0xFF61D2A4),
                  size: 35,
                ),
                SizedBox(
                  width: 10,
                ),
                textstyle(
                  text: "ประวัติคนไข้ล่าสุด",
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
      body: dataList == null
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
              child: SingleChildScrollView(
                physics: ScrollPhysics(),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: dataList.length,
                      itemBuilder: (context, index) {
                        final data = dataList[index];
                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  id_partient = data["id_card_number"];
                                });
                                loadData();
                              },
                              child: SingleChildScrollView(
                                child: Container(
                                  height: 83,
                                  width: 350,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        offset: Offset(0, 3),
                                        blurRadius: 7,
                                      )
                                    ],
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                            height: 50,
                                            width: 50,
                                            child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                "$baseUrl${data["image"]}",
                                              ),
                                            )),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "${data["first_name"]}  ${data["last_name"]}",
                                                    style: GoogleFonts
                                                        .notoSansThai(
                                                            textStyle: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15)),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    "${data["HN_number"]}",
                                                    style:
                                                        GoogleFonts.notoSansThai(
                                                            textStyle: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color(
                                                                    0xFFA0A0A0),
                                                                fontSize: 12)),
                                                  ),
                                                ),
                                                Text(
                                                  "เข้าเยี่ยมล่าสุด ${data["last_record"]}",
                                                  style:
                                                      GoogleFonts.notoSansThai(
                                                          textStyle: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF61D2A4),
                                                              fontSize: 12)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                            height: 50,
                                            width: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xFF61D2A4),
                                                    spreadRadius: 2,
                                                  )
                                                ]),
                                            child: Icon(
                                              Icons.phone,
                                              size: 40,
                                              color: Color(0xFF61D2A4),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
