import 'package:enterprise_project/screens/forgotpassword.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../custom/button/custom_button.dart';
import '../custom/textfield/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool showPassword = false;
  final form = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> loginUser() async {
    try {
      final user = (await _auth.signInWithEmailAndPassword(
              email: email.text, password: password.text))
          .user;
      if (user != null) {
        Navigator.of(context).pushReplacementNamed("/dashboard");
      }
      if (user != null) {
        print("Login Success");
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
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color(0xff022539),
          Color(0xff022539),
          Color(0xff022539)
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 250,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Login",
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
                        topRight: Radius.circular(60))),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20),
                              CustomTextField(
                                lableText: "Email address",
                                hintText: "Email address",
                                controller: email,
                              ),
                              SizedBox(height: 20),
                              CustomTextField(
                                lableText: "Password",
                                hintText: "Password",
                                obscureText: true,
                                controller: password,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ForgotPassword(),
                            ));
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(color: Colors.orange),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          title: "Login",
                          onPressed: loginUser,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
