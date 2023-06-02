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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:staff_connect/utilities/ReUsable_Functions.dart';
import 'package:staff_connect/utilities/drop_down.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore store = FirebaseFirestore.instance;
final CollectionReference userCollection = store.collection("users");

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
  TextEditingController address = TextEditingController();

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
  String? currentRegUser = _auth.currentUser!.email;
  sendUserFormDataToFirebaseDataBase() async {
    String nameValue = name.text;
    String bankDetailsValue = bankDetails.text;
    String phoneNumValue = phoneNum.text;
    String addressValue = address.text;
    String dept = selectedDepartment;
    String skill = selectedSkill;
    String skillType = selectedSkillType;
    String post = selectedPost;
    await userCollection.doc(currentRegUser).set({
      "name": nameValue,
      "BankDetails": bankDetailsValue,
      "PhoneNumber": phoneNumValue,
      "Address": addressValue,
      "Department": dept,
      "Skills": skill,
      "SkillType": skillType,
      "Post": post
    }, SetOptions(merge: true));
  }

 
  @override
  Widget build(BuildContext context) {
    var res = MediaQuery.of(context);
    UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
    UserInformationProvider userDetailsProvider =
        Provider.of<UserInformationProvider>(context);

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
                const SizedBox(height: 10),
                TextInput(
                  controller: name,
                  labelText: "Name",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Complete Name";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    userDetailsProvider.updateName(value);
                  },
                ),
                const SizedBox(height: 6.0),
                TextInput(
                  controller: eMail,
                  labelText: "E-mail",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your Email";
                    } else if (!value.contains("@")) {
                      return "missing @";
                    } else if (!value.contains(".")) {
                      return "missing .com or .in";
                    }

                    return null;
                  },
                  onChanged: (value) {
                    userDetailsProvider.updateEmail(value);
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
                  onChanged: (value) {
                    userDetailsProvider.updateBankDetails(value);
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
                  onChanged: (value) {
                    userDetailsProvider.updatePhoneNumber(value);
                  },
                ),
                TextInput(
                  controller: address,
                  labelText: "Billing Address",
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Your Complete Address";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    userDetailsProvider.updatePhoneNumber(value);
                  },
                ),
                const SizedBox(height: 16.0),
                CustomDropdown(
                  options: department,
                  selectedOption: selectedDepartment,
                  onOptionChanged: (value) {
                    userDetailsProvider.updateSelectedDepartment(value);
                    setState(() {
                      selectedDepartment = value;
                      selectedSkill = department_skillMap[value]![0];
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                CustomDropdown(
                  options: department_skillMap[selectedDepartment]!.toList(),
                  selectedOption: selectedSkill,
                  onOptionChanged: (value) {
                    userDetailsProvider.updateSelectedSkill(value);
                    setState(() {
                      selectedSkill = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                CustomDropdown(
                  options: skillType,
                  selectedOption: selectedSkillType,
                  onOptionChanged: (value) {
                    userDetailsProvider.updateSelectedSkillType(value);
                    setState(() {
                      selectedSkillType = value;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                CustomDropdown(
                  options: posts,
                  selectedOption: selectedPost,
                  onOptionChanged: (value) {
                    userDetailsProvider.updateSelectedPost(value);
                    setState(() {
                      selectedPost = value;
                    });
                  },
                ),
                const SizedBox(height: 15.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey2.currentState!.validate()) {
                      sendUserFormDataToFirebaseDataBase();
                    
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Thanks for the Information..")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      textStyle: GoogleFonts.kanit(fontSize: 20),
                      shape: const StadiumBorder(),
                      backgroundColor: const Color(0xFFFE9F02)),
                  child: const Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
