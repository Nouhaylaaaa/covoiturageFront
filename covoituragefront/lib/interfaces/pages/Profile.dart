// ignore_for_file: prefer_const_constructors, unused_field, sort_child_properties_last, prefer_const_literals_to_create_immutables, avoid_print, file_names

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File? _image;
  final picker = ImagePicker();

  Future<void> selectImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Container(
              width: 380,
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
            height: 20,
          ),
          Flexible(
            child: FutureBuilder<String>(
              future: getUserImage(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error loading image: ${snapshot.error}');
                } else {
                  ImageProvider imageProvider;
                  if (snapshot.data != null) {
                    final imageData = snapshot.data!;
                    if (imageData.isNotEmpty) {
                      imageProvider = MemoryImage(base64Decode(imageData));
                    } else {
                      imageProvider =
                          AssetImage('lib/interfaces/images/user.png');
                    }
                  } else {
                    imageProvider =
                        AssetImage('lib/interfaces/images/user.png');
                  }

                  if (mounted) {
                    return CircleAvatar(
                      radius: 50,
                      backgroundImage: imageProvider,
                    );
                  } else {
                    return const SizedBox(); // Return an empty widget if unmounted
                  }
                }
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Text(
                'Name:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: FutureBuilder<String>(
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
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              SizedBox(
                width: 50,
              ),
              Text(
                'Email:',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  height: 0,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: FutureBuilder<String>(
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
                          color: Colors.black,
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
