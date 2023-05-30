import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
