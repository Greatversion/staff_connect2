// ignore_for_file: sized_box_for_whitespace

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:staff_connect/utilities/ReUsable_Functions.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  @override
  void initState() {
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
    List<_SalesData2> weeklyData = [
      _SalesData2('Mon', 32),
      _SalesData2('Tue', 28),
      _SalesData2('Wed', 44),
      _SalesData2('Thu', 32),
      _SalesData2('Fri', 60),
      _SalesData2('Sat', 49),
      _SalesData2('Sun', 40),
    ];
    List<_SalesData> halfYearlyData = [
      _SalesData('Jan', 35),
      _SalesData('Feb', 28),
      _SalesData('Mar', 34),
      _SalesData('Apr', 32),
      _SalesData('May', 40),
      _SalesData('June', 49),
    ];
    List<_SalesData> yearlyData = [
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
        height: res.size.height,
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        "Welcome to Staff Connect",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  CircleAvatar(
                    radius: 27,
                    backgroundImage: userDataProvider.downloadUrl != null
                        ? NetworkImage(userDataProvider.downloadUrl!)
                        : null,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Card(
                elevation: 5,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                color: Colors.red,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      Text(
                        "🗒️Leave Request :",
                        style: GoogleFonts.kanit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      if (leave != null && leave.numberOfDays > 1)
                        Container(
                          child: Text(
                            " On ${"${userDataProvider.startDate!} "}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      else
                        const Text(
                          ' No Leave Requests',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: Container(
                // height: res.size.height * 0.5,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        star: "⭐⭐⭐",
                        rating: "3",
                        unDone: 'Ongoing Tasks',
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: CustomCard(
                        star: "⭐",
                        rating: "1",
                        unDone: 'Upcoming Tasks',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6, bottom: 5),
              child: Container(
                // height: res.size.height * 0.5,
                child: Row(
                  children: [
                    Expanded(
                      child: CustomCard(
                        star: "⭐⭐⭐⭐⭐",
                        rating: "5",
                        unDone: 'Upcoming Projects',
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: CustomCard(
                        star: "⭐⭐⭐⭐",
                        rating: "4",
                        unDone: 'Completed Tasks',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              height: 200,
              width: double.infinity,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: [
                  Container(
                    height: 100,
                    width: res.size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 4, right: 4),
                      child: Card(
                        elevation: 15,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        color: const Color(0xFF212B66),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(borderColor: Colors.red),
                          title: ChartTitle(
                            text: 'Daily Sales Analysis',
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFE9F02),
                            ),
                          ),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData2, String>>[
                            LineSeries<_SalesData2, String>(
                              color: const Color(0xFFFE9F02),
                              dataSource: weeklyData,
                              xValueMapper: (_SalesData2 sales, _) =>
                                  sales.week,
                              yValueMapper: (_SalesData2 sales, _) =>
                                  sales.sales,
                              name: 'Sales ',
                              dataLabelSettings: const DataLabelSettings(
                                borderColor: Colors.green,
                                isVisible: true,
                                textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: res.size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 4, right: 4),
                      child: Card(
                        elevation: 15,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        color: const Color(0xFF212B66),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(borderColor: Colors.red),
                          title: ChartTitle(
                            text: 'Half Yearly Sales Analysis',
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFE9F02),
                            ),
                          ),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                              color: const Color(0xFFFE9F02),
                              dataSource: halfYearlyData,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) =>
                                  sales.sales,
                              name: 'Sales ',
                              dataLabelSettings: const DataLabelSettings(
                                borderColor: Colors.green,
                                isVisible: true,
                                textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: res.size.width,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 4, right: 4),
                      child: Card(
                        elevation: 15,
                        borderOnForeground: false,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        color: const Color(0xFF212B66),
                        child: SfCartesianChart(
                          primaryXAxis: CategoryAxis(borderColor: Colors.red),
                          title: ChartTitle(
                            text: 'Yearly Sales Analysis',
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFFE9F02),
                            ),
                          ),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <ChartSeries<_SalesData, String>>[
                            LineSeries<_SalesData, String>(
                              color: const Color(0xFFFE9F02),
                              dataSource: yearlyData,
                              xValueMapper: (_SalesData sales, _) => sales.year,
                              yValueMapper: (_SalesData sales, _) =>
                                  sales.sales,
                              name: 'Sales ',
                              dataLabelSettings: const DataLabelSettings(
                                borderColor: Colors.green,
                                isVisible: true,
                                textStyle: TextStyle(
                                  color: Colors.red,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class _SalesData {
  final String year;
  final double sales;

  _SalesData(this.year, this.sales);
}

class _SalesData2 {
  final String week;
  final double sales;

  _SalesData2(this.week, this.sales);
}
