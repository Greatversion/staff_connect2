// import 'package:chips_choice/chips_choice.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:staff_connect/Salary_API/salary_api_integration.dart';
// import 'package:staff_connect/utilities/drop_down.dart';

// import '../utilities/ReUsable_Functions.dart';

// class UserInformation extends StatefulWidget {
//   const UserInformation({Key? key}) : super(key: key);

//   @override
//   State<UserInformation> createState() => _UserInformationState();
// }

// class _UserInformationState extends State<UserInformation> {
//   TextEditingController name = TextEditingController();
//   TextEditingController eMail = TextEditingController();
//   TextEditingController bankDetails = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
//     SelectedItemProvider selectedItemProvider =
//         Provider.of<SelectedItemProvider>(context);

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 4, left: 10, right: 10),
//           child: Column(
//             children: [
//               Center(
//                 child: CircleAvatar(
//                   radius: 35,
//                   backgroundImage: NetworkImage(userDataProvider.downloadUrl!),
//                 ),
//               ),
//               const SizedBox(height: 5),
//               TextInput(name: name, labelText: "Name"),
//               const SizedBox(height: 1),
//               TextInput(name: eMail, labelText: "E-Mail"),
//               const SizedBox(height: 1),
//               TextInput(
//                 name: bankDetails,
//                 labelText: "Bank Account Number",
//               ),
//               const SizedBox(height: 6),

//               const SizedBox(height: 6),

