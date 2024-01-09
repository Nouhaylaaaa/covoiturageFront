// ignore_for_file: file_names, prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print

import 'dart:io';

import 'package:covoituragefront/interfaces/pages/Profile.dart';
import 'package:covoituragefront/interfaces/pages/loginPage.dart';
import 'package:covoituragefront/interfaces/pages/offer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SidBarHomePage extends StatefulWidget {
  const SidBarHomePage({super.key});

  @override
  State<SidBarHomePage> createState() => _SidBarHomePageState();
}

class _SidBarHomePageState extends State<SidBarHomePage> {
  Future<String> getUserData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8080/userName'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<String> getUserEmail() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/userEmail'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load user email');
    }
  }

  Future<String> getUserImage() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/userImage'));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load user image');
    }
  }

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
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: FutureBuilder<String>(
              future: getUserData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  return Text(
                    snapshot.data ?? 'No name available',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  );
                }
              },
            ),
            accountEmail: FutureBuilder<String>(
              future: getUserEmail(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error : ${snapshot.error}');
                } else {
                  return Text(
                    snapshot.data ?? 'No email available',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  );
                }
              },
            ),
            currentAccountPicture: FutureBuilder<String>(
              future: getUserImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error loading image: ${snapshot.error}');
                } else {
                  String? imageUrl = snapshot.data;

                  if (imageUrl != null && imageUrl.isNotEmpty) {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(File(imageUrl)),
                    );
                  } else {
                    return CircleAvatar(
                      radius: 50,
                      child: Image.asset(
                        'lib/interfaces/images/user.png',
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return const Text('Failed to load image');
                        },
                      ),
                    );
                  }
                }
              },
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('lib/interfaces/images/purple.jpg'),
              fit: BoxFit.fill,
            )),
          ),
          ListTile(
            leading: Icon(Icons.person), // User icon
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Profile()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.add), // Plus icon for posting an offer
            title: Text('Post Offer'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Offer()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.chat), // Plus icon for posting an offer
            title: Text('chat'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Offer()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.logout), // Logout icon
            title: Text('Logout'),
            onTap: logoutUser,
          )
        ],
      ),
      // Add more ListTiles for additional items
    );
  }
}
