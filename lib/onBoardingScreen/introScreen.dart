library flutteronboardingscreens;

import 'package:flutter/material.dart';
import 'package:staff_connect/onBoardingScreen/onBoardingdata.dart';
import 'package:staff_connect/utilities/fadeAnimation.dart';

/// A IntroScreen Class.
///
///
class IntroScreen extends StatefulWidget {
  final List<OnbordingData> onbordingDataList;
  final Widget pageRoute;

  const IntroScreen(this.onbordingDataList, this.pageRoute, {super.key});

  void skipPage(BuildContext context) {
    Navigator.push(context, MyFadeRoute(page: pageRoute));
  }

  @override
  IntroScreenState createState() {
    return IntroScreenState();
  }
}

class IntroScreenState extends State<IntroScreen> {
  final PageController controller = PageController();
  int currentPage = 0;
  bool lastPage = false;

  void _onPageChanged(int page) {
    setState(() {
      currentPage = page;
      if (currentPage == widget.onbordingDataList.length - 1) {
        lastPage = true;
      } else {
        lastPage = false;
      }
    });
  }

  OnbordingData colordata = OnbordingData(color: Colors.red);
  Widget _buildPageIndicator(int page) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2.0),
      height: page == currentPage ? 10.0 : 6.0,
      width: page == currentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: page == currentPage ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // Expanded(
            //   flex: 1,
            //   child: Container(),
            // ),
            Expanded(
              flex: 11,
              child: PageView(
                controller: controller,
                onPageChanged: _onPageChanged,
                children: widget.onbordingDataList,
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child: Text(lastPage ? "" : "SKIP",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0)),
                    onPressed: () => lastPage
                        ? null
                        : widget.skipPage(
                            context,
                          ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    // ignore: avoid_unnecessary_containers
                    child: Container(
                      child: Row(
                        children: [
                          _buildPageIndicator(0),
                          _buildPageIndicator(1),
                          _buildPageIndicator(2),
                        ],
                      ),
                    ),
                  ),
                  TextButton(
                    child: Text(lastPage ? "GOT IT" : "NEXT",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0)),
                    onPressed: () => lastPage
                        ? widget.skipPage(context)
                        : controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
