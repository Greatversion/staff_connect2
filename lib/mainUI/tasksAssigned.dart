import 'package:flutter/cupertino.dart';

import 'package:google_fonts/google_fonts.dart';

class TasksAssigned extends StatefulWidget {
  const TasksAssigned({super.key});

  @override
  State<TasksAssigned> createState() => _TasksAssignedState();
}

class _TasksAssignedState extends State<TasksAssigned> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "NO TASK ASSIGNED",
            style: GoogleFonts.kanit(fontSize: 30),
          ),
          const Icon(CupertinoIcons.asterisk_circle_fill)
        ],
      ),
    );
  }
}
