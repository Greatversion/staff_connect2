import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utilities/ReUsable_Functions.dart';

import 'package:table_calendar/table_calendar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore store = FirebaseFirestore.instance;
final CollectionReference userCollection = store.collection('users');
final CollectionReference leaveCollection = store.collection('Leave Requests');

class Leave {
  final int numberOfDays;
  final DateTime startDate;
  final DateTime endDate;

  Leave({
    required this.numberOfDays,
    required this.startDate,
    required this.endDate,
  });
}

class TableRangeExample extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TableRangeExampleState createState() => _TableRangeExampleState();
}

class _TableRangeExampleState extends State<TableRangeExample> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOn;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  DateTime firstDay = DateTime.now();
  DateTime lastDay = DateTime(2024, 12, 31, 24, 60, 60, 1000, 1000000);

  Leave calculateSelectedLeave(DateTime? rangeStart, DateTime? rangeEnd) {
    if (rangeStart == null || rangeEnd == null) {
      return Leave(
          numberOfDays: 0, startDate: DateTime.now(), endDate: DateTime.now());
    }

    // Adjust the rangeStart to be inclusive
    DateTime adjustedRangeStart = rangeStart.add(const Duration(days: 0));

    // Adjust the rangeEnd to be inclusive
    DateTime adjustedRangeEnd = rangeEnd.add(const Duration(days: 1));

    // Calculate the difference in days and add 1 to include both start and end dates
    int difference = adjustedRangeEnd.difference(adjustedRangeStart).inDays;

    return Leave(
        numberOfDays: difference,
        startDate: adjustedRangeStart,
        endDate: rangeEnd);
  }

  @override
  Widget build(BuildContext context) {
    LeaveProvider leaveProvider = Provider.of<LeaveProvider>(context);
    String? currentRegUser = _auth.currentUser!.email;
    // Retrieve the leave from the provider
    final leave = leaveProvider.leave;

    return Scaffold(
      body: Container(
        color: const Color(0xFF212B66),

        ///0xFF212B66
        child: Column(
          children: [
            Expanded(
              child: TableCalendar(
                headerStyle: const HeaderStyle(
                    leftChevronIcon:
                        Icon(Icons.chevron_left, color: Colors.white),
                    rightChevronIcon:
                        Icon(Icons.chevron_right, color: Colors.white),
                    formatButtonTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                    titleTextStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                  weekendStyle:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                calendarStyle: const CalendarStyle(
                    weekNumberTextStyle: TextStyle(color: Colors.white),
                    defaultTextStyle: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                    disabledTextStyle: TextStyle(color: Colors.yellowAccent),
                    weekendTextStyle: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                    todayDecoration: BoxDecoration(
                        color: Color(0xFFFE9F02),
                        borderRadius: BorderRadius.all(Radius.circular(25)))),
                availableCalendarFormats: const {
                  CalendarFormat.month: 'Month',
                  CalendarFormat.week: 'Week'
                },
                firstDay: firstDay,
                lastDay: lastDay,
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      _rangeStart = null;
                      _rangeEnd = null;
                      _rangeSelectionMode = RangeSelectionMode.toggledOff;

                      // Clear the leave in the provider
                      leaveProvider.setLeave(null);
                    });
                  }
                },
                onRangeSelected: (start, end, focusedDay) {
                  setState(() {
                    _selectedDay = null;
                    _focusedDay = focusedDay;
                    _rangeStart = start;
                    _rangeEnd = end;
                    _rangeSelectionMode = RangeSelectionMode.toggledOn;

                    // Calculate the leave and store it in the provider
                    final newLeave = calculateSelectedLeave(start, end);
                    leaveProvider.setLeave(newLeave);
                  });
                },
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
            ),
            if (leave != null && leave.numberOfDays > 1)
              Card(
                shape: const StadiumBorder(),
                color: const Color(0xFFFE9F02),
                margin: const EdgeInsets.all(29),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Current Leave Status :',
                        style: TextStyle(
                          color: Color(0xFF212B66),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Number of Days: ${leave.numberOfDays}',
                        style: const TextStyle(
                            color: Color(0xFF212B66),
                            fontWeight: FontWeight.w500),
                      ),
                      // const SizedBox(height: 8),
                      Text(
                        'Start Date: ${DateFormat('MMM d, yyyy').format(leave.startDate)}',
                        style: const TextStyle(
                            color: Color(0xFF212B66),
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'End Date: ${DateFormat('MMM d, yyyy').format(leave.endDate)}',
                        style: const TextStyle(
                            color: Color(0xFF212B66),
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                onPressed: () async {
                  await userCollection
                      .doc(currentRegUser)
                      .collection("Leaves")
                      .doc("currentLeave")
                      .set({
                    'Start Date': DateFormat('MMM d, yyyy')
                        .format(leave!.startDate)
                        .toString(),
                    'End Date': DateFormat('MMM d, yyyy')
                        .format(leave.endDate)
                        .toString(),
                    'Number of Days': leave.numberOfDays.toString()
                  }).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Sending Leave Request to the HR...")));
                  });
                },
                style: ElevatedButton.styleFrom(
                    textStyle: GoogleFonts.kanit(fontSize: 14),
                    // shape: const StadiumBorder(),
                    backgroundColor: Colors.red),
                child: const Text("Send Request"),
              ),
            ),
            const SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
