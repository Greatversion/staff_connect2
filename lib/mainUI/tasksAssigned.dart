import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staff_connect/utilities/ReUsable_Functions.dart';

class TasksAssigned extends StatefulWidget {
  const TasksAssigned({super.key});

  @override
  State<TasksAssigned> createState() => _TasksAssignedState();
}

class _TasksAssignedState extends State<TasksAssigned> {
  String? job_role;
  String? attendance;
  String? department;
  String? post;
  String? equity;
  String? experience;
  String? n_clients;
  String? test_scores;

  void sendPostRequest() async {
    // Define the endpoint URL
  }

  @override
  Widget build(BuildContext context) {
    UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
    return Container(
      child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "NO TASK ASSIGNED",
            style: GoogleFonts.kanit(fontSize: 30),
          ),
          const Icon(CupertinoIcons.asterisk_circle_fill),
          ElevatedButton(
              onPressed: () {
                userDataProvider.getSalary();
              },
              child: Text("ee"))
        ]),
      ),
    );
  }
}
