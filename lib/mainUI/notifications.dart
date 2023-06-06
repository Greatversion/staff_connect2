import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:staff_connect/utilities/ReUsable_Functions.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  getSalary() async {}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context, listen: false);
    userDataProvider.getSalary();
    // sendSalaryData();
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  int? basepay;
  int? house;
  int? convi;
  int? intern;
  int? spcial;
  int? food;
  int? net;
  Future<void> sendSalaryData() async {
    await userCollection
        .doc(_auth.currentUser!.email)
        .collection("SalarySlip")
        .doc("Last Month Salary")
        .set({
      'base': basepay,
      'house': house,
      'convi': convi,
      'intern': intern,
      'spcial': spcial,
      'foof': food,
      'net': net,
    });
  }

  @override
  Widget build(BuildContext context) {
    UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
    var res = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.menu_book_rounded),
          backgroundColor: const Color(0xFF212B66),
          title: const Text("Notifications & Reports"),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          color: const Color(0xE4FE9D02),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      Text(
                        "No Notifications Received",
                        style: GoogleFonts.kanit(
                            fontWeight: FontWeight.bold, fontSize: 22),
                        softWrap: true,
                      ),
                      const SizedBox(height: 40),
                      const Icon(Icons.notifications_off_rounded, size: 50),
                    ],
                  ),
                ),
              ),

              // SizedBox(height: res.size.height * 0.7),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xFF212B66),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                // height: res.size.height*0.6,
                width: res.size.width,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Last Month Salary Slip 💴",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: res.size.height * 0.3,
                        width: res.size.width,
                        child: Card(
                          elevation: 15,
                          color: const Color(0xFFFE9D02),
                          child: Expanded(
                            child: Column(
                              children: [
                                SalaryCard(
                                    title: "Base Pay",
                                    salary: userDataProvider.predictedSalary *
                                        0.672),
                                SalaryCard(
                                    title: "House Rent Allowance",
                                    salary:
                                        userDataProvider.predictedSalary * 0.1),
                                SalaryCard(
                                    title: "Convenience Allowance",
                                    salary: userDataProvider.predictedSalary *
                                        0.088),
                                SalaryCard(
                                    title: "Internet Allowance",
                                    salary: userDataProvider.predictedSalary *
                                        0.05),
                                SalaryCard(
                                    title: "Special Allowance",
                                    salary: userDataProvider.predictedSalary *
                                        0.07),
                                SalaryCard(
                                    title: "Food Allowance",
                                    salary: userDataProvider.predictedSalary *
                                        0.02),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: res.size.width * 0.94,
                      child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                              "Net Salary : ₹ ${userDataProvider.predictedSalary}")),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
