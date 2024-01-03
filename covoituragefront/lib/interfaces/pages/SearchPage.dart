// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors, sized_box_for_whitespace, file_names, unnecessary_string_interpolations

import 'package:covoituragefront/interfaces/pages/Profile.dart';
import 'package:covoituragefront/interfaces/pages/loginPage.dart';
import 'package:covoituragefront/interfaces/widgets/OffersWidget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  final String destination;

  const SearchPage({Key? key, required this.destination}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<void> logoutUser() async {
    final logoutUrl = Uri.parse('http://10.0.2.2:8080/logout');

    try {
      final response = await http.delete(
        logoutUrl,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Logout successful, navigate to login page or perform necessary actions
        // For example, navigate back to the login page
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (Route<dynamic> route) => false, // Remove all previous routes
        );
      } else {
        // Handle other status codes or errors during logout
        print('Logout failed: ${response.statusCode}');
      }
    } catch (error) {
      // Handle exceptions or network errors during logout
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
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
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 100),
              GestureDetector(
                onTap: logoutUser,
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
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
                      hintText: widget.destination,
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
                      color: Colors.black,
                      fontSize: 15,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          OfferScreen(destination: widget.destination),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
