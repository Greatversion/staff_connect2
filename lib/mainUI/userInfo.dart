import 'package:flutter/material.dart';

import '../Salary_API/salary_api_integration.dart';

class UserInformation extends StatelessWidget {
  const UserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: ElevatedButton(
            onPressed: () {
              // getConstantForAppJobRole("Information Technology (IT)");
              // getConstantForAppDept();
              // getConstantForAppDept();
              // getConstantForAppJobRole('Customer Support');
              getConstantForAppSkills('Customer Support', 'Technical Skills');
            },
            child: const Text("eeee")),
      ),
    );
  }
}
