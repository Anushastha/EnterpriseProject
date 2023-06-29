import 'package:dio/dio.dart';
import 'package:enterprise_project/custom/theme.dart';
import 'package:enterprise_project/features/user/screens/forgotpassword.dart';
import 'package:flutter/gestures.dart';
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
  bool _obscureTextPassword = true;
  bool _isLoading = false;
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
        isLoading: _isLoading,
        child: Scaffold(
          body: Container(
            width: double.infinity,
            color: CustomTheme.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 120, right: 120, top: 90, bottom: 20),
                  child: Text(
                    "LOGO",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    decoration: BoxDecoration(
                        color: CustomTheme.whiteText,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Login your account",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 155, 152, 152)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Form(
                            key: form,
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20),
                                CustomTextField(
                                  lableText: "Contact No",
                                  keyboardType: TextInputType.phone,
                                  // hintText: "Contact",
                                  controller: contact,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Contact is required";
                                    }
                                    return null;
                                  },
                                  suffixIcon: Icon(
                                    Icons.phone,
                                    size: 22.0,
                                    color: CustomTheme.lightText,
                                  ),
                                ),
                                CustomTextField(
                                  lableText: "Password",
                                  // hintText: "Password",
                                  controller: password,
                                  obscureText: _obscureTextPassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password is required";
                                    }

                                    return null;
                                  },
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _obscureTextPassword =
                                            !_obscureTextPassword;
                                      });
                                    },
                                    child: Icon(
                                      _obscureTextPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      size: 22.0,
                                      color: CustomTheme.lightText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed('/forgot_password');
                            },
                            child: Padding(
                              padding: EdgeInsets.only(left: 210, right: 0),
                              child: Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 39, 38, 38),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          Container(
                            // padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Center(
                              child: Column(
                                children: [
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
                                          final _response = await _dio.post(
                                              Constants.login,
                                              data: _data);
                                          print(_data);

                                          if (_response.statusCode! >= 200 &&
                                              _response.statusCode! <= 300) {
                                            final String role =
                                                _response.data['role'];
                                            print(_response.data);
                                            if (role == 'User') {
                                              Navigator.of(context)
                                                  .pushNamed('/userDashboard');
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Logged in successfully");
                                            } else if (role == 'Rescue') {
                                              Navigator.of(context).pushNamed(
                                                  '/rescueDashboard');
                                              Fluttertoast.showToast(
                                                  msg:
                                                      "Logged in successfully");
                                            }
                                          } else {
                                            Fluttertoast.showToast(
                                                msg:
                                                    _response.data["message"] ??
                                                        "Unable to login");
                                          }
                                        } on DioError catch (e) {
                                          Fluttertoast.showToast(
                                              msg: e.message);
                                        } catch (e) {
                                          Fluttertoast.showToast(
                                              msg: e.toString());
                                        } finally {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                        }
                                      }
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  Container(
                                    child: RichText(
                                        text: TextSpan(
                                            text: "Don't have account ?  ",
                                            style: TextStyle(
                                              color: CustomTheme.textColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                            children: [
                                          TextSpan(
                                              text: "Sign up",
                                              style: TextStyle(
                                                color: CustomTheme.green,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              recognizer: TapGestureRecognizer()
                                                ..onTap = () {
                                                  Navigator.of(context)
                                                      .pushNamed('/register');
                                                }),
                                        ])),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
