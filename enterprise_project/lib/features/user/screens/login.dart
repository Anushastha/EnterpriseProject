import 'package:dio/dio.dart';
import 'package:enterprise_project/features/user/screens/forgotpassword.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../custom/button/custom_button.dart';
import '../../../custom/textfield/custom_textfield.dart';
import '../../../custom/utils/constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();
  // bool showPassword = false;
  bool _isLoading = false;
  final form = GlobalKey<FormState>();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  // Future<void> loginUser() async {
  //   try {
  //     final user = (await _auth.signInWithEmailAndPassword(
  //             email: email.text, password: password.text))
  //         .user;
  //     if (user != null) {
  //       Navigator.of(context).pushReplacementNamed("/dashboard");
  //     }
  //     if (user != null) {
  //       print("Login Success");
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: Text(e.toString())));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
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
                            child: Form(
                              key: form,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 20),
                                  CustomTextField(
                                    lableText: "Contact No",
                                    hintText: "Contact",
                                    controller: contact,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Contact is required";
                                      }

                                      return null;
                                    },
                                  ),
                                  SizedBox(height: 20),
                                  CustomTextField(
                                    lableText: "Password",
                                    hintText: "Password",
                                    controller: password,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Password is required";
                                      }

                                      return null;
                                    },
                                  ),
                                ],
                              ),
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
                            onPressed: () async {
                              if (form.currentState!.validate()) {
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final _dio = Dio();

                                  final Map<String, dynamic> _data = {
                                    "password": password.text,
                                    "contactNo": contact.text,
                                  };
                                  final _response = await _dio
                                      .post(Constants.login, data: _data);

                                  if (_response.statusCode! >= 200 &&
                                      _response.statusCode! <= 300) {
                                    Fluttertoast.showToast(
                                        msg: "Logged in successfully");
                                    Navigator.of(context)
                                        .pushNamed('/dashboard');
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: _response.data["message"] ??
                                            "Unable to login");
                                  }
                                } on DioError catch (e) {
                                  Fluttertoast.showToast(msg: e.message);
                                } catch (e) {
                                  Fluttertoast.showToast(msg: e.toString());
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              }
                            },
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
      ),
    );
  }
}
