import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    var res = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: res.size.height,
          width: res.size.width,
          color: Colors.red,
          child: const Column(
            children: [],
          ),
        ),
      ),
    );
  }
}
