// ignore_for_file: camel_case_types, prefer_const_constructors

import 'package:flutter/material.dart';

class splash_screen extends StatefulWidget {
  final Widget? child;

  const splash_screen({super.key, this.child});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => widget.child!),
          (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 400,
            height: 299,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage('lib/interfaces/images/purple.jpg'),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: 305,
            height: 204,
            child: Text(
              "Sharing a ride, sharing the journey. \n\nTogether, let's pave the way for a greener, connected tomorrow",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 122, 11, 117),
                fontSize: 30,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
                height: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
