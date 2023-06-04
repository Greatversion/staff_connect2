import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:staff_connect/utilities/ReUsable_Functions.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({super.key});

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  String? startDate;
  //0xFF212B66
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    userDataProvider.fetchLeaves();
    userDataProvider.userEmail = _auth.currentUser!.email!;
  }

  @override
  Widget build(BuildContext context) {
    LeaveProvider leaveProvider = Provider.of<LeaveProvider>(context);
    UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
    final leave = leaveProvider.leave;

    var res = MediaQuery.of(context);
    List<_SalesData2> weaklydata = [
      _SalesData2('Mon', 32),
      _SalesData2('Tue', 28),
      _SalesData2('Wed', 44),
      _SalesData2('Thu', 32),
      _SalesData2('Fri', 60),
      _SalesData2('Sat', 49),
      _SalesData2('Sun', 40),
    ];
    List<_SalesData> halfYearlydata = [
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 34),
      _SalesData('Apr', 32),
      _SalesData('May', 40),
      _SalesData('June', 49),
    ];
    List<_SalesData> yearlydata = [
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 34),
      _SalesData('Apr', 32),
      _SalesData('May', 40),
      _SalesData('June', 49),
      _SalesData('July', 20),
      _SalesData('Aug', 30),
      _SalesData('Sept', 49),
      _SalesData('Oct', 69),
      _SalesData('Nov', 59),
      _SalesData('Dec', 79),
    ];

    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: const Color(0xFF212B66),
        child: Column(
          children: [
            const SizedBox(height: 1),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Hey !  ${_auth.currentUser!.email!.replaceFirst('.dev@sconnect.in', '').toUpperCase()}",
                        style: GoogleFonts.kanit(
                            fontSize: 27,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text("Welcome to Staff Connect",
                          style: TextStyle(color: Colors.white70))
                    ],
                  ),
                  CircleAvatar(
                    radius: 27,
                    backgroundImage: userDataProvider.downloadUrl != null
                        ? NetworkImage(userDataProvider.downloadUrl!)
                        : null,
                  )
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: SizedBox(
                width: res.size.width,
                height: res.size.height * 0.5,
                child: Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomCard(
                              rating: '3/5',
                              unDone: 'Ongoing Tasks',
                            )),
                            Expanded(
                                child: CustomCard(
                              rating: '1/5',
                              unDone: 'Upcoming Tasks',
                            ))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                                child: CustomCard(
                              rating: '4/5',
                              unDone: 'Upcoming Projects',
                            )),
                            Expanded(
                                child: CustomCard(
                              rating: '2/5',
                              unDone: 'Completed Tasks',
                            ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            // ignore: sized_box_for_whitespace
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Card(
                elevation: 5,
                shape: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                color: const Color(0xFF212B66),
                child: Expanded(
                  child: Column(
                    children: [
                      Row(children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            " 🚫   Pending Leaves : ",
                            style: GoogleFonts.kanit(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        if (leave != null && leave.numberOfDays > 1)
                          Expanded(
                            child: Container(
                              child: Text(
                                  "On ${"${userDataProvider.startDate!} ⚠️"}",
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          )
                        else
                          const Text(
                            'No Leave Requests',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                // padding: const EdgeInsets.all(50),
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height: 100,
                    width: res.size.width,
                    child: Card(
                      elevation: 15,
                      shape: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      color: const Color(0xFF212B66),
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(borderColor: Colors.red),
                          title: ChartTitle(
                              text: 'Daily Sales Analysis',
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFE9F02))),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData2, String>>[
                            LineSeries<_SalesData2, String>(
                                color: const Color(0xFFFE9F02),
                                dataSource: weaklydata,
                                xValueMapper: (_SalesData2 sales, _) =>
                                    sales.week,
                                yValueMapper: (_SalesData2 sales, _) =>
                                    sales.sales,
                                name: 'Sales ',
                                // Enable data label
                                dataLabelSettings: const DataLabelSettings(
                                    borderColor: Colors.green,
                                    isVisible: true,
                                    textStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)))
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: res.size.width,
                    child: Card(
                      elevation: 15,
                      shape: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      color: const Color(0xFF212B66),
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(borderColor: Colors.red),
                          title: ChartTitle(
                              text: ' Half Yearly Sales Analysis',
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFE9F02))),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                                color: const Color(0xFFFE9F02),
                                dataSource: halfYearlydata,
                                xValueMapper: (_SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (_SalesData sales, _) =>
                                    sales.sales,
                                name: 'Sales ',
                                // Enable data label
                                dataLabelSettings: const DataLabelSettings(
                                    borderColor: Colors.green,
                                    isVisible: true,
                                    textStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)))
                          ]),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    width: res.size.width,
                    child: Card(
                      borderOnForeground: false,
                      shape: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      color: const Color(0xFF212B66),
                      child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(borderColor: Colors.red),
                          title: ChartTitle(
                              text: 'Yearly Sales Analysis',
                              textStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFE9F02))),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                                color: const Color(0xFFFE9F02),
                                dataSource: yearlydata,
                                xValueMapper: (_SalesData sales, _) =>
                                    sales.year,
                                yValueMapper: (_SalesData sales, _) =>
                                    sales.sales,
                                name: 'Sales ',
                                // Enable data label
                                dataLabelSettings: const DataLabelSettings(
                                    borderColor: Colors.green,
                                    isVisible: true,
                                    textStyle: TextStyle(
                                        color: Colors.red,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)))
                          ]),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    ));
  }
}
//0xFFFE9F02

class _SalesData {
  _SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

class _SalesData2 {
  final String week;
  final double sales;

  _SalesData2(this.week, this.sales);
}
