// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:staff_connect/mainUI/leaveApplication.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore store = FirebaseFirestore.instance;
final CollectionReference userCollection = store.collection('users');
final FirebaseStorage storage = FirebaseStorage.instance;

class UserDataProvider extends ChangeNotifier {
  late String? userEmail;
  String? downloadUrl;
  String? fileName;
  File? imageFile;
  Leave? leave;

  String? startDate;
  String? endDate;
  String? numberOfdays;

  Future<void> fetchImageUrl() async {
    final DocumentSnapshot docSnapshot =
        await userCollection.doc(userEmail).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      downloadUrl = data['photoUrl'];
      print(downloadUrl);
    }
    notifyListeners();
  }

  Future<void> fetchLeaves() async {
    final DocumentSnapshot docSnapshot = await userCollection
        .doc(userEmail)
        .collection("Leaves")
        .doc('currentLeave')
        .get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      startDate = data['Start Date'];
      endDate = data['End Date'];
      numberOfdays = data['Number of Days'];
    }
    notifyListeners();
  }

  Future<void> uploadImageToFirebaseStorage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage =
        await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      return;
    }
    fileName = userEmail;
    imageFile = File(pickedImage.path);
    await storage.ref(fileName!).putFile(imageFile!);
    final TaskSnapshot snapshot =
        await storage.ref(fileName!).putFile(imageFile!);
    downloadUrl = await snapshot.ref.getDownloadURL();
    await userCollection.doc(userEmail).set({
      'email': userEmail,
      'photoUrl': downloadUrl,
    }, SetOptions(merge: true));

    notifyListeners();
    // Notify the listeners of the state change
  }

  String name = 'Not Set';
  String email = 'Not Set';
  String bankDetails = 'Not Set';
  String phoneNumber = 'Not Set';
  String address = 'Not Set';
  String selectedDepartment = 'Not Set';
  String selectedSkill = 'Not Set';
  String selectedPost = 'Not Set';
  String selectedSkillType = 'Not Set';

  Future<void> getUserFormDataFromFirebaseDataBase() async {
    final DocumentSnapshot docSnapShot =
        await userCollection.doc(userEmail).get();
    final data = docSnapShot.data() as Map<String, dynamic>;

    if (docSnapShot.exists) {
      name = data['name'];
      email = data['email'];
      bankDetails = data['BankDetails'];
      phoneNumber = data['PhoneNumber'];
      address = data['Address'];
      selectedDepartment = data['Department'];
      selectedSkill = data['Skills'];
      selectedSkillType = data['SkillType'];
      selectedPost = data['Post'];
    }

    //List<String> fieldNames = ['name', 'BankDetails', 'PhoneNumber', 'Address', 'Department', 'Skills', 'SkillType', 'Post'];
    // for (String fieldName in fieldNames) {
    //   if (data.containsKey(fieldName)) {
    //     String fieldValue = data[fieldName].toString();
    //     userinfo.add(fieldValue);
    //   } else {
    //     userinfo.add('');
    //   }
    // }
    notifyListeners();
  }

  void updateName(String value) {
    name = value;
    notifyListeners();
  }

  void updateEmail(String value) {
    email = value;
    notifyListeners();
  }

  void updateBankDetails(String value) {
    bankDetails = value;
    notifyListeners();
  }

  void updatePhoneNumber(String value) {
    phoneNumber = value;
    notifyListeners();
  }

  void updateAddress(String value) {
    address = value;
    notifyListeners();
  }

  void updateSelectedDepartment(String value) {
    selectedDepartment = value;
    notifyListeners();
  }

  void updateSelectedSkill(String value) {
    selectedSkill = value;
    notifyListeners();
  }

  void updateSelectedPost(String value) {
    selectedPost = value;
    notifyListeners();
  }

  void updateSelectedSkillType(String value) {
    selectedSkillType = value;
    notifyListeners();
  }

  int generateRandomNumberExperince() {
    Random random = Random();
    int min = 0;
    int max = 10;
    return min + random.nextInt(max - min);
  }

  int generateRandomNumbern_client() {
    Random random = Random();
    int min = 1;
    int max = 100;
    return min + random.nextInt(max - min);
  }

  int generateRandomNumbernTestScore() {
    Random random = Random();
    int min = 10;
    int max = 100;
    return min + random.nextInt(max - min);
  }

  int generateRandomNumbernEquity() {
    Random random = Random();
    int min = 1;
    int max = 10;
    return min + random.nextInt(max - min);
  }

  int generateRandomNumbernAttendance() {
    Random random = Random();
    int min = 0;
    int max = 99;
    return min + random.nextInt(max - min);
  }

  int predictedSalary = 0000000;
  getSalary() async {
    final url = Uri.parse('http://salarypredictor.pythonanywhere.com/predict');

    // Create the request body
    final requestBody = jsonEncode({
      "job_role": selectedSkill,
      "attendance": 75,
      // "attendance": generateRandomNumbernAttendance(),
      "department": selectedDepartment,
      "post": selectedPost,
      "equity": 2,
      // "equity": generateRandomNumbernEquity(),
      "experience": 2,
      // "experience": generateRandomNumberExperince(),
      "n_clients": 20,
      // "n_clients": generateRandomNumbern_client(),
      "test_scores": 50,
      // "test_scores": generateRandomNumbernTestScore(),
      "skills": []
    });

    // Set the request headers
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    // Send the POST request
    final response = await http.post(url, headers: headers, body: requestBody);

    // Handle the response
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      predictedSalary = responseData["Predicted Salary"] as int;

      // Request successful
      if (kDebugMode) {
        print('POST request successful');
      }
      if (kDebugMode) {
        print(response.body);
      }
    } else {
      // Request failed
      if (kDebugMode) {
        print('POST request failed');
      }
      if (kDebugMode) {
        print('Status code: ${response.statusCode}');
      }
      if (kDebugMode) {
        print('Response body: ${response.body}');
      }
    }
  }
}

