// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously, avoid_print, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:covoituragefront/interfaces/pages/SearchPage.dart';
import 'package:covoituragefront/interfaces/pages/loginPage.dart';

import 'package:covoituragefront/interfaces/pages/sidebarHomePage.dart';
import 'package:covoituragefront/interfaces/widgets/getAllOffers.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController destinationController = TextEditingController();
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

  bool _shouldRefreshOffers = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refreshOffersOnReturn();
  }

  void _refreshOffersOnReturn() {
    final routeArgs = ModalRoute.of(context)?.settings.arguments;
    if (routeArgs != null && routeArgs is bool && routeArgs) {
      setState(() {
        _shouldRefreshOffers = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(40), // Adjust the height as needed
          child: AppBar(
            backgroundColor: Color(0xFF471AA0),
          )),
      drawer: SidBarHomePage(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 10,
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
                          controller: destinationController,
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
                            color:
                                Colors.black, // Change text color when typing
                            fontSize: 15,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      String enteredDestination = destinationController.text;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              SearchPage(destination: enteredDestination),
                        ),
                      );
                    },
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      side: BorderSide(width: 1, color: Color(0xFF471AA0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    label: Container(
                      width: 0,
                      height: 45,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 50,
              ),
              SizedBox(
                height: 400,
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      // Trigger the refresh manually
                      _shouldRefreshOffers = true;
                    });
                  },
                  child: GetOffers(shouldRefresh: _shouldRefreshOffers),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
