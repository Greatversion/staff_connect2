import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:staff_connect/Salary_API/salary_api_integration.dart';
import 'package:staff_connect/utilities/drop_down.dart';

import '../utilities/ReUsable_Functions.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  TextEditingController name = TextEditingController();
  TextEditingController eMail = TextEditingController();
  TextEditingController bankDetails = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
    SelectedItemProvider selectedItemProvider =
        Provider.of<SelectedItemProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 4, left: 10, right: 10),
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage(userDataProvider.downloadUrl!),
                ),
              ),
              const SizedBox(height: 5),
              TextInput(name: name, labelText: "Name"),
              const SizedBox(height: 1),
              TextInput(name: eMail, labelText: "E-Mail"),
              const SizedBox(height: 1),
              TextInput(
                name: bankDetails,
                labelText: "Bank Account Number",
              ),
              const SizedBox(height: 6),
              DropDown(
                itemList: getConstantForAppDept(),
              ),
              const SizedBox(height: 6),
              DropDown(
                itemList: getConstantForAppJobRole(
                    selectedItemProvider.selectedItem!),
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }
}
