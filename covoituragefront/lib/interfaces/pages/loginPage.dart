// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_element, prefer_final_fields, use_build_context_synchronously, avoid_print, file_names

import 'dart:convert';

import 'package:covoituragefront/interfaces/pages/homepage.dart';
import 'package:covoituragefront/interfaces/pages/signupPage.dart';
import 'package:covoituragefront/interfaces/widgets/formWidget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  Future<void> loginUser() async {
    final url = Uri.parse('http://localhost:8080/login');
    final userCredentials = {
      'email': _emailController.text,
      'password': _passwordController.text,
    };

    try {
      final response = await http.post(
        url,
        body: json.encode(userCredentials),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        // Login successful, navigate to home page or desired screen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Handle login failure, show error message or perform other actions
      }
    } catch (error) {
      // Handle exceptions or network errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
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
            SizedBox(
              height: 20,
            ),
            Text(
              'Sign In',
              style: TextStyle(
                color: Color(0xFF471AA0),
                fontSize: 30,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: FormContainerWidget(
                hintText: "Email",
                isPasswordField: false,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: FormContainerWidget(
                hintText: "Password",
                isPasswordField: true,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: loginUser,
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
                  'Sign In',
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
                Text("Don't have an account?"),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                      (route) => false,
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
