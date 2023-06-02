// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
//setState
    notifyListeners(); // Notify the listeners of the state change
  }
}

class SelectedItemProvider extends ChangeNotifier {
  String? selectedItem;

  void setSelectedItem(String item) {
    selectedItem = item;
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

class UserInformationProvider with ChangeNotifier {
  String name = '';
  String email = '';
  String bankDetails = '';
  String phoneNumber = '';
  String selectedDepartment = 'Business Development';
  String selectedSkill = 'CEO (Chief Executive Officer)';
  String selectedPost = 'Entry Level/Junior';
  String selectedSkillType = 'Technical Skills';

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

// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  final FormFieldValidator<String> validator;
  final TextEditingController controller;
  final String labelText;
  Function onChanged;

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
      ),
    );
  }
}
