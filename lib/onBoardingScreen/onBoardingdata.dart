// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class OnbordingData extends StatefulWidget {
  late Color? color;
  final imagePath;
  final title;
  final desc;

  OnbordingData({super.key, this.color, this.imagePath, this.title, this.desc});

  @override
  // ignore: library_private_types_in_public_api
  _OnbordingDataState createState() =>
      _OnbordingDataState(this.color, this.imagePath, this.title, this.desc);
}

class _OnbordingDataState extends State<OnbordingData> {
  late Color? color;
  // ignore: prefer_typing_uninitialized_variables
  final imagePath;
  // ignore: prefer_typing_uninitialized_variables
  final title;
  // ignore: prefer_typing_uninitialized_variables
  final desc;
  _OnbordingDataState(this.color, this.imagePath, this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28)),
          color: color),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.42,
            image: AssetImage(imagePath),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                title,
                softWrap: true,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 25,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              desc,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
