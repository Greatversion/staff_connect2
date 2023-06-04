// ignore: file_names
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:provider/provider.dart';

import 'package:staff_connect/mainUI/leaveApplication.dart';
import 'package:staff_connect/mainUI/notifications.dart';

import 'package:staff_connect/mainUI/tasksAssigned.dart';
import 'package:staff_connect/mainUI/userDashboard.dart';
import 'package:staff_connect/mainUI/userInfo.dart';
import 'package:staff_connect/utilities/ReUsable_Functions.dart';

import 'package:staff_connect/utilities/fadeAnimation.dart';

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
  PageController _pageController = PageController();
  late String userEmail;
  String? downloadUrl;
  String? fileName;
  File? imageFile;
  int _currentIndex = 0; // Track the selected index
  String? currentRegUser = _auth.currentUser!.email;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    userDataProvider.userEmail = _auth.currentUser!.email!;
    userDataProvider.fetchImageUrl();
    userDataProvider.getUserFormDataFromFirebaseDataBase();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutBack,
      );
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> signOut() async {
    await _auth.signOut().then((value) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Logging out...")));
      Navigator.popAndPushNamed(context, 'onBoarding');
      // Update the currentRegUser variable with the latest currentUser email value
      setState(() {
        currentRegUser = _auth.currentUser!.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);

    // whole widget rebuilds without listen:false
    final List<String> titleList = [
      "User DashBoard",
      "My Tasks 📝",
      "Apply For Leave 🗒️",
      "Edit Your Profile 👤"
    ];
    final List<Widget> widgetOptions = <Widget>[
      const UserDashBoard(),
      const TasksAssigned(),
      TableRangeExample(),
      const UserInformation(),
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
          // _currentIndex == 0
          //     ? IconButton(
          //         onPressed: () {
          //           _currentIndex == 0 ? signOut() : null;
          //         },
          //         icon: const Icon(Icons.logout_rounded))
          //     : const Text("")
        ],
        leading: _currentIndex == 0
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
        title: Text(
          titleList[_currentIndex],
          style: GoogleFonts.kanit(fontSize: 21),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: widgetOptions,
      ), // Update the body based on selected index
      drawer: SafeArea(
        child: _currentIndex == 0
            ? Drawer(
                backgroundColor: const Color(0xFFFE9F02),
                width: res.size.width * 0.7,
                child: Column(
                  children: [
                    Stack(alignment: Alignment.topCenter, children: [
                      Container(
                        color: const Color(0xFF212B66),
                        height: 215,
                        width: res.size.width * 0.7,
                      ),
                      Column(
                        children: [
                          const SizedBox(height: 12),
                          CircleAvatar(
                            radius: 65,
                            backgroundColor: const Color(0xFF212B66),
                            foregroundImage: userDataProvider.downloadUrl !=
                                    null
                                ? NetworkImage(userDataProvider.downloadUrl!)
                                : null,
                            child: IconButton(
                                splashColor: Colors.black,
                                color: Colors.white,
                                onPressed: () {
                                  userDataProvider
                                      .uploadImageToFirebaseStorage();
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
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ]),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        children: [
                          ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              leading: const Icon(
                                  CupertinoIcons.profile_circled,
                                  color: Colors.black),
                              title: const Text(
                                "Employee Name :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                userDataProvider.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              leading: const Icon(Icons.verified_user_rounded,
                                  color: Colors.black),
                              title: const Text(
                                "Designation :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                userDataProvider.selectedSkill,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              leading: const Icon(Icons.leaderboard,
                                  color: Colors.black),
                              title: const Text(
                                "Current Position :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                userDataProvider.selectedPost,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              leading: const Icon(
                                  Icons.supervisor_account_rounded,
                                  color: Colors.black),
                              title: const Text(
                                "Department :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                userDataProvider.selectedDepartment,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              leading: const Icon(Icons.pages_rounded,
                                  color: Colors.black),
                              title: const Text(
                                "Skills :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                userDataProvider.selectedSkillType,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          const Text(" _____________________________________"),
                          ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              leading: const Icon(Icons.phone_android,
                                  color: Colors.black),
                              title: const Text(
                                "Contact Number :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                userDataProvider.phoneNumber,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          ListTile(
                              titleAlignment: ListTileTitleAlignment.center,
                              leading: const Icon(Icons.business_center_rounded,
                                  color: Colors.black),
                              title: const Text(
                                "Billing Address :",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                userDataProvider.address,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "   Log Out",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  )),
                              const Text(
                                "Version 1.00.00 - ",
                                style: TextStyle(color: Colors.black54),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : const Text(""),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // unselectedIconTheme: ,
        selectedItemColor: Colors.red,
        unselectedFontSize: 12,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.kanit(
            fontWeight: FontWeight.w500, fontSize: 15, color: Colors.red),
        unselectedLabelStyle: GoogleFonts.kanit(color: Colors.black),

        // type: BottomNavigationBarType.shifting,
        backgroundColor: const Color(0xFF212B66),
        currentIndex: _currentIndex,
        onTap: _onNavItemTapped,
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              CupertinoIcons.home,
              color: Colors.red,
            ),
            backgroundColor: Color(0xFF060C2D),
            // backgroundColor: Colors.black,
            icon: Icon(
              Icons.home,
              size: 20,
              color: Color(0xFFFE9F02),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.task_alt_rounded,
              color: Colors.red,
            ),
            backgroundColor: Color(0xFF060C2D),
            icon: Icon(
              size: 20,
              Icons.task_alt_rounded,
              color: Color(0xFFFE9F02),
            ),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
              activeIcon: Icon(
                CupertinoIcons.calendar_badge_plus,
                color: Colors.red,
              ),
              backgroundColor: Color(0xFF060C2D),
              icon: Icon(
                size: 20,
                CupertinoIcons.calendar_badge_plus,
                color: Color(0xFFFE9F02),
              ),
              label: 'Leaves'),
          BottomNavigationBarItem(
              activeIcon: Icon(
                CupertinoIcons.profile_circled,
                color: Colors.red,
              ),
              backgroundColor: Color(0xFF060C2D),
              icon: Icon(
                size: 20,
                CupertinoIcons.profile_circled,
                color: Color(0xFFFE9F02),
              ),
              label: 'Profile'),
        ],
      ),
    );
  }
}
