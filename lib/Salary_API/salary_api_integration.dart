import 'dart:convert';
import 'package:flutter/foundation.dart';


import 'Get_Constants_Model.dart';
import 'package:http/http.dart' as http;

Future<List<String>> getConstantForAppDept() async {
  List<String> departmentList = [];
  try {
    final response = await http
        .get(Uri.parse('http://salarypredictor.pythonanywhere.com/constants'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);

      departmentList = data['departments']?.cast<String>();

      if (kDebugMode) {
        print(departmentList);
      }

      return departmentList;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return departmentList;
}

Future<List<String?>?> getConstantForAppPost() async {
  List<String?> postList = [];
  try {
    final response = await http
        .get(Uri.parse('http://salarypredictor.pythonanywhere.com/constants'));
    var data = Get_Constants.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      postList = data.posts!;
      if (kDebugMode) {
        print(data.posts);
      }

      return postList;
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return null;
}

Future<List<String>> getConstantForAppJobRole(String jobRoleName) async {
  List<String> jobRoleList=[];
  try {
    final response = await http
        .get(Uri.parse('http://salarypredictor.pythonanywhere.com/constants'));
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<String>? customJobRoles =
          data['jobroles'][jobRoleName]?.cast<String>();

      if (customJobRoles != null) {
        jobRoleList = customJobRoles.toList();
        // Alternatively, you can use List<String> jobRoleList = List<String>.from(customJobRoles);
print(jobRoleList);
        return jobRoleList;
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return jobRoleList;
}

Future<List<String>?> getConstantForAppSkills(
    String jobRoleName, String skillType) async {
  try {
    final response = await http
        .get(Uri.parse("http://salarypredictor.pythonanywhere.com/constants"));
    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      List<String>? customSkills =
          data['skills'][jobRoleName][skillType].cast<String>();

      // print(data1.skills!.customerSupport!.nonTechnicalSkills![0]);

      if (customSkills != null) {
        List<String> skillsList = customSkills.toList();
        // Alternatively, you can use List<String> jobRoleList = List<String>.from(customJobRoles);

        if (kDebugMode) {
          print(skillsList);
        }

        return skillsList;
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print(e);
    }
  }
  return null;
}
