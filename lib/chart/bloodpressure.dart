import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:charts_common/common.dart' as common;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import 'dart:math';

import 'package:jitsi_meet_wrapper_example/config.dart';

class bpchartScreen extends StatefulWidget {
  final id_user;
  final id_patient;
  bpchartScreen({this.id_user, this.id_patient});

  @override
  State<bpchartScreen> createState() => _bpchartScreenState();
}

List<Map<String, dynamic>> dataList = [];
List<_bpRateData> apiData = [];

class _bpchartScreenState extends State<bpchartScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> _data = [];
  int dateToInt(String date, String time) {
    DateTime dateTime = DateTime.parse(date);
    String hour = time.substring(0, 2);
    String minute = time.substring(3, 5);
    String year = dateTime.year.toString();
    String month = dateTime.month.toString().padLeft(2, '0');
    String day = dateTime.day.toString().padLeft(2, '0');
    String formattedDate =
        "${day.toString().padLeft(2, '0')}${month.toString().padLeft(2, '0')}${year.toString()}${hour.toString().padLeft(2, '0')}${minute.toString().padLeft(2, '0')}";
    return int.parse(formattedDate);
  }

  String dateTime(String datefm) {
    var date = DateTime.parse(datefm);
    var customFormat = DateFormat("dd MMMM yyyy", "th_TH");
    return customFormat.format(date);
  }

  myinfo() {
    for (var data in dataList) {
      apiData.add(new _bpRateData(
          dateToInt(data["date"], data["time"]),
          data["systolic"],
          data["diastolic"],
          10.0,
          dateTime(data["date"]),
          data["time"]));
    }
    final heightList = dataList.length.toDouble();

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: SizedBox(
        width: 360,
        height: heightList * 85,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) {
            var data = _data[index];

            return Column(
              children: [
                if (data['month_year_th'] != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 250, bottom: 3),
                    child: Text(data['month_year_th'],
                        style: GoogleFonts.notoSans()),
                  ),
                if (data['date'] != null)
                  Card(
                    child: ListTile(
                        leading: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 25),
                              child: Text("${data["time"]}",
                                  style: GoogleFonts.notoSans(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 26)),
                            ),
                            Text(dateTime(data["date"]),
                                style: GoogleFonts.notoSans(
                                    fontSize: 12, color: Colors.grey[600]))
                          ],
                        ),
                        title:
                            data["systolic"] >= 100 && data["diastolic"] >= 100
                                ? Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Text(
                                        "${data["systolic"]}/${data["diastolic"]}",
                                        style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 42)),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Text(
                                        "${data["systolic"]}/${data["diastolic"]}",
                                        style: GoogleFonts.notoSans(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 42)),
                                  ),
                        trailing: Column(
                          children: [
                            Container(
                              width: 40,
                              height: 26,
                              decoration: BoxDecoration(
                                color: data["status_bp"] == 'สูง'
                                    ? Color.fromARGB(255, 220, 41, 78)
                                    : data["status_bp"] == 'medium'
                                        ? Color.fromARGB(255, 248, 210, 119)
                                        : Color.fromARGB(255, 97, 210, 164),
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${data["status_bp"]}",
                                      style: GoogleFonts.notoSansThai(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white)),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 1),
                              child: Text("mmHg",
                                  style: GoogleFonts.notoSansThai(
                                      color: Colors.grey)),
                            )
                          ],
                        )),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<http.StreamedResponse> fetchHeartRateData(String duration) async {
    //final response = await http.get(Uri.parse(url));
    //print(response.statusCode);
    var headers = {'Content-Type': 'application/json'};
    print(widget.id_user);
    print(widget.id_patient);

    var request = http.Request('GET', Uri.parse(baseUrl + '/get_bpfilter/'));
    switch (duration) {
      case "week":
        request.body = json.encode({
          "user_id": widget.id_user,
          "patient_id": widget.id_patient,
          "duration": "week"
        });
        break;
      case "month":
        request.body = json.encode({
          "user_id": widget.id_user,
          "patient_id": widget.id_patient,
          "duration": "month"
        });
        break;
      case "quarter":
        request.body = json.encode({
          "user_id": widget.id_user,
          "patient_id": widget.id_patient,
          "duration": "quarter"
        });
        break;
      case "half":
        request.body = json.encode({
          "user_id": widget.id_user,
          "patient_id": widget.id_patient,
          "duration": "half"
        });
        break;
      default:
        print("Invalid duration");
    }

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var jsonResponse =
          json.decode(await response.stream.bytesToString()) as List;
      setState(() {
        dataList = jsonResponse
            .map((data) => {
                  "month_year_th": data['month_year_th'],
                  "date": data["date"],
                  "time": data["time"].substring(0, 5),
                  "status_bp": data["status_bp"],
                  "systolic": data["systolic"],
                  "diastolic": data["diastolic"],
                })
            .toList();
        for (var data in dataList) {
          if (_data.every((d) => d['month_year_th'] != data['month_year_th'])) {
            _data.add({
              "month_year_th": data['month_year_th'],
            });
          }
          _data.add({
            "date": data["date"],
            "time": data["time"].substring(0, 5),
            "status_bp": data["status_bp"],
            "systolic": data["systolic"],
            "diastolic": data["diastolic"],
          });
        }
      });

      print(dataList);
    } else {
      print(response.reasonPhrase);
    }
    return response;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(_handleTabSelection);
    apiData.clear();
    dataList.clear();
    _data.clear();
    myinfo();
    fetchHeartRateData("week");
    super.initState();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 244, 244),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Color(0xFF61D2A4)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Row(
            children: [
              Container(
                  width: 22,
                  height: 22,
                  child: Image.asset("assets/blood.png",
                      color: Color(0xFF61D2A4))),
              Text(
                ' ระดับความดันโลหิต',
                style: GoogleFonts.notoSansThai(
                    textStyle: TextStyle(fontSize: 20),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        centerTitle: true,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async => await myinfo(),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 15, left: 13, right: 13, bottom: 5),
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 1, color: Colors.black38),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: TabBar(
                    onTap: (int index) {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                      switch (index) {
                        case 0:
                          setState(() {
                            apiData.clear();
                            dataList.clear();
                            _data.clear();
                          });
                          fetchHeartRateData("week");
                          print("0");
                          break;
                        case 1:
                          setState(() {
                            apiData.clear();
                            dataList.clear();
                            _data.clear();
                          });
                          fetchHeartRateData("month");
                          print("1");

                          break;
                        case 2:
                          setState(() {
                            apiData.clear();
                            dataList.clear();
                            _data.clear();
                          });
                          fetchHeartRateData("quarter");
                          break;
                        case 3:
                          setState(() {
                            apiData.clear();
                            dataList.clear();
                            _data.clear();
                          });
                          fetchHeartRateData("half");
                          print("2");
                          break;
                      }
                    },
                    indicator: BoxDecoration(
                      color: Color(0xFF61D2A4),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black,
                    labelStyle: GoogleFonts.notoSansThai(
                        textStyle: TextStyle(fontSize: 15)),
                    controller: _tabController,
                    tabs: [
                      const Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Tab(text: 'สัปดาห์'),
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Tab(text: 'เดือน'),
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Tab(text: '3 เดือน'),
                      ),
                      const Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Tab(text: '6 เดือน'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 224, 224, 224),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: SimpleScatterPlotChart.withSampleData()),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: myinfo()),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 224, 224, 224),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: SimpleScatterPlotChart.withSampleData()),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: myinfo())
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 224, 224, 224),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: SimpleScatterPlotChart.withSampleData()),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: myinfo())
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 224, 224, 224),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: SimpleScatterPlotChart.withSampleData()),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: myinfo())
                  ],
                ),
              ][_tabController.index],
            ),
          ],
        ),
      ),
    );
  }
}