//               // DropDown(
//               //   itemList: getConstantForAppJobRole(
//               //       selectedItemProvider.selectedItem!),
//               // ),
//               const SizedBox(height: 6),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// Future<List<String>> item = getConstantForAppJobRole('Operations');
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staff_connect/Salary_API/salary_api_integration.dart';
import 'package:staff_connect/utilities/ReUsable_Functions.dart';
import 'package:staff_connect/utilities/drop_down.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  final GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController eMail = TextEditingController();
  TextEditingController bankDetails = TextEditingController();
  TextEditingController phoneNum = TextEditingController();

  final List<String> department = [
    "Finance and Accounting",
    "Sales and Marketing",
    "Legal and Compliance",
    "Research and Development (R&D)",
    "Human Resources (HR)",
    "Operations",
    "Customer Support",
    "Information Technology (IT)",
    "Quality Assurance (QA)",
    "Project Management",
    "Business Development"
  ];
  final List<String> skillType = ["Technical Skills", "Non-Technical Skills"];
  // ignore: non_constant_identifier_names
  final Map<String, List<String>> department_skillMap = {
    "Business Development": ["CEO (Chief Executive Officer)"],
    "Customer Support": [
      "Call Center Supervisor",
      "Customer Support Specialist",
      "Customer Service Representative"
    ],
    "Finance and Accounting": [
      "Accountant",
      "Financial Controller",
      "Auditor",
      "Tax Specialist",
      "Treasury Analyst",
      "Financial Analyst",
      "CFO (Chief Financial Officer)"
    ],
    "Human Resources (HR)": [
      "Employee Relations Specialist",
      "Training and Development Manager",
      "Recruitment Specialist",
      "Compensation and Benefits Specialist",
      "HR Generalist",
      "HR Manager"
    ],
    "Information Technology (IT)": [
      "Database Administrator",
      "IT Manager",
      "Systems Analyst",
      "Software Engineer",
      "IT Support Specialist",
      "Web Developer",
      "Cybersecurity Analyst",
      "Network Administrator",
      "Help Desk Analyst",
      "CTO (Chief Technology Officer)"
    ],
    "Legal and Compliance": [
      "Corporate Counsel",
      "Regulatory Affairs Specialist",
      "Compliance Officer",
      "Legal Assistant"
    ],
    "Operations": [
      "Production Supervisor",
      "Supply Chain Manager",
      "Warehouse Manager",
      "Logistics Coordinator",
      "Team Lead",
      "Operations Manager"
    ],
    "Project Management": [
      "Scrum Master",
      "Project Manager",
      "Project Coordinator"
    ],
    "Quality Assurance (QA)": ["Quality Control Analyst"],
    "Research and Development (R&D)": [
      "Product Development Manager",
      "Research Scientist",
      "Market Research Analyst",
      "Research Analyst",
      "Innovation Manager"
    ],
    "Sales and Marketing": [
      "Marketing Manager",
      "Account Manager",
      "Digital Marketer",
      "Brand Manager",
      "Public Relations Specialist",
      "Sales Representative",
      "CMO (Chief Marketing Officer)"
    ]
  };

  final List<String> posts = [
    "Entry Level/Junior",
    "Associate/Specialist",
    "Mid-Level/Intermediate",
    "Senior/Lead",
    "Manager/Supervisor",
    "Director/Head",
    "Vice President/Executive"
  ];
  String selectedDepartment = "Business Development";
  String selectedSkill = "CEO (Chief Executive Officer)";
  String selectedPost = "Entry Level/Junior";

  String selectedSkillType = "Technical Skills";

  @override
  Widget build(BuildContext context) {
    var res = MediaQuery.of(context);
    UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 10, right: 10),
          child: Form(
            key: _formKey2,
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.centerStart,
                  children: [
                    Container(
                      decoration: const BoxDecoration(color: Color(0xFF212B66)),
                      height: 85,
                      width: res.size.width,
                      child: Opacity(
                        opacity: 0.29,
                        child: Image.asset(
                          "assets/download.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: CircleAvatar(
                        radius: 35,
                        backgroundImage:
                            NetworkImage(userDataProvider.downloadUrl!),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 18),
                TextInput(
                  controller: name,
                  labelText: "Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Complete Name";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 6.0),
                TextInput(
                  controller: eMail,
                  labelText: "E-mail",
                  validator: (value) {
                    if (value!.isEmpty || !value.contains('@')) {
                      return "Enter Your E-mail";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 6.0),
                TextInput(
                  controller: bankDetails,
                  labelText: "Bank Account Number",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Bank Account Number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 6.0),
                TextInput(
                  controller: phoneNum,
                  labelText: "Contact Number",
                  validator: (value) {
                    if (value!.isEmpty || value.length < 10) {
                      return "Incorrect Number";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                CustomDropdown(
                    options: department,
                    selectedOption: selectedDepartment,
                    onOptionChanged: (value) {
                      setState(() {
                        selectedDepartment = value;
                        selectedSkill = department_skillMap[value]![0];
                      });
                    }),
                const SizedBox(height: 16.0),
                CustomDropdown(
                    options: department_skillMap[selectedDepartment]!.toList(),
                    selectedOption: selectedSkill,
                    onOptionChanged: (value) {
                      setState(() {
                        selectedSkill = value;
                      });
                    }),
                const SizedBox(height: 16.0),
                CustomDropdown(
                    options: skillType,
                    selectedOption: selectedSkillType,
                    onOptionChanged: (value) {
                      setState(() {
                        selectedSkillType = value;
                      });
                    }),
                const SizedBox(height: 16.0),
                CustomDropdown(
                    options: posts,
                    selectedOption: selectedPost,
                    onOptionChanged: (value) {
                      setState(() {
                        selectedPost = value;
                      });
                    }),
                const SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey2.currentState!.validate()) {
//                       final String userName = name.text;
// final String userEmail = eMail.text;
// final String userBankDetails = bankDetails.text;
// final String userPhoneNum = phoneNum.text;
// final String selectedDept = selectedDepartment;
// final String selectedSkillValue = selectedSkill;
// final String selectedSkillTypeValue = selectedSkillType;
// final String selectedPostValue = selectedPost;

                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Thanks for the Information..")));
                    }
                  },
                  child: const Text("Submit"),
                  style: ElevatedButton.styleFrom(
                      textStyle: GoogleFonts.kanit(fontSize: 20),
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0xFFFE9F02)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
