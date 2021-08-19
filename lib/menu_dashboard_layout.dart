//url :-https://www.youtube.com/watch?v=VzuHfHyJcuI
import 'package:flutter/material.dart';

final Color backgroundColor = Color(0xFF000000);

class MenuDashBoardPage extends StatefulWidget {
  @override
  _MenuDashBoardPageState createState() => _MenuDashBoardPageState();
}

class _MenuDashBoardPageState extends State<MenuDashBoardPage> with SingleTickerProviderStateMixin{
  bool isCollapse = true;
  double screeenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds:200);

  AnimationController _controller;
  Animation<double> _scaleAnimation;
  Animation<double> _menuScaleAnimation;
  Animation<Offset> _slideAnimation;




  @override
  void initState() {
    super.initState();
    _controller=AnimationController(vsync: this,duration: duration);
    _scaleAnimation=Tween<double>(begin: 1,end: 0.6).animate(_controller);
    _menuScaleAnimation=Tween<double>(begin: 0.5,end: 1).animate(_controller);
    _slideAnimation=Tween<Offset>(begin: Offset(-1,0),end: Offset(0,0),).animate(_controller);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screeenWidth = size.width;
    screenHeight = size.height;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: <Widget>[menu(context), dashboard(context)],
      ),
    );
  }

  Widget menu(context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Align(
        alignment: Alignment.centerLeft,
        child: ScaleTransition(
          scale: _menuScaleAnimation,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 0, left: 16, right: 0, top: 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Messages",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Utility Bill",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Funds Transef",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "Branches",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      curve: Curves.decelerate,
      top: 0,
      bottom: 0,
      left: isCollapse ? 0 : 0.5 * screeenWidth,
      right: isCollapse ? 0 : -0.4 * screeenWidth,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Material(
          borderRadius: BorderRadius.all(Radius.circular(40)),
          elevation: 8,
          animationDuration: duration,
          color: backgroundColor,
          child: Container(
            padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: InkWell(
                        child: Icon(Icons.menu, color: Colors.white),
                        onTap: () {
                          setState(() {
                            if(isCollapse)
                              _controller.forward();
                            else
                              _controller.reverse();

                            isCollapse = !isCollapse;
                          });
                        },
                      ),
                    ),
                    Text(
                      "My Card",
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                    Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Container(
                  height: 150,
                  child: PageView(
                    controller: PageController(viewportFraction: 0.8),
                    scrollDirection: Axis.horizontal,
                    pageSnapping: false,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.redAccent,
                        width: 100,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.blueAccent,
                        width: 100,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.greenAccent,
                        width: 100,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
