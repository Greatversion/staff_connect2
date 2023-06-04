// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
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
    });

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

  TextInput({
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
