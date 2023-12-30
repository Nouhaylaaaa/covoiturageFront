// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, sort_child_properties_last, no_leading_underscores_for_local_identifiers, unused_local_variable, must_be_immutable, unused_field, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_final_fields, unused_element, avoid_print, use_build_context_synchronously, file_names

import 'dart:convert';
import 'dart:typed_data';
import 'package:covoituragefront/interfaces/pages/homepage.dart';
import 'package:covoituragefront/interfaces/pages/loginPage.dart';
import 'package:covoituragefront/interfaces/widgets/formWidget.dart';
import 'package:covoituragefront/interfaces/widgets/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Uint8List? _image;

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Future<void> registerUser() async {
    print('Register button pressed');
    final url = Uri.parse('http://localhost:8080/register');
    final user = {
      'username': _usernameController.text,
      'image': base64Encode(_image!),
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    try {
      final response = await http.post(
        url,
        body: json.encode(user),
        headers: {'Content-Type': 'application/json'},
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        print('Registration successful');
        print(
            'Response body: ${response.body}'); // Print the response body for details
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        print("Error registering: ${response.body}");
      }
    } catch (error) {
      // Handle exceptions or network errors
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
              width: 350,
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
            height: 15,
          ),
          Flexible(
            child: Stack(
              children: [
                _image != null
                    ? CircleAvatar(
                        radius: 55,
                        backgroundImage: MemoryImage(_image!),
                      )
                    : CircleAvatar(
                        radius: 55,
                        backgroundImage:
                            AssetImage('lib/interfaces/images/user.png'),
                      ),
                Positioned(
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ),
                  bottom: -10,
                  left: 70,
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: FormContainerWidget(
              controller: _usernameController,
              hintText: "Name",
              isPasswordField: false,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FormContainerWidget(
              controller: _emailController,
              hintText: "Email",
              isPasswordField: false,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: FormContainerWidget(
              controller: _passwordController,
              hintText: "Password",
              isPasswordField: true,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: registerUser,
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF471AA0)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            child: Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                onTap: () {
                  // Call the signUp function here
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                    (route) => false,
                  );
                },
                child: Text(
                  "Sign In",
                  style: TextStyle(
                      color: Colors.purple, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
