import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fmms/AddRequest/request.dart';
import 'package:fmms/HomePage/homepage.dart';
import 'package:fmms/AppBar/color.dart';
import 'package:fmms/AppBar/custom_paint.dart';
import 'package:fmms/AppBar/model.dart';
import 'package:fmms/AppBar/text_style.dart';
import 'package:fmms/HomePage/profile.dart';
 

 

 
class HomePage extends StatefulWidget {
  const HomePage({Key? key, required PageController controller}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectBtn = 0;
  late PageController _pageController;
  List<ScrollController> _scrollControllers = [];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: selectBtn);
    _scrollControllers = List.generate(4, (index) => ScrollController());
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                selectBtn = index;
              });
            },
            children: [
              HomeScreen(controller: _scrollControllers[0]),
              RequestPage(controller: _scrollControllers[1]),
              //Notification(controller: _scrollControllers[3]),
              Profile(controller: _scrollControllers[4]),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: navigationBar(),
          )
        ],
      ),
    );
  }

  AnimatedContainer navigationBar() {
    return AnimatedContainer(
      height: 70.0,
      duration: const Duration(milliseconds: 400),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(selectBtn == 0 ? 0.0 : 20.0),
          topRight: Radius.circular(selectBtn == 1 ? 0.0 : 20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int i = 0; i < 4; i++)
            GestureDetector(
              onTap: () {
                _scrollControllers[selectBtn].animateTo(
                  0,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
                _pageController.animateToPage(
                  i,
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              },
              child: iconBtn(i),
            ),
        ],
      ),
    );
  }

  SizedBox iconBtn(int i) {
    bool isActive = selectBtn == i ? true : false;
    var height = isActive ? 60.0 : 0.0;
    var width = isActive ? 50.0 : 0.0;
    return SizedBox(
      width: 75.0,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: AnimatedContainer(
              height: height,
              width: width,
              duration: const Duration(milliseconds: 600),
              child: isActive
                  ? CustomPaint(
                      painter: ButtonNotch(),
                    )
                  : const SizedBox(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              navBtn[i].imagePath,
              color: isActive ? selectColor : black,
              scale: 2,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              navBtn[i].name,
              style: isActive ? bntText.copyWith(color: selectColor) : bntText,
            ),
          )
        ],
      ),
    );
  }
}