class _bpRateData {
  _bpRateData(this.datetime, this.sbpRate, this.dbpRate, this.radius, this.date,
      this.time);

  final time;
  final date;
  final int datetime;
  final int sbpRate;
  final int dbpRate;
  final double radius;
}

class SimpleScatterPlotChart extends StatelessWidget {
  final List<charts.Series<_bpRateData, num>> seriesList;
  final bool animate;

  SimpleScatterPlotChart({required this.seriesList, this.animate = false});

  /// Creates a [ScatterPlotChart] with sample data and no transition.
  factory SimpleScatterPlotChart.withSampleData() {
    return new SimpleScatterPlotChart(
      seriesList: _createSampleData(),
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 350,
      child: new charts.ScatterPlotChart(
        seriesList,
        animate: animate,
        selectionModels: [
          new charts.SelectionModelConfig(
              type: charts.SelectionModelType.info,
              changedListener: (charts.SelectionModel model) {
                if (model.hasDatumSelection) {
                  final selectedDatum = model.selectedDatum.first.datum;
                  _showData(selectedDatum, context);
                }
              })
        ],
        primaryMeasureAxis: new charts.NumericAxisSpec(
            renderSpec: new charts.GridlineRendererSpec(
          labelStyle: new charts.TextStyleSpec(
              color: charts.Color.fromHex(code: '#7A7A7A')),
        )),
        //primaryMeasureAxis: new charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
        domainAxis: charts.NumericAxisSpec(
          showAxisLine: false,
          renderSpec: charts.NoneRenderSpec(),
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<_bpRateData, num>> _createSampleData() {
    return [
      new charts.Series<_bpRateData, num>(
        id: 'sbp',
        colorFn: (_bpRateData sales, _) {
          //final bucket = sales.bpRate / maxMeasure;

          if (sales.sbpRate <= 140) {
            return charts.Color.fromHex(code: '#61D2A4');
          } else if (sales.sbpRate <= 90) {
            return charts.Color.fromHex(code: '#F8D277');
          } else {
            return charts.Color.fromHex(code: '#DD5571');
          }
        },
        domainFn: (_bpRateData sales, _) => sales.datetime,
        measureFn: (_bpRateData sales, _) => sales.sbpRate,
        radiusPxFn: (_bpRateData sales, _) => sales.radius,
        data: apiData,
      ),
      new charts.Series<_bpRateData, num>(
        id: 'dbp',
        colorFn: (_bpRateData sales, _) {
          //final bucket = sales.bpRate / maxMeasure;

          if (sales.sbpRate <= 90) {
            return charts.Color.fromHex(code: '#61D2A4');
          } else if (sales.sbpRate <= 60) {
            return charts.Color.fromHex(code: '#F8D277');
          } else {
            return charts.Color.fromHex(code: '#DD5571');
          }
        },
        domainFn: (_bpRateData sales, _) => sales.datetime,
        measureFn: (_bpRateData sales, _) => sales.dbpRate,
        radiusPxFn: (_bpRateData sales, _) => sales.radius,
        data: apiData,
      ),
    ];
  }
}

void _showData(data, BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Container(
        width: 10,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(24.0))),
          // contentPadding: EdgeInsets.only(top: 10.0),
          title: Column(
            children: [
              Text(
                "${data.time}",
                style: GoogleFonts.notoSans(
                    textStyle:
                        TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
              ),
              Text(
                "${data.date}",
                style: GoogleFonts.notoSans(textStyle: TextStyle(fontSize: 20)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "ความดันโลหิต:",
                    style: GoogleFonts.notoSans(
                        textStyle: TextStyle(fontSize: 20)),
                  ),
                  Text(
                    "${data.sbpRate}",
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "/",
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    "${data.dbpRate}",
                    style: GoogleFonts.notoSans(
                      textStyle: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),

          actions: <Widget>[
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 232, 70, 70),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  textStyle: GoogleFonts.notoSansThai(
                      textStyle:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                child: Text("ปิด"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      );
    },
  );
}
