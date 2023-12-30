// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:covoituragefront/interfaces/pages/Profile.dart';
import 'package:covoituragefront/interfaces/pages/offer.dart';
import 'package:covoituragefront/interfaces/pages/signupPage.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              width: 400,
              height: 150,
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
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
              child: Container(
                width: 100,
                height: 50,
                decoration: ShapeDecoration(
                  color: Color(0xFF471AA0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 100,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => SignUp()),
                  (route) => false,
                );
              },
              child: Container(
                width: 100,
                height: 50,
                decoration: ShapeDecoration(
                  color: Color(0xFF471AA0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ]),
          SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 250,
                  height: 50,
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: Color(0xFF9747FF)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Destination',
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                          fontSize: 15,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                        ),
                        border: InputBorder.none,
                      ),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black, // Change text color when typing
                        fontSize: 15,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )),
              SizedBox(
                width: 10,
              ),
              Stack(children: [
                Container(
                  width: 45,
                  height: 50,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1, color: Color(0xFF471AA0)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                Positioned(
                    child: Container(
                  width: 40,
                  height: 45,
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                )),
              ]),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Center(
              child: SizedBox(
                  width: 310,
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Offer()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF9747FF),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 2, color: Color(0xFF471AA0)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      'Click if you want to suggest a traject',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  )))
        ],
      ),
    );
  }
}
