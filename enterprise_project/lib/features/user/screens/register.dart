import 'package:dio/dio.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:enterprise_project/custom/utils/constants.dart';
import 'package:enterprise_project/features/user/screens/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';

import '../../../custom/button/custom_button.dart';
import '../../../custom/textfield/custom_textfield.dart';
import '../../../model/user_model.dart';

class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  TextEditingController firstName = TextEditingController();
  TextEditingController middleName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  TextEditingController gender = TextEditingController();
  TextEditingController dob = TextEditingController();
  bool _isLoading = false;
  // bool showPassword = false;
  final form = GlobalKey<FormState>();
  // String? gender;
  // var confirmPass;

  // bool _isLoading = false;

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isLoading,
      child: Scaffold(
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
                                  SizedBox(height: 20),
                                  CustomTextField(
                                    lableText: "First name",
                                    hintText: "Enter your first name",
                                    controller: firstName,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "First name is required";
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextField(
                                    lableText: "Middle name",
                                    hintText: "Enter your middle name",
                                    controller: middleName,
                                  ),
                                  CustomTextField(
                                    lableText: "Last Name",
                                    hintText: "Enter your last name",
                                    controller: lastName,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Last name is required";
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextField(
                                    lableText: "Address",
                                    hintText: "Enter your address",
                                    controller: address,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Address is required";
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextField(
                                    lableText: "Contact No.",
                                    hintText: "Enter your contact",
                                    controller: contact,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Contact is required";
                                      }
                                      return null;
                                    },
                                  ),
                                  CustomTextField(
                                    lableText: "Gender",
                                    hintText: "Enter your gender",
                                    controller: gender,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Gender is required";
                                      }
                                      return null;
                                    },
                                  ),
                                  TextFormField(
                                      controller: dob,
                                      decoration: InputDecoration(
                                        labelText: "Date of birth",
                                        // hintText: "Insert your dob",
                                      ),
                                      onTap: () async {
                                        // DateTime date = DateTime(1900);
                                        DateFormat date = DateFormat(
                                            "yyyy-MM-dd'T'HH:mm:ss.SSSZ");
                                        FocusScope.of(context)
                                            .requestFocus(new FocusNode());
                                      }),
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
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            title: "Register",
                            onPressed: () async {
                              if (form.currentState!.validate()) {
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final _dio = Dio();
                                  final Map<String, dynamic> _data = {
                                    "firstName": firstName.text,
                                    "lastName": lastName.text,
                                    "middleName": middleName.text,
                                    "password": password.text,
                                    "address": address.text,
                                    "contactNo": contact.text,
                                    "gender": gender.text,
                                    "dob": dob.text,
                                  };
                                  final _response = await _dio
                                      .post(Constants.users, data: _data);
                                  if (_response.statusCode! >= 200 &&
                                      _response.statusCode! <= 300) {
                                    Fluttertoast.showToast(
                                        msg: "Registered successfully");
                                    Navigator.of(context).pushNamed('/login');
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: _response.data["message"] ??
                                            "Unable to registered");
                                  }
                                } on DioError catch (e) {
                                  Fluttertoast.showToast(msg: e.message);
                                } catch (e) {
                                  Fluttertoast.showToast(msg: e.toString());
                                }
                                finally{
                                  setState(() {
                                    _isLoading= false;
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
