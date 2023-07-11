import 'package:dio/dio.dart';
import 'package:enterprise_project/custom/theme.dart';
import 'package:enterprise_project/custom/utils/constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../../custom/button/custom_button.dart';
import '../../../custom/textfield/custom_dateTime.dart';
import '../../../custom/textfield/custom_textfield.dart';


class RegisterWidget extends StatefulWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  State<RegisterWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  TextEditingController _firstName = TextEditingController();
  TextEditingController _middleName = TextEditingController();
  TextEditingController _lastName = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _dob = TextEditingController();
  TextEditingController _gender = TextEditingController();
  TextEditingController _role = TextEditingController();

  bool _isLoading = false;
  final form = GlobalKey<FormState>();

  @override
  void initState() {
    _dob.text = ""; //set the initial value of text field
    super.initState();
  }
  // Assign the onChanged callback function

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
                  decoration: BoxDecoration(
                    color: CustomTheme.whiteText,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Create new account",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 155, 152, 152)),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Form(
                          key: form,
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 20),
                                CustomTextField(
                                  lableText: "First name",
                                  // hintText: "Enter your first name",
                                  controller: _firstName,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "First name is required";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  lableText: "Middle name",
                                  // hintText: "Enter your middle name",
                                  controller: _middleName,
                                ),
                                CustomTextField(
                                  lableText: "Last Name",
                                  // hintText: "Enter your last name",
                                  controller: _lastName,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Last name is required";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  lableText: "Address",
                                  // hintText: "Enter your address",
                                  controller: _address,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Address is required";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  lableText: "Contact No.",
                                  keyboardType: TextInputType.phone,
                                  // hintText: "Enter your contact",
                                  controller: _contact,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Contact is required";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomTextField(
                                  lableText: "Gender",
                                  controller: _gender,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Gender is required";
                                    }
                                    return null;
                                  },
                                ),
                                // CustomDropDown(
                                //     lableText: "Gender",
                                //     hint: "Select Gender",
                                //     dropdownItems: ['Male', 'Female', 'Others'],
                                //     validator: (value) {
                                //       if (value == null || value.isEmpty) {
                                //         return "Gender is required";
                                //       }
                                //       return null;
                                //     },
                                //     onChanged: (value) {
                                //       setState(() {
                                //         _selectedGender = value;
                                //       });
                                //     }),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomDateTime(
                                  controller: _dob,
                                  onPressed: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2028));
                                    DateFormat date = DateFormat(
                                        "yyyy-MM-dd");
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    validator:
                                    (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Date is required";
                                      }
                                      return null;
                                    };
                                    if (pickedDate != null) {
                                      print(pickedDate);
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      print(formattedDate);
                                      setState(() {
                                        _dob.text = formattedDate;
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                CustomTextField(
                                  lableText: "Role: User or Rescue",
                                  // hintText: "Rescuer or user",
                                  controller: _role,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Role is required";
                                    }
                                    return null;
                                  },
                                ),

                                // CustomDropDown(
                                //     lableText: "Role",
                                //     hint: "Select role",
                                //     dropdownItems: ['User', 'Rescue'],
                                //     validator: (value) {
                                //       if (value == null || value.isEmpty) {
                                //         return "Role is required";
                                //       }
                                //       return null;
                                //     },
                                //     onChanged: (value) {
                                //       setState(() {
                                //         _selectedRole = value;
                                //       });
                                //     }),
                                CustomTextField(
                                  lableText: "Password",
                                  // hintText: "Password",
                                  obscureText: true,
                                  controller: _password,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Password is required";
                                    }
                                    return null;
                                  },
                                ),
                                CustomTextField(
                                  lableText: "Confirm Password",
                                  hintText: "Confirm Password",
                                  obscureText: true,
                                  controller: _confirmPassword,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Confirm Password is required";
                                    }
                                    if (value != _password.text) {
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0),
                          child: CustomButton(
                            title: "Sign Up",
                            onPressed: () async {
                              if (form.currentState!.validate()) {
                                try {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  final _dio = Dio();
                                  final Map<String, dynamic> _data = {
                                    "firstName": _firstName.text,
                                    "lastName": _lastName.text,
                                    "middleName": _middleName.text,
                                    "password": _password.text,
                                    "address": _address.text,
                                    "contactNo": _contact.text,
                                    "gender": _gender.text,
                                    "dob": _dob.text,
                                    "role": _role.text,
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
                                } finally {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 30),
                        Container(
                          child: RichText(
                              text: TextSpan(
                                  text: "Already have account ?  ",
                                  style: TextStyle(
                                    color: CustomTheme.textColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  children: [
                                TextSpan(
                                    text: "Login",
                                    style: TextStyle(
                                      color: CustomTheme.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context)
                                            .pushNamed('/login');
                                      }),
                              ])),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
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
