import 'package:covid_19_tracker/Views/Covid_19_mainPage.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
class Details_screen extends StatefulWidget {
  String name, image;
  int cases,todaycases,death,todaydeath,recoverd,todayrecoverd,active,critical;
   Details_screen({
    Key?
  key,
    required this.name,
     required this.image,
     required this.cases,
     required this.todaycases,
     required this.death,
     required this.todaydeath,
     required this.recoverd,
     required this.todayrecoverd,
     required this.active,
     required this.critical
  }) : super(key: key);

  @override
  State<Details_screen> createState() => _Details_screenState();
}

class _Details_screenState extends State<Details_screen> with TickerProviderStateMixin{

  late final AnimationController animationController = AnimationController(
    duration: const  Duration(seconds: 3),
      vsync: this)..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    animationController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Row(
          children: [
            SizedBox(height: 50,width: 60,child: Image(image: NetworkImage(widget.image),),),
            const SizedBox(width: 5,),
            Text(widget.name),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Card(
            margin: EdgeInsets.only(top: 210, left: 20,right: 20),
            color: Colors.grey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ReusableRow(title: "cases", value: widget.cases.toString()),
                ReusableRow(title: "recovered", value: widget.recoverd.toString()),
                ReusableRow(title: "death", value: widget.death.toString()),
                ReusableRow(title: "critical", value: widget.critical.toString()),
                ReusableRow(title: "active", value: widget.active.toString()),
              ],
            ),
          ),

          AnimatedBuilder(
            animation: animationController,
            child: Container(
                margin: const EdgeInsets.only(bottom: 600),
                child: const Image(image: AssetImage("images/virus.png"))),
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(angle: animationController.value * 2.0 * math.pi,
                child: child,
              );

            },
          )
        ],
      )
    );
  }
}
