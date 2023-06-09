import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../custom/button/custom_button.dart';
import '../custom/textfield/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController phonenumber = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController email = TextEditingController();
  bool showPassword = false;
  final form = GlobalKey<FormState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> registerUser() async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      if (user != null) {
        print("User Created");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.green, content: Text("Register Success")));
        Navigator.of(context).pushReplacementNamed("/login");
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color(0xff022539),
              Color(0xff022539),
              Color(0xff022539),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 100,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Register",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Form(
                            key: form,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 60),
                                CustomTextField(
                                  lableText: "Email address",
                                  hintText: "Email address",
                                  controller: email,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Email is required";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                CustomTextField(
                                  lableText: "Password",
                                  hintText: "Password",
                                  obscureText: true,
                                  controller: password,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password is required";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                CustomTextField(
                                  lableText: "Confirm Password",
                                  hintText: "Confirm Password",
                                  obscureText: true,
                                  controller: confirmPassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Confirm Password is required";
                                    }
                                    if (value != password.text) {
                                      return "Passwords do not match";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                CustomTextField(
                                  lableText: "Phone Number",
                                  hintText: "Phone Number",
                                  controller: phonenumber,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Phone Number is required";
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          title: "Register",
                          onPressed: () {
                            if (form.currentState!.validate()) {
                              registerUser();
                            } else {
                              print("Invalid");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