class LeaveProvider extends ChangeNotifier {
  Leave? leave;

  void setLeave(Leave? newLeave) {
    leave = newLeave;
    notifyListeners();
  }
}

// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final String labelText;
  final Function(String) onChanged;

  const TextInput({
    Key? key,
    required this.validator,
    required this.controller,
    required this.labelText,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TextFormField(
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        controller: controller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(14),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          ),
          labelText: labelText,
          labelStyle: const TextStyle(color: Color(0xFF212B66)),
        ),
        validator: validator,
        onChanged: onChanged,
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomCard extends StatefulWidget {
  String rating;
  String unDone;
  String star;
  CustomCard({
    Key? key,
    required this.rating,
    required this.unDone,
    required this.star,
  }) : super(key: key);

  @override
  State<CustomCard> createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      shape: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      color: const Color(0xF7FE9D02),
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 8),
            child: Row(children: [
              Text(
                "${widget.rating}/5",
                style: GoogleFonts.kadwa(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ]),
          ),
          Text(widget.star),
          Row(
            children: [
              Checkbox(
                checkColor: const Color(0xFF212B66),
                value: isChecked,
                onChanged: (value) {
                  setState(() {
                    isChecked = value ?? false;
                  });
                },
              ),
              Flexible(
                child: Text(
                  widget.unDone,
                  softWrap: true,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class SalaryCard extends StatefulWidget {
  String title;
  double salary;
  SalaryCard({
    Key? key,
    required this.title,
    required this.salary,
  }) : super(key: key);

  @override
  State<SalaryCard> createState() => _SalaryCardState();
}

class _SalaryCardState extends State<SalaryCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text("₹ ${widget.salary.toStringAsFixed(2)}",
            style: const TextStyle(fontWeight: FontWeight.bold)),
      ]),
    );
  }
}
