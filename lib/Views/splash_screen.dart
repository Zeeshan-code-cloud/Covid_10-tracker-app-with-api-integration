import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'Covid_19_mainPage.dart';

class splash_Screen extends StatefulWidget {
  const splash_Screen({Key? key}) : super(key: key);

  @override
  State<splash_Screen> createState() => _splash_ScreenState();
}

class _splash_ScreenState extends State<splash_Screen>
    with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this)
    ..repeat();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 4), () =>
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Covid_19_main())));
  }
    @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();

      _controller.dispose();
    }



    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200,
                  width: 200,
                  child: const Image(image: AssetImage("images/virus.png"),),
                ),
                builder: (BuildContext context, Widget?child) {
                  return Transform.rotate(
                    angle: _controller.value * 4.0 * math.pi,
                    child: child,
                  );
                }),
            SizedBox(height: MediaQuery
                .of(context)
                .size
                .height * 0.2,),
            const Center(child: Align(
              alignment: Alignment.center,
              child: Text("     Covid19\n App Trackker", style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey,
              ),),
            ),),
          ],
        ),
      );
    }
  }
