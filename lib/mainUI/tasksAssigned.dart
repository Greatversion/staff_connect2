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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "NO TASK ASSIGNED",
              style: GoogleFonts.kanit(fontSize: 30),
            ),
            const Icon(CupertinoIcons.asterisk_circle_fill),
            ElevatedButton(
                onPressed: () async {
                  final url = Uri.parse(
                      'http://salarypredictor.pythonanywhere.com/predict');

                  // Create the request body
                  final requestBody = jsonEncode({
                    "job_role": "Quality Control Analyst",
                    "attendance": 90,
                    "department": "Quality Assurance (QA)",
                    "post": "Vice President/Executive",
                    "equity": 10,
                    "experience": 10,
                    "n_clients": 90,
                    "test_scores": 10,
                    "skills": [
                      "Time Management and Organization",
                      "Quality Management Systems (QMS)",
                    ]
                  });

                  // Set the request headers
                  final headers = <String, String>{
                    'Content-Type': 'application/json',
                  };

                  // Send the POST request
                  final response =
                      await http.post(url, headers: headers, body: requestBody);

                  // Handle the response
                  if (response.statusCode == 200) {
                    // Request successful
                    print('POST request successful');
                    print(response.body);
                  } else {
                    // Request failed
                    print('POST request failed');
                    print('Status code: ${response.statusCode}');
                    print('Response body: ${response.body}');
                  }
                },
                child: Text("dd"))
          ],
        ),
      ),
    );
  }
}
