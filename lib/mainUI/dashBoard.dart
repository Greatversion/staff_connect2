import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staff_connect/mainUI/leaveApplication.dart';
import 'package:staff_connect/mainUI/notifications.dart';
import 'package:staff_connect/mainUI/settings.dart';
import 'package:staff_connect/mainUI/tasksAssigned.dart';
import 'package:staff_connect/mainUI/userDashboard.dart';
import 'package:staff_connect/utilities/bottomNavigationBar.dart';
import 'package:staff_connect/utilities/fadeAnimation.dart';
// import 'package:staff_connect/utilities/bottomNavigationBar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore store = FirebaseFirestore.instance;
final CollectionReference userCollection = store.collection('users');
final FirebaseStorage storage = FirebaseStorage.instance;

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  final GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();
  late String userEmail;
  String? downloadUrl;
  String? fileName;
  File? imageFile;
  int _selectedIndex = 0; // Track the selected index

  @override
  void initState() {
    super.initState();
    userEmail = _auth.currentUser!.email!;
    fetchImageUrl();
  }

  Future<void> fetchImageUrl() async {
    final DocumentSnapshot docSnapshot =
        await userCollection.doc(userEmail).get();
    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;
      setState(() {
        downloadUrl = data['photoUrl'];
      });
      print(downloadUrl);
    }
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
    setState(() {});
  }

  Future<void> signOut() async {
    await _auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.popAndPushNamed(context, 'onBoarding');
  }

  void _onIndexChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> titleList = [
      "User DashBoard",
      "My Tasks",
      "Apply for Application",
      "Settings"
    ];
    final List<Widget> widgetOptions = <Widget>[
      const UserDashBoard(),
      const TasksAssigned(),
      const LeaveApplication(),
      const SettingsPage(),
    ];

    var res = MediaQuery.of(context);
    return Scaffold(
      key: drawerKey,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context, SlidePageRoute(builder: (context) {
                  return const NotificationPage();
                }));
              },
              icon: const Icon(Icons.notifications_active_rounded)),
          _selectedIndex == 0
              ? IconButton(
                  onPressed: () {
                    _selectedIndex == 0 ? signOut() : null;
                  },
                  icon: const Icon(Icons.logout_rounded))
              : const Text("")
        ],
        leading: _selectedIndex == 0
            ? IconButton(
                onPressed: () {
                  drawerKey.currentState!.openDrawer();
                },
                icon: const Icon(Icons.menu),
              )
            : null,
        elevation: 10,
        backgroundColor: const Color(0xFF212B66),
        automaticallyImplyLeading: false,
        title: Text(titleList[_selectedIndex]),
      ),
      body: widgetOptions
          .elementAt(_selectedIndex), // Update the body based on selected index
      drawer: SafeArea(
        child: _selectedIndex == 0
            ? Drawer(
                backgroundColor: const Color(0xFFFE9F02),
                width: res.size.width * 0.7,
                child: Column(
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 12),
                        CircleAvatar(
                          radius: 65,
                          backgroundColor: const Color(0xFF212B66),
                          foregroundImage: downloadUrl != null
                              ? NetworkImage(downloadUrl!)
                              : null,
                          child: IconButton(
                              splashColor: Colors.black,
                              color: const Color(0xFF212B66),
                              onPressed: () {
                                uploadImageToFirebaseStorage();
                              },
                              icon: const Icon(
                                Icons.add_a_photo,
                                size: 45,
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                            _auth.currentUser!.email!
                                .replaceFirst('@sconnect.in', '')
                                .toUpperCase(),
                            style: GoogleFonts.kanit(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const ListTile(
                      title: Text("hello"),
                    ),
                    const ListTile(
                      title: Text("hello"),
                    ),
                    const ListTile(
                      title: Text("hello"),
                    ),
                    const ListTile(
                      title: Text("hello"),
                    ),
                    const ListTile(
                      title: Text("hello"),
                    ),
                    const ListTile(
                      title: Text("hello"),
                    ),
                    const ListTile(
                      title: Text("hello"),
                    ),
                    const ListTile(
                      title: Text("hello"),
                    ),
                  ],
                ),
              )
            : const Text(""),
      ),
      bottomNavigationBar: CustomNavigationBar(
        onIndexChanged: _onIndexChanged, // Pass the callback function
      ),
    );
  }
}